var/obj/SkillSups/FFWingN/FFWingN=new()
var/obj/SkillSups/FFWingS/FFWingS=new()
var/obj/SkillSups/FFWingE/FFWingE=new()
var/obj/SkillSups/FFWingW/FFWingW=new()
var/obj/SkillSups/FFBowOverlay/FFBowOverlay=new()
obj/SkillSups
	FFWingN
		layer=MOB_LAYER+1;pixel_x=18;pixel_y=4
		icon='Effects.dmi';icon_state="FFWingN"
	FFWingS
		layer=OBJ_LAYER;pixel_x=-18;pixel_y=4
		icon='Effects.dmi';icon_state="FFWingS"
	FFWingE
		layer=MOB_LAYER+1;pixel_x=-18;pixel_y=4
		icon='Effects.dmi';icon_state="FFWingE"
	FFWingW
		layer=OBJ_LAYER;pixel_x=18;pixel_y=4
		icon='Effects.dmi';icon_state="FFWingW"
	FFBowOverlay
		layer=9;icon='FFbowOverlay.dmi'
	ScatterPetals
		layer=9;pixel_x=-32;mouse_opacity=0
		icon='Petals.dmi';icon_state="Body"
	BladeBreak
		var/mob/Owner
		layer=9;mouse_opacity=0;density=0
		icon='RenjiBlade.dmi';icon_state="Body"
		New(mob/M,var/DamLevel)
			src.Owner=M
			spawn()	while(M)
				for(var/mob/E in src.loc)
					ShowEffect(E,'Effects.dmi',"LightSpark","",10)
					M.KnockBack(E,M);M.Damage(E,M.STR+(10*DamLevel),M.Element,1,"Melee")
				sleep(1)
			return ..()

obj/Gigai
	icon='School.dmi'
	icon_state="Dead"
	density=0
	New()
		spawn(30)	del src

mob/proc
	Selected_Skill()
		QuestShow(src,"No Skill Selected")
	Taunt(var/TauntDistance)
		for(var/mob/Enemy/M in oview(TauntDistance,src))
			M.TauntedBy=src;M.TargetMob(src)
			ShowEffect(M,'Effects.dmi',"Taunt","",5,0)
	SpiritForm()
		if(!src.icon)	return
		if(src.Stunned)	return
		if(src.SpiritForm)	return
		ShowEffect(src,'Effects.dmi',"EnterBody",src.loc,5,0)
		ShowEffect(src,'Effects.dmi',"BodyRing",src.loc,5,0)
		if(src.Class=="Bount")
			src.icon_state="Stance"
		if(src.Class=="Soul Reaper")
			var/obj/Gigai/B=new()
			var/obj/HI=new()
			HI.icon='DeadHairs.dmi';HI.icon_state=src.HairStyle
			HI.icon=MyRGB(HI.icon,rgb(src.HairR,src.HairG,src.HairB))
			B.overlays+=HI
			src.icon='SoulReaper.dmi'
			//src.DamageIcon=src.icon+rgb(255,0,0)
			//src.GuardIcon=src.icon+rgb(155,155,155)
			B.loc=src.loc
		if(src.Class=="Quincy")
			MyFlick("Quincy",src)
			src.icon='Quincy.dmi'
			//src.DamageIcon=src.icon+rgb(255,0,0)
			//src.GuardIcon=src.icon+rgb(155,155,155)
		src.SpiritForm=1
		src.RefreshClothes()
	Revert(/**/)
		if(src.ChainHead)	src.ChainHead.Owner=null
		src.MovementSpeed=initial(src.MovementSpeed)
		src.SpiritForm=0
		src.TurnMode=0
		if(src.ArrowDist)
			src.ArrowDist=0
			src.ArrowStr=0
			src.CanMove=1
		src.Bankai=0
		src.Shikai=0
		src.FinalForm=0
		src.Element=null
		src.overlays=null
		src.ReleaseSkill()
		//src.DamageIcon=src.icon+rgb(255,0,0)
		//src.GuardIcon=src.icon+rgb(155,155,155)
		src.MusicMode=0
		src.icon_state=""
		src.icon='School.dmi'
		src.AddName()
		src.RefreshClothes()
		src.AddHair(src.HairStyle)
		if(src.PVP)	src.overlays+=PVPicon
		if(src.Party)	src.overlays+=src.Party.PartyIcon
		for(var/obj/Items/Equipment/E in src.EquipmentList)	E.OnEquip(src)
		for(var/datum/StatusEffects/RadialEffects/E in src.StatusEffects)	E.AddOverlays(src)
		if(src.gender==FEMALE)	src.icon='SchoolFemale.dmi'
		ShowEffect(src,'Effects.dmi',"EnterBody",src.loc,5,0)
		ShowEffect(src,'Effects.dmi',"BodyRing",src.loc,5,0)

	RemoveZanOvers()
		for(var/O in src.overlays)
			if(O)
				if(O:name=="ZanOver")	src.overlays-=O
			else	src.overlays-=O

	Shikai()
		if(!src.SpiritForm||!src.Zanpakuto)	return
		if(!src.CanMove || src.Stunned)	return
		if(src.Shikai || src.Bankai || src.Transforming)	return
		src.Transforming=1
		src.Shikai=1
		src.CanMove=0
		src.dir=SOUTH
		ShowEffect(src,'Effects.dmi',"Energy","",10,1)
		PlayTimedSound(view(src,9),'Energy.wav',10)
		src.icon_state="Block"
		sleep(10)
		src.CanMove=1
		src.Transforming=0
		if(!src.SpiritForm)	return
		src.icon_state="Stance"
		src.Element=src.Zanpakuto.Element
		for(var/datum/ZanOvers/D in src.ZanpakutoOverlays)
			var/obj/O=new;O.layer=5;O.name="ZanOver"
			O.ZanConfigure(D)
			O.icon=MyRGB(O.icon,rgb(D.R,D.G,D.B))
			src.overlays+=O

	Bankai()
		if(!src.SpiritForm||!src.Zanpakuto)	return
		if(!src.CanMove || src.Stunned)	return
		if(src.Bankai && src.Zanpakuto.SpiritType=="Beast")	src.ChainStart()
		if(src.Bankai || src.Transforming)	return
		src.Transforming=1
		src.Shikai=0
		src.Bankai=1
		src.CanMove=0
		src.dir=SOUTH
		src.Element=src.Zanpakuto.Element
		ShowEffect(src,'Effects.dmi',"Energy","",30,1)
		PlayTimedSound(view(src,9),'Energy.wav',30)
		src.icon_state="Block"
		sleep(30)
		if(!src.SpiritForm)	{src.CanMove=1;src.Transforming=0;return}
		MyFlick("S1",src)
		PlayVoice(view(src,src.SightRange),'bankai.wav')
		sleep(12)
		if(!src.SpiritForm)	{src.CanMove=1;src.Transforming=0;return}
		src.icon_state="Stance"
		if(src.Zanpakuto.SpiritType=="Ghost")
			src.MovementSpeed=1
			src.icon='bankai.dmi'
			src.RemoveZanOvers()
			src.RefreshClothes()
			//src.DamageIcon=src.icon+rgb(255,0,0)
			//src.GuardIcon=src.icon+rgb(155,155,155)
			src.AddHair(src.HairStyle,"Bankai")
			src.AddName()
			ShowEffect(src,'Effects.dmi',"Energy","",30,1)
			PlayTimedSound(view(src,9),'Energy.wav',30)
			sleep(30)
			if(!src.SpiritForm)	{src.CanMove=1;src.Transforming=0;return}
			MyFlick("Combo",src)
			PlayVoice(view(src,src.SightRange),'DinsFire.wav')
		src.CanMove=1
		src.Transforming=0
		if(src.Zanpakuto.SpiritType=="Dragon")
			src.icon_state="";src.AddIceWings()
		if(src.Zanpakuto.SpiritType=="Beast")	src.ChainStart()
	Final_Form()
		if(!src.SpiritForm)	return
		if(!src.CanMove || src.Stunned)	return
		if(src.FinalForm || src.Transforming)	return
		src.Transforming=1
		src.FinalForm=1
		src.CanMove=0
		src.dir=SOUTH
		ShowEffect(src,'Effects.dmi',"Energy","",30,1)
		PlayTimedSound(view(src,9),'Energy.wav',30)
		src.icon_state="CreateArrow"
		sleep(30)
		if(!src.SpiritForm)	{src.CanMove=1;src.Transforming=0;return}
		src.MovementSpeed=1
		src.icon='FinalForm.dmi'
		src.RefreshClothes()
		//src.DamageIcon=src.icon+rgb(255,0,0)
		//src.GuardIcon=src.icon+rgb(155,155,155)
		PlayVoice(view(src,src.SightRange),'DinsFire.wav')
		src.overlays-=FFWingN;src.overlays+=FFWingN
		src.overlays-=FFWingS;src.overlays+=FFWingS
		src.overlays-=FFWingE;src.overlays+=FFWingE
		src.overlays-=FFWingW;src.overlays+=FFWingW
		src.overlays-=FFBowOverlay;src.overlays+=FFBowOverlay
		src.icon_state=""
		MyFlick("FireArrow",src)
		src.Transforming=0
		src.CanMove=1
	Flash_Step()
		if(!src.Target || src.Target==src)	{QuestShow(src,"Invalid Target");return}
		if(!src.UseRei(round(src.MaxREI/10)))	return
		var/turf/T=get_step(src.Target,get_dir(src,src.Target))
		if(T)	T.DblClick(src)
	Summon_Pet()
		if(src.Blocking||!src.CanMove||src.Stunned)	return
		for(var/mob/Pets/BountPets/P in src.Pets)
			if(MyGetDist(src,P)>=10)
				MyFlick("Blast",src);src.icon_state="Stance"
				PlayVoice(view(src,src.SightRange),pick(src.AttVoices))
				P.STM=P.MaxSTM;P.REI=P.MaxREI
				P.StmBar();P.ReiBar();P.Thinking=0
				P.loc=src.loc;step_rand(P);walk_to(P,src,1)
				ShowEffect(P,'Effects.dmi',"Appear",duration=10)
	Dismiss_Pet()
		if(src.Blocking||!src.CanMove||src.Stunned)	return
		for(var/mob/Pets/BountPets/P in src.Pets)
			if(MyGetDist(src,P)<=9)
				MyFlick("Blast",src);src.icon_state="Stance"
				PlayVoice(view(src,src.SightRange),pick(src.AttVoices))
				ShowEffect(P.loc,'Effects.dmi',"Appear",duration=10)
				P.Thinking=0;P.loc=null
	Syphon_Health_Release()
		return
	Syphon_Health()
		while(src.SkillBeingCharged)
			src.icon_state="Block"
			var/Heal=0;for(var/obj/Skills/Bount/Syphon_Health/S in src.Skills)
				Heal=(10+src.MGC*5)*((0.10*(S.Level-1))+1);Heal=round(Heal)
			var/mob/ThisTarget=src.Target
			if(!ThisTarget)	break
			if(src.CanPVP(ThisTarget))	break
			src.CanMove=1
			if(!src.UseRei(src.Level))	break
			src.CanMove=0
			ShowEffect(ThisTarget,'Effects.dmi',"Soul Glow","",10,0,1)
			ThisTarget.STM=min(ThisTarget.MaxSTM,ThisTarget.STM+Heal)
			ThisTarget.StmBar();DamageShow(ThisTarget,Heal,'HealNums.dmi')
			sleep(10)
		src.SkillBeingCharged=null
		src.icon_state=""
		src.CanMove=1
	Heal_Pet()
		if(!src.UseRei(50))	return
		var/Heal=0;for(var/obj/Skills/Bount/Heal_Pet/S in src.Skills)
			Heal=(25+src.MGC*10)*((0.10*(S.Level-1))+1);Heal=round(Heal)
		MyFlick("Blast",src)
		for(var/mob/Pets/ThisTarget in oview(src,src.SightRange))
			if(ThisTarget.Owner==src)
				ShowEffect(ThisTarget,'Effects.dmi',"Soul Glow","",10,0,1)
				ThisTarget.STM=min(ThisTarget.MaxSTM,ThisTarget.STM+Heal)
				ThisTarget.StmBar();DamageShow(ThisTarget,Heal,'HealNums.dmi')
	Flash_Heal()
		if(!src.UseRei(round(src.MaxREI/10)))	return
		var/Heal=0;for(var/obj/Skills/Bount/Flash_Heal/S in src.Skills)
			Heal=(round(src.MaxSTM/10))*((0.03*(S.Level-1))+1);Heal=round(Heal)
		MyFlick("Blast",src)
		var/mob/ThisTarget=src
		ShowEffect(ThisTarget,'Effects.dmi',"Soul Glow","",10,0,1)
		ThisTarget.STM=min(ThisTarget.MaxSTM,ThisTarget.STM+Heal)
		ThisTarget.StmBar();DamageShow(ThisTarget,Heal,'HealNums.dmi')
	Battlefield_Layout()
		//New(var/Name,var/Durate,var/CastedBy,var/Stat2,var/Amt2,var/Desc,FIS,BIS,var/Range,var/Cost)
		for(var/datum/StatusEffects/RadialEffects/E in src.StatusEffects)
			if(E.name=="Battlefield Layout" && E.CastBy=="[src]")
				E.RemovalProc(src);return
		if(src.REI>=5)	for(var/obj/Skills/Bount/Battlefield_Layout/S in src.Skills)
			src.AddEffect(new/datum/StatusEffects/RadialEffects("Battlefield Layout",0,src,"MovementSpeed",-1,\
				"Increases Movement Speed by 1","GreenBallFront","GreenBallBack",4+S.Level,5))
	Offensive_Tactics()
		for(var/datum/StatusEffects/RadialEffects/E in src.StatusEffects)
			if(E.name=="Offensive Tactics" && E.CastBy=="[src]")
				E.RemovalProc(src);return
		if(src.REI>=5)	for(var/obj/Skills/Bount/Offensive_Tactics/S in src.Skills)
			src.AddEffect(new/datum/StatusEffects/RadialEffects("Offensive Tactics",0,src,null,null,\
				"Increases Damage Dealt by 10%","RedBallFront","RedBallBack",4+S.Level,5))
	Defensive_Strategy()
		for(var/datum/StatusEffects/RadialEffects/E in src.StatusEffects)
			if(E.name=="Defensive Strategy" && E.CastBy=="[src]")
				E.RemovalProc(src);return
		if(src.REI>=5)	for(var/obj/Skills/Bount/Defensive_Strategy/S in src.Skills)
			src.AddEffect(new/datum/StatusEffects/RadialEffects("Defensive Strategy",0,src,null,null,\
				"Decreases Damage Taken by 10%","BlueBallFront","BlueBallBack",4+S.Level,5))
	Group_Morale()
		for(var/datum/StatusEffects/RadialEffects/E in src.StatusEffects)
			if(E.name=="Group Morale" && E.CastBy=="[src]")
				E.RemovalProc(src);return
		if(src.REI>=5)	for(var/obj/Skills/Quincy/Group_Morale/S in src.Skills)
			src.AddEffect(new/datum/StatusEffects/RadialEffects("Group Morale",0,src,"ReiRegenBonus",1,\
				"Increases Reiatsu Regeneration by 10 per Second","BlueBallFront","BlueBallBack",4+S.Level,5))
	Power_Strike()
		if("Scatter" in src.ToggledSkills)	return
		if(src.Blocking||!src.CanMove||src.Stunned)	return
		if(!src.UseRei(25))	return
		PlayVoice(view(src,src.SightRange),pick(src.AttVoices))
		MyFlick("Power Strike",src)
		src.icon_state="Stance"
		var/Damage;for(var/obj/Skills/SoulReaper/Power_Strike/S in src.Skills)	Damage=(src.STR+100)*((0.25*(S.Level-1))+1)
		for(var/mob/M in get_step(src,src.dir))	src.Damage(M,Damage,src.Element,1,"Melee")
		for(var/obj/Bankai/Chains/C in get_step(src,src.dir))	src.DamageChain(C,Damage)
	Brave_Shout()
		var/Range;for(var/obj/Skills/SoulReaper/Brave_Shout/S in src.Skills)	Range=4+S.Level
		src.Taunt(Range)
	Selfless_Distraction()
		var/Range;for(var/obj/Skills/Quincy/Selfless_Distraction/S in src.Skills)	Range=4+S.Level
		src.Taunt(Range)
	Restore_Point()
		var/ReqRei;for(var/obj/Skills/SoulReaper/Restore_Point/S in src.Skills)	ReqRei=src.MaxREI*((11-S.Level)/10)
		if(src.REI<ReqRei)	{QuestShow(src,"[ReqRei] Reiatsu Required");return}
		MyFlick("F3",src)
		PlayVoice(view(src,src.SightRange),pick(src.AttVoices))
		src.STM=src.MaxSTM;src.StmBar()
		src.REI=0;src.ReiBar()
	ShockWave()
		if("Scatter" in src.ToggledSkills)	return
		if(src.Blocking||!src.CanMove||src.Stunned)	return
		if(!src.UseRei(75))	return
		MyFlick("F3",src)
		PlayVoice(view(src,src.SightRange),pick(src.AttVoices))
		var/Damage;for(var/obj/Skills/SoulReaper/ShockWave/S in src.Skills)	Damage=(150+src.STR)*((0.25*(S.Level-1))+1)
		for(var/mob/M in oview(1,src))	src.Damage(M,Damage,src.Element)
		for(var/obj/Bankai/Chains/C in oview(1,src))	src.DamageChain(C,Damage)
	Spirit_Blast()
		if("Scatter" in src.ToggledSkills)	return
		if(src.Blocking||!src.CanMove||src.Stunned)	return
		if(!src.UseRei(50))	return
		MyFlick("F3",src)
		PlayVoice(view(src,src.SightRange),pick(src.AttVoices))
		var/Duration;for(var/obj/Skills/SoulReaper/Spirit_Blast/S in src.Skills)	Duration=S.Level
		for(var/mob/M in oview(1,src))
			M.StunProc(Duration,"Stun",src)
	Power_Shot()
		if(src.Blocking||!src.CanMove||src.Stunned)	return
		if(!src.UseRei(50))	return
		MyFlick("FireArrow",src)
		PlayVoice(view(src,src.SightRange),pick(src.AttVoices))
		var/Damage;for(var/obj/Skills/Quincy/Power_Shot/S in src.Skills)	Damage=(150+src.MGC)*((0.25*(S.Level-1))+1)
		new/obj/Projectile/Arrow(Damage,10,src.dir,src.loc,src,null,"Power Shot")
	Barrage()
		if(src.Blocking||!src.CanMove||src.Stunned)	return
		if(!src.UseRei(150))	return
		var/Numbar=0;for(var/obj/Skills/Quincy/Barrage/F in src.Skills)	Numbar=F.Level+1
		src.BarrageProc((100+src.MGC)*((0.25*(Numbar-2))+1),10,Numbar)

	Berserk()
		if(src.Blocking||!src.CanMove||src.Stunned)	return
		if(!src.UseRei(25))	return
		for(var/obj/Skills/SoulReaper/Berserk/F in src.Skills)
			src.AddEffect(new/datum/StatusEffects/Berserk("Berserk",20+F.Level-1,10,10+F.Level-1,src))
	Enrage()
		if(src.Blocking||!src.CanMove||src.Stunned)	return
		if(!src.UseRei(25))	return
		for(var/obj/Skills/Shikais/Shared/Enrage/F in src.Skills)
			src.AddEffect(new/datum/StatusEffects/Berserk("Enrage",30+F.Level-1,0,10+F.Level-1,src))

	Spirit_Charge_Release()
		for(var/obj/O in src.loc)
			view(src,src.SightRange)<<sound(null,channel=8)
			if(O.icon_state=="Energy")	del O
	Spirit_Charge()
		if(src.Blocking||!src.CanMove||src.Stunned)	return
		if(src.Class=="Bount")	src.icon_state="Block"
		if(src.Class=="Quincy")	src.icon_state="CreateArrow"
		if(src.Class=="Soul Reaper")	src.icon_state="Block"
		PlayTimedSound(view(src,src.SightRange),'Energy.wav',999)
		ShowEffect(src,'Effects.dmi',"Energy","",120,1)
		var/SkillBoost=0
		for(var/obj/Skills/Universal/Spirit_Charge/S in src.Skills)	SkillBoost=S.Level
		while(src.SkillBeingCharged)
			src.CanMove=0
			src.REI+=SkillBoost
			src.REI=min(src.REI,src.MaxREI)
			src.ReiBar()
			sleep(1)
			if(!src)	return
		src.icon_state=""
		src.CanMove=1

	//Shikai Skill Procs
	Scatter()
		if("Scatter" in src.ToggledSkills)
			src.ToggledSkills-="Scatter"
			for(var/obj/SkillSups/ScatterPetals/P in src.Cache)	{src.overlays-=P;del P}
		else
			src.ToggledSkills+="Scatter"
			for(var/i=1;i<=9;i++)
				var/obj/SkillSups/ScatterPetals/P=new()
				if(i<=9)	{P.pixel_x=-64+(32*(i-6));P.pixel_y=-32}
				if(i<=6)	{P.pixel_x=-64+(32*(i-3));P.pixel_y=0}
				if(i<=3)	{P.pixel_x=-64+(32*i);P.pixel_y=32}
				P.icon_state="[i]";src.Cache+=P;src.overlays+=P
	Petal_Stream()
		var/Damage;for(var/obj/Skills/Shikais/Light_Dragon/Petal_Stream/S in src.Skills)
			Damage=(S.Level-1+15+src.MGC)*((0.25*(S.Level-1))+1)
		src.InfBeamAttack(15,"Scatter",null,Damage,"/obj/Damaging/Petal_Stream")
	Petal_Stream_Release()
		for(var/obj/Damaging/Petal_Stream/D in oview(src))	if(D.Owner==src)	del D
		src.CanMove=1;src.SkillBeingCharged=null;src.icon_state="";src.InfBeamCost=0
	Blade_Break()
		var/obj/SkillSups/BladeBreak/X=new()
		if(!src.loc.Enter(X))	{del X;return}
		if(!src.UseRei(50))	return
		for(var/obj/Skills/Shikais/Earth_Beast/Blade_Break/S in src.Skills)
			var/Dir=src.dir;del X
			var/obj/SkillSups/BladeBreak/H=new(src,S.Level);src.DeathCache+=H
			H.dir=Dir;H.icon_state="Head";H.loc=get_step(src,Dir)
			for(var/i=1;i<=S.Level+2;i++)
				if(!src || !H)	return
				src.CanMove=0;src.icon_state="Blast"
				var/obj/SkillSups/BladeBreak/B=new(src,S.Level);src.DeathCache+=B
				B.dir=Dir;B.loc=H.loc
				step(H,Dir)
				sleep(2)
			while(src && H && H.loc!=src.loc)
				for(var/obj/SkillSups/BladeBreak/B in H.loc)
					if(B!=H && (B in src.DeathCache))	{src.DeathCache-=B;del B}
				step(H,get_dir(H,src));H.dir=Dir
				if(H.loc==src.loc)	{src.DeathCache-=H;del H}
				sleep(1)
			if(!src)	return
			for(var/obj/SkillSups/BladeBreak/B in src.DeathCache)	{src.DeathCache-=B;del B}
			src.CanMove=1;src.icon_state=""
	Freeze_Ring()
		if(!src.UseRei(350))	return
		var/obj/Skills/Shikais/Ice_Dragon/Freeze_Ring/S
		for(var/obj/Skills/Shikais/Ice_Dragon/Freeze_Ring/x in src.Skills)	S=x
		for(var/turf/T in oview(S.Level,src))
			for(var/mob/M in T)	M.StunProc(3*S.Level,"Freeze",src)
			if(!T.density)
				var/obj/Supplemental/Freeze_Ring/M=new(T);src.Cache+=M
				spawn(S.Level*50)	if(M)	del M
	Ice_Dragon_Assault()
		if(!src.UseRei(200))	return
		MyFlick("F3",src);src.CanMove=0
		src.icon_state="Stance"
		var/Damage=250+src.MGC
		for(var/obj/Skills/Shikais/Ice_Dragon/Ice_Dragon_Assault/S in src.Skills)	Damage+=round(Damage*((S.Level-1)/10))
		src.DragonAssault('IceDragon.dmi',Damage)
		sleep(15);if(src)	src.CanMove=1
	Getsuga_Tenshou_Release()
		src.TurnMode=0
		if(src.Stunned || src.ChargedPower<=0)	return
		var/ChargedP=src.ChargedPower*2/5
		src.ChargedPower=0
		var/Damage;for(var/obj/Skills/Shikais/Dark_Ghost/Getsuga_Tenshou/S in src.Skills)
			Damage=src.STR*((0.1*(S.Level-1))+1)
		ChargedP+=Damage*3
		for(var/obj/O in src.loc)
			if(O.icon_state=="Energy")
				del O;view(src,9)<<sound(null,channel=8)
		MyFlick("F1",src)
		PlayVoice(view(src,src.SightRange),'GetsugaTenshou.wav',2)
		sleep(6);if(!src)	return
		MyFlick("F2",src)
		src.icon_state="Stance"
		new/obj/Projectile/ThreeWide/Getsuga(ChargedP,11,src.dir,src.loc,src)
		sleep(15);if(src)	src.CanMove=1
	Getsuga_Tenshou()
		if(!src.UseRei(25))	return
		src.CanMove=0
		src.TurnMode=1
		src.icon_state="Block"
		PlayTimedSound(view(src,src.SightRange),'Energy.wav',999)
		ShowEffect(src,'Effects.dmi',"Energy","",120,1)
		src.ChargedPower=1
		src.ChargeSkillPower()
	Black_Getsuga_Tenshou_Release()
		src.TurnMode=0
		if(src.Stunned || src.ChargedPower<=0)	return
		var/ChargedP=src.ChargedPower*2/5
		src.ChargedPower=0
		var/Damage;for(var/obj/Skills/Bankais/Dark_Ghost/Black_Getsuga_Tenshou/S in src.Skills)
			Damage=src.STR*((0.1*(S.Level-1))+1)
		ChargedP+=Damage*5
		for(var/obj/O in src.loc)
			if(O.icon_state=="Energy")
				del O;view(src,9)<<sound(null,channel=8)
		MyFlick("Combo",src)
		PlayVoice(view(src,src.SightRange),'GetsugaTenshou.wav',2)
		sleep(6);if(!src)	return
		MyFlick("F3",src)
		src.icon_state="Stance"
		new/obj/Projectile/ThreeWide/Black_Getsuga(ChargedP,11,src.dir,src.loc,src)
		sleep(15);if(src)	src.CanMove=1
	Black_Getsuga_Tenshou()
		if(!src.UseRei(50))	return
		src.CanMove=0
		src.TurnMode=1
		src.icon_state="Block"
		PlayTimedSound(view(src,src.SightRange),'Energy.wav',999)
		ShowEffect(src,'Effects.dmi',"Energy","",120,1)
		src.ChargedPower=1
		src.ChargeSkillPower()

mob/proc/DragonAssault(var/IC,var/Damage)
	var/list/BodyParts=list("Head","Body","Tail")
	for(var/i=1,i<=3,i++)
		var/NewPath="/obj/Projectile/Dragons/IceDragon"
		if(src.Element=="Fire")	NewPath="/obj/Projectile/Dragons/FireDragon"
		var/obj/Projectile/Dragons/D=new NewPath(Damage,10,src.dir,src.loc,src)
		D.icon=IC;D.icon_state=BodyParts[i]

mob/proc/ChargeSkillPower()
	while(src.SkillBeingCharged)
		src.CanMove=0
		if(src.REI>=1)
			src.REI-=1
			src.ReiRegenWait=10
			src.ChargedPower+=1
			src.ReiBar()
		sleep(1)
		if(!src)	return