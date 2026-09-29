mob/proc
	UseSkillProc(var/Skill2Call)
		if(!src || !Skill2Call)	return
		if(Skill2Call=="Bankai" && src.ChainHead)
			src.icon_state="";src.CanMove=1;src.TurnMode=0
			src.ChainHead.Destroy();return
		if(!src.CanMove)	return
		if(!src.SpiritForm)	{QuestShow(src,"Spirit Form to Use Skills");return}
		if(Skill2Call in ShikaiSkillNames)
			if(!src.Shikai && !src.Bankai)	{QuestShow(src,"Shikai to Use this Skill");return}
		if(Skill2Call in BankaiSkillNames)
			if(!src.Bankai)	{QuestShow(src,"Bankai to Use this Skill");return}
		if(src.Stunned)	return
		if(src.Chatting)	return
		if(src.SkillBeingCharged)	return
		for(var/obj/O in src.Skills+src.Kidous+src.Spells)
			if(O.name==Skill2Call)
				if(O:CoolDown)
					//QuestShow(src,"[O:CoolDown/10] Second CoolDown");return
					return
				O:CoolDown=O:MaxCoolDown;break
		if(src.Target)
			if(MyGetDist(src,src.Target)<=src.SightRange)
				if(src.AutoSkillFace)	src.dir=get_dir(src,src.Target)
			else	src.TargetMob(null)
		if(Skill2Call in ChargeableSkills)	src.SkillBeingCharged=Skill2Call
		return call(src,"[Skill2Call]")()
mob/verb
	UseSkill()
		set hidden=1
		src.UseSkillProc(src.CurSkill)
	ReleaseSkill()
		set hidden=1
		if(!src.SkillBeingCharged)	return
		var/Skill2Use=src.SkillBeingCharged
		src.SkillBeingCharged=null
		call(src,"[Skill2Use] Release")()
	LowAttack()
		set hidden=1
		if(src.Chatting)	return
		if(src.SpiritForm)
			if(src.Class=="Soul Reaper")	src.Attack(1)
			if(src.Class=="Quincy")	src.CreateArrow()
			if(src.Class=="Bount")
				for(var/mob/Pets/P in src.Pets)	if(MyGetDist(src,P)<=9)
					P.Thinking=0
	MidAttack()
		set hidden=1
		if(src.Chatting)	return
		if(src.SpiritForm)
			if(src.Class=="Soul Reaper")	src.Attack(2)
			if(src.Class=="Quincy")	src.PullArrow()
			if(src.Class=="Bount")
				for(var/mob/Pets/P in src.Pets)	if(MyGetDist(src,P)<=9)
					P.ActivateAI()
	HighAttack()
		set hidden=1
		src.overlays-=PressF
		if(src.Chatting)
			for(var/obj/HUD/OnScreenText/Next/T in src.client.screen)	T.Click(src)
			return
		for(var/obj/NPC/N in get_step(src,src.dir))
			for(var/datum/QuestDatum/D in src.Quests)
				for(var/datum/ObjectiveDatum/O in D.Objectives)
					if(O.Objective=="Speak With")
						if(O.Stat==N.name)
							PlayMenuSound(src,'TP_Talk_Start.wav')
							src.QuestComplete(D.ExpReward,D.name,D.GoldReward,D.SilverReward,D.CopperReward,D.ItemReward)
			N.DblClick(src)
			return
		if(src.SpiritForm)
			if(src.Class=="Soul Reaper")	src.Attack(3)
			if(src.Class=="Quincy")	src.FireArrow()
			if(src.Class=="Bount")	src.Attack(3)
	Defend()
		set hidden=1
		if(!src.CanBlock())	return
		for(var/mob/Enemy/M in oview(1,src))	if(src in get_step(M,M.dir))
			if(M.Pulling==1 && src.CounterStep(M))
				if(src.client)	for(var/obj/HUD/ComboSysHud/C in src.client.screen)
					if(C.icon_state!="Hit")	C.icon_state="No"
				return
		src.Guard()

	SpiritFormVerb()
		set hidden=1
		if(src.SpiritForm)	src.ActivateOverDrive()
		else	src.SpiritForm()
	EnterBody()
		set hidden=1
		if(!src.SpiritForm)	return
		if(src.icon_state=="CreateArrow"||src.icon_state=="PullArrow")	return
		src.Revert()

	AutoTargetAlly()
		set hidden=1
		for(var/mob/M in oview(src,src.SightRange))
			if(istype(M,/mob/Enemy))	continue
			if(istype(src.Target,/mob/Enemy))	src.TargetMob(null)
			if(!src.Target)	src.TargetMob(M)
			if(M.STM<=src.Target.STM)
				if(src.AutoTargetFace)	src.dir=get_dir(src,M)
				src.TargetMob(M)
	AutoTarget()
		set hidden=1
		for(var/mob/Enemy/M in oview(src,src.SightRange))
			src.TargetMob(null)
			if(src.AutoTargetFace)	src.dir=get_dir(src,M)
			src.TargetMob(M);return

mob/proc/FlashAssault(var/mob/M)
	for(var/obj/Skills/SoulReaper/Flash_Assault/F in src.Skills)
		if(MyGetDist(src,M)>=2 && MyGetDist(src,M)<=F.Level*2)
			var/turf/T=get_step(M,get_dir(src,M))
			if(T && T.Enter(src))
				src.TargetMob(M)
				MyFlick("Warp",src)
				src.loc=T;T.Entered(src)
				src.dir=get_dir(src,M)
				M.StunProc(1,"Stun",src)

mob/proc/CounterStep(var/mob/M)
	MyFlick("Warp",src)
	src.TargetMob(M)
	src.AttackHeight=0
	src.ComboCount=0
	src.Blocking=0
	src.CanMove=1
	src.ComboStopper=rand(1,999999)
	if(src.icon_state=="Block")	src.icon_state="Stance"
	var/turf/T=get_step(M,get_dir(src,M))
	if(T.Enter(src))
		src.loc=T;T.Entered(src)
		src.dir=get_dir(src,M)
	else	return
	return 1

mob/verb/CancelTarget()
	set hidden=1
	usr.TargetMob(null)
	if(usr.icon_state=="Stance")	usr.icon_state=""

mob/proc/TargetMob(var/mob/Enemy/M)
	if(src.client)	for(var/image/I in src.client.images)	if(I.name=="TargetUnder")	{src.client.images-=I;del I}
	if(!M)	{src.Target=null;return}
	if(istype(M,/mob/Enemy))
		if(istype(src,/mob/Enemy))	return
		if(!M.StartedBy && M.z!=8)
			M.TargetMob(src);M.StartedBy=src
			src.LevelShiftEnemy(M)
			spawn(rand(0,5))	if(M)	M.EnemyAI()
	src.Target=M
	if(src.client)
		var/image/I=image('Effects.dmi',M,"Target",M.layer-2,SOUTH)
		I.name="TargetUnder";src.client<<I

mob/proc/CanBlock()
	if(src.Stunned)	return
	if(src.Blocking)	return
	if(src.Chatting)	return
	if(!src.SpiritForm)	return
	if(src.SkillBeingCharged)	return
	if(src.Class!="Soul Reaper")	return
	if("Scatter" in src.ToggledSkills)	return
	if(!src.CanMove && src.ComboCount<=1)	return
	return 1

obj/Projectile
	density=1
	var/Str=0
	var/Dist=0
	var/mob/Owner
	var/ArrowType
	var/atom/MyTarget
	Dragons
		IceDragon
			icon='IceDragon.dmi'
		FireDragon
			icon='FireDragon.dmi'
	FireBall
		icon='Effects.dmi'
		icon_state="Red Flame Cannon"
	Arrow
		icon='SkillEffects.dmi'
		icon_state="Arrow"
	ThreeWide
		var/obj/Projectile/ThreeWide/Center
		var/list/Parts=list()
		Getsuga
			icon='Effects.dmi'
			icon_state="Getsuga"
		Black_Getsuga
			icon='Effects.dmi'
			icon_state="BlackGetsuga"
		New(var/Nstr,var/Ndist,var/Ndir,var/atom/Nloc,var/Nowner,var/Ncenter)
			src.Center=Ncenter
			if(src.Center)	src.icon_state="invis"
			else
				if(Ndir==NORTH)
					var/obj/OA=new;OA.icon=src.icon;OA.icon_state="[src.icon_state]L";OA.pixel_x=32;src.overlays+=OA
					var/obj/OB=new;OB.icon=src.icon;OB.icon_state="[src.icon_state]R";OB.pixel_x=-32;src.overlays+=OB
					var/A=new src.type(Nstr,Ndist,Ndir,locate(Nloc.x+1,Nloc.y,Nloc.z),Nowner,src)
					var/B=new src.type(Nstr,Ndist,Ndir,locate(Nloc.x-1,Nloc.y,Nloc.z),Nowner,src)
					src.Parts=list(A,B)
				else if(Ndir==SOUTH)
					var/obj/OA=new;OA.icon=src.icon;OA.icon_state="[src.icon_state]L";OA.pixel_x=-32;src.overlays+=OA
					var/obj/OB=new;OB.icon=src.icon;OB.icon_state="[src.icon_state]R";OB.pixel_x=32;src.overlays+=OB
					var/A=new src.type(Nstr,Ndist,Ndir,locate(Nloc.x-1,Nloc.y,Nloc.z),Nowner,src)
					var/B=new src.type(Nstr,Ndist,Ndir,locate(Nloc.x+1,Nloc.y,Nloc.z),Nowner,src)
					src.Parts=list(A,B)
				else if(Ndir==EAST)
					var/obj/OA=new;OA.icon=src.icon;OA.icon_state="[src.icon_state]L";OA.pixel_y=-32;src.overlays+=OA
					var/obj/OB=new;OB.icon=src.icon;OB.icon_state="[src.icon_state]R";OB.pixel_y=32;src.overlays+=OB
					var/A=new src.type(Nstr,Ndist,Ndir,locate(Nloc.x,Nloc.y-1,Nloc.z),Nowner,src)
					var/B=new src.type(Nstr,Ndist,Ndir,locate(Nloc.x,Nloc.y+1,Nloc.z),Nowner,src)
					src.Parts=list(A,B)
				else if (Ndir==WEST)
					var/obj/OA=new;OA.icon=src.icon;OA.icon_state="[src.icon_state]L";OA.pixel_y=32;src.overlays+=OA
					var/obj/OB=new;OB.icon=src.icon;OB.icon_state="[src.icon_state]R";OB.pixel_y=-32;src.overlays+=OB
					var/A=new src.type(Nstr,Ndist,Ndir,locate(Nloc.x,Nloc.y+1,Nloc.z),Nowner,src)
					var/B=new src.type(Nstr,Ndist,Ndir,locate(Nloc.x,Nloc.y-1,Nloc.z),Nowner,src)
					src.Parts=list(A,B)
			return ..(Nstr,Ndist,Ndir,Nloc,Nowner)
	New(var/Nstr,var/Ndist,var/Ndir,var/Nloc,var/Nowner,var/NTarget=null,var/AT)
		spawn()
			src.ArrowType=AT
			src.Owner=Nowner
			src.MyTarget=NTarget
			src.loc=Nloc;src.dir=Ndir
			src.Str=Nstr;src.Dist=Ndist
			if(src.Owner && src.Owner.FinalForm)	src.icon_state="Final Form"
			if(AT)	src.icon_state="[AT]"
			if(!istype(src,/obj/Projectile/Dragons))
				if((src.dir!=NORTH && src.dir!=SOUTH) || src.ArrowType=="Rapid Fire")	src.pixel_y=rand(-8,8)
				if((src.dir!=EAST && src.dir!=WEST) || src.ArrowType=="Rapid Fire")	src.pixel_x=rand(-8,8)
			if(src.ArrowType=="Rapid Fire")	src.Str=round(src.Str/2)
			for(var/i=0,i<=src.Dist,i++)//moves the target for preset distance
				if(!src.MyTarget)	step(src,src.dir)
				else	step(src,get_dir(src,src.MyTarget))
				sleep(1)
			del src
	Del()
		if(src.Owner && src.ArrowType=="Burst Arrow")
			for(var/turf/T in view(1,src))
				ShowEffect(T,'SkillEffects.dmi',"Burst","",5,0)
				for(var/mob/M in T)	src.Owner.Damage(M,src.Str,,src.Owner.Element,1,"Mystic")
				for(var/obj/Bankai/Chains/C in T)	src.Owner.DamageChain(C,src.Str+rand(-5,5))
		return ..()
	Bump(var/mob/M)
		if(istype(src,/obj/Projectile/ThreeWide) && src:Center)
			src:Center.Bump(M);return ..()
		if(src.type!=M.type)
			if(istype(src,/obj/Projectile/Dragons))	MyFlick("Destroy",src)
			else	MyFlick("[src.name]Hit",src)
			if(!istype(src,/obj/Projectile/ThreeWide))	src.loc=locate(M.x,M.y,M.z)
		else
			var/obj/Projectile/O=M
			if(src.Owner==O.Owner)	return ..()
			else	{del src;return}
		if(istype(src,/obj/Projectile/ThreeWide))
			for(var/obj/O in src:Parts)	del O
			src.loc=locate(get_step(src,src.dir))
		if(src.Owner)
			if(istype(M,/obj/Bankai/Chains))	src.Owner.DamageChain(M,src.Str+rand(-5,5))
			if(ismob(M))
				if(src.Owner.OverDriveOn)	src.Owner.KnockBack(M,get_step(M,src.OppositeDirection()))
				if(M.Blocking && !istype(src,/obj/Projectile/Dragons) && !istype(src,/obj/Projectile/ThreeWide))
					M.dir=get_dir(get_step(src,src.dir),M);src.Dist=10;src.MyTarget=null
					ShowEffect(M,'Effects.dmi',"counterspark","between2",10)
					PlaySoundEffect(view(M,M.SightRange),pick('SwordBlock1.wav','SwordBlock2.wav'),2)
					var/NewDir=src.DeflectionDirection()
					if(src.dir!=NewDir)	{src.dir=NewDir;return}
				if(src.Owner.CanPVP(M))
					var/damage=max(0,(src.Str+src.Dist)+rand(-5,5))
					for(var/obj/Skills/Quincy/Power_Arrow/G in src.Owner.Skills)	damage+=round(damage*(G.Level/10))
					var/CurStm=M.STM
					if(istype(src,/obj/Projectile/Dragons) && rand(1,100)<=10)
						if(src.Owner && src.Owner.Element=="Ice")	M.StunProc(2,"Freeze",src.Owner)
					if(src.ArrowType=="Paralysis Arrow")
						for(var/obj/Skills/Quincy/Paralysis_Arrow/P in src.Owner.Skills)
							if(rand(1,5)<=P.Level)	M.StunProc(2,"Stun",src.Owner)
					src.Owner.Damage(M,damage,src.Owner.Element,1,"Mystic")
					if(src.ArrowType!="Homing Arrow" && src.ArrowType!="Burst Arrow")
						if(damage>=CurStm)	return
						for(var/obj/Skills/Quincy/Pierce/G in src.Owner.Skills)	return
		spawn(1)	if(!istype(src,/obj/Projectile/Dragons) || istype(M,/obj/Supplemental/Mirror_Gate))	del src

atom/proc/OppositeDirection()
	if(src.dir==1)	return 2
	if(src.dir==2)	return 1
	if(src.dir==4)	return 8
	if(src.dir==8)	return 4
	if(src.dir==5)	return 10
	if(src.dir==6)	return 9
	if(src.dir==9)	return 6
	if(src.dir==10)	return 5

atom/proc/DeflectionDirection()
	if(src.dir==1)	return pick(5,9)
	if(src.dir==2)	return pick(6,10)
	if(src.dir==4)	return pick(5,6)
	if(src.dir==8)	return pick(9,10)
	if(src.dir==5)	return pick(1,4)
	if(src.dir==6)	return pick(2,4)
	if(src.dir==9)	return pick(1,8)
	if(src.dir==10)	return pick(2,8)

atom/proc/ReverseDeflectionDirection()
	if(src.dir==1)	return pick(6,10)
	if(src.dir==2)	return pick(5,9)
	if(src.dir==4)	return pick(9,10)
	if(src.dir==8)	return pick(5,6)
	if(src.dir==5)	return pick(2,8)
	if(src.dir==6)	return pick(1,8)
	if(src.dir==9)	return pick(2,4)
	if(src.dir==10)	return pick(1,4)

mob/proc
	CreateArrow()
		if(src.ArrowStr==0 || src.FinalForm)
			if(src.FinalForm && src.TurnMode)
				src.TurnMode=0;src.CanMove=1
				src.icon_state="";return
			src.ArrowCharges=0
			src.icon_state="CreateArrow"
			src.TurnMode=1;src.CanMove=0
			if(src.FinalForm)	return
			while(src.icon_state=="CreateArrow")
				src.ArrowStr=min(src.MaxREI,src.ArrowStr+1+src.ArrCreateSpd)
				src.UpdateHUDText("ArrowStr")
				if(src.ArrowStr>=src.MaxREI)	return
				sleep(1)
				if(!src)	return
	PullArrow()
		if(src.FinalForm)	return
		if(src.ArrowStr>=1 && src.ArrowDist==0)
			src.icon_state="PullArrow"
			src.TurnMode=1;src.CanMove=0
			while(src.icon_state=="PullArrow")
				src.ArrowDist=min(99,src.ArrowDist+1+src.DistChargeSpd)
				src.UpdateHUDText("ArrowDist")
				if(src.ArrowDist>=99)	return
				sleep(1)
				if(!src)	return
	FireArrow()
		if(src.Stunned)	return
		if(src.ArrowType=="Rapid Fire")	src.ArrowType="Spirit Arrow"
		if(src.ArrowDist>=1 || src.FinalForm)
			if(src.FinalForm && src.icon_state!="CreateArrow")	return
			if(src.FinalForm==2)	return
			if(src.FinalForm || src.OverDriveOn)
				src.ArrowDist=10;src.ArrowStr=src.MaxREI
			src.ArrowCharges+=1
			if(!src.FinalForm/* || src.ArrowCharges>=src.MaxArrowCharges*/)	{src.icon_state="";src.TurnMode=1;src.CanMove=0}
			for(var/datum/QuestDatum/Q in src.Quests)
				for(var/datum/ObjectiveDatum/OB in Q.Objectives)
					if(OB.Objective=="Fire Bow")
						OB.Current+=1
						if(OB.Current<=OB.Goal)	src.TrackQuests()
						if(OB.Current==OB.Goal)	src.QuestRefresh()
			MyFlick("FireArrow",src)
			PlayVoice(view(src,src.SightRange),pick(src.AttVoices))
			var/NTarget=null
			if(src.client && src.Target)
				if(MyGetDist(src,src.Target)>src.SightRange)	src.TargetMob(null)
				else
					if(src.AutoAttackFace)	src.dir=get_dir(src,src.Target)
			if(src.ArrowType=="Homing Arrow" && src.Target)	NTarget=src.Target
			new/obj/Projectile/Arrow((src.ArrowStr*PveArrDam/5)+src.MGC,src.ArrowDist,src.dir,src.loc,src,NTarget,src.ArrowType)
			if(src.ArrowType=="Spread Shot")	src.SpreadShot()
			if(src.ArrowType=="Rapid Fire")
				var/Numbar=0;for(var/obj/Skills/Quincy/Rapid_Fire/F in src.Skills)	Numbar=F.Level
				src.BarrageProc((src.ArrowStr*PveArrDam/5)+src.ArrowDist,src.ArrowDist,Numbar)
			if(src.FinalForm/* && src.icon_state=="PullArrow"*/)
				src.FinalForm=2;sleep(3)
				if(src && src.FinalForm==2)	src.FinalForm=1
				return
			src.ArrowStr=0;src.ArrowDist=0
			src.TurnMode=0;src.CanMove=1
	Attack(var/Height)
		if("Scatter" in src.ToggledSkills)	return
		if(src.SkillBeingCharged)	return
		if(src.Blocking)	return
		if(src.Stunned)	return
		var/Button="S"
		if(Height==2)	Button="D"
		if(Height==3)	Button="F"
		if(src.icon=='Bankai.dmi' && src.ComboReady)	goto ComboUp
		if("[Button][src.ComboCount+1]" in src.ComboList)
			if(src.ComboCount>=1 && src.ComboReady)	goto ComboUp
		if(!src.CanMove)	return
		ComboUp
		if(src.client)
			for(var/obj/HUD/ComboSysHud/C in src.client.screen)
				if(C.screen_loc=="7,18")	C.icon_state="[copytext(num2text(src.ComboCount+1),1,2)]"
		if(src.Target)	src.FlashAssault(src.Target)
		src.CanMove=0
		src.AttackHeight=Height
		src.ComboReady=0
		src.ComboCount+=1
		src.ComboStopper=rand(1,999999)
		var/ThisCombo=src.ComboStopper
		if(src.client && src.Target)
			if(MyGetDist(src,src.Target)>src.SightRange)	src.TargetMob(null)
			else
				if(src.AutoAttackFace)	src.dir=get_dir(src,src.Target)
		if(src.client)
			PlayVoice(view(src,src.SightRange),pick(src.AttVoices))
			src.icon_state="Stance"
			if(src.icon=='Bankai.dmi')	MyFlick("Combo",src)
			else if(src.Class=="Bount")	MyFlick("Attack",src)
			else	MyFlick("[Button][src.ComboCount]",src)
		//else	MyFlick("Attack",src)
		for(var/mob/M in get_step(src,src.dir))
			if(istype(M,/mob/Enemy) && istype(src,/mob/Enemy))	continue
			if(M.STM<=0)	continue
			if(src.Bankai)
				for(var/obj/Skills/Bankais/Dark_Ghost/Flash_Combo/F in src.Skills)
					var/Bonus=0;for(var/obj/Skills/Bankais/Dark_Ghost/A_Little_Faster/F2 in src.Skills)	Bonus+=F2.Level*5
					if(rand(1,100)<=35+((F.Level-1)*10)+Bonus)
						var/list/TurfList=block(locate(M.x-1,M.y-1,M.z),locate(M.x+1,M.y+1,M.z))-M.loc-src.loc-get_step(M,M.dir)
						RePick
						var/turf/NT
						if(TurfList.len)	NT=pick(TurfList)
						if(NT)
							if(!NT.Enter(src))	{TurfList-=NT;goto RePick}
							ShowEffect(src.loc,'Effects.dmi',"Warp","",5,NewDir=get_dir(src,NT))
							src.loc=NT;src.dir=get_dir(src,M)
			if(src.OverDriveOn)
				src.KnockBack(M,src);src.KnockBackFollow(M)
			var/damage=src.STR+rand(-5,5)
			if(!M.client)	damage*=PveDam
			if(src.OverDriveOn)	damage+=damage*0.2
			src.Damage(M,damage,src.Element,1,"Melee")
		for(var/obj/Bankai/Chains/C in get_step(src,src.dir))	src.DamageChain(C,src.STR+rand(-5,5))
		var/SpawnTime=Height*5
		if(src.client)
			SpawnTime=15
			spawn(3)	src.ComboReady=1
		if(src.icon=='Bankai.dmi')	SpawnTime=4
		spawn(3)	if(src)	src.AttackHeight=0
		spawn(SpawnTime)
			if(!src)	return
			if(src.Blocking)	return
			if(src.ComboStopper!=ThisCombo)	return
			src.CanMove=1
			src.ComboCount=0
			if(src.client)
				for(var/obj/HUD/ComboSysHud/C in src.client.screen)
					if(C.icon_state!="Hit")	C.icon_state="No"
	Guard()
		if(!src.CanBlock())	return
		src.CanMove=0
		src.Blocking=1
		src.ComboCount=0
		MyFlick("Block",src)
		src.icon_state="Block"
		if(src.client)
			for(var/obj/HUD/ComboSysHud/C in src.client.screen)
				if(C.icon_state!="Hit")	C.icon_state="No"
		spawn(10)
			if(!src.Blocking)	return
			src.CanMove=1
			src.Blocking=0
			if(src.icon_state=="Block")	src.icon_state="Stance"
	BarrageProc(var/Damage,var/Dist,var/Numbar)
		for(var/i=1,i<=Numbar,i++)
			MyFlick("FireArrow",src)
			PlayVoice(view(src,src.SightRange),pick(src.AttVoices))
			new/obj/Projectile/Arrow(Damage,Dist,src.dir,src.loc,src,null,"Rapid Fire")
	SpreadShot()
		var/Damage=(src.ArrowStr*PveArrDam/5)
		if(src.dir==NORTH)
			new/obj/Projectile/Arrow(Damage+src.MGC,src.ArrowDist,NORTHWEST,src.loc,src)
			new/obj/Projectile/Arrow(Damage+src.MGC,src.ArrowDist,NORTHEAST,src.loc,src)
		if(src.dir==SOUTH)
			new/obj/Projectile/Arrow(Damage+src.MGC,src.ArrowDist,SOUTHWEST,src.loc,src)
			new/obj/Projectile/Arrow(Damage+src.MGC,src.ArrowDist,SOUTHEAST,src.loc,src)
		if(src.dir==EAST)
			new/obj/Projectile/Arrow(Damage+src.MGC,src.ArrowDist,NORTHEAST,src.loc,src)
			new/obj/Projectile/Arrow(Damage+src.MGC,src.ArrowDist,SOUTHEAST,src.loc,src)
		if(src.dir==WEST)
			new/obj/Projectile/Arrow(Damage+src.MGC,src.ArrowDist,NORTHWEST,src.loc,src)
			new/obj/Projectile/Arrow(Damage+src.MGC,src.ArrowDist,SOUTHWEST,src.loc,src)