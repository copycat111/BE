obj/Damaging
	layer=8
	density=0
	icon='SkillEffects.dmi'
	var/mob/Owner
	var/STR
	var/Element="None"
	var/list/SoundList=list()
	var/DistanceDown=0
	Petal_Stream
		Element="Petal"
		icon='Petals.dmi'
		icon_state="Weak"
		New()
			..()
			//if(src.dir!=NORTH && src.dir!=SOUTH)	src.pixel_y=rand(-8,8)
			//if(src.dir!=EAST && src.dir!=WEST)	src.pixel_x=rand(-8,8)
			spawn()	src.PixelShift(rand(-4,4),1,-4,4)
	White_Lightning
		DistanceDown=1
		Element="Lightning"
		icon_state="White Lightning"
		SoundList=list('Zap1.wav','Zap2.wav','Zap3.wav')
	Roaring_Thunder_Burn
		Element="Fire"
		icon_state="Roaring Thunder Burn"
	New(var/NewDir,var/NewLoc,var/NewOwner,var/NewStr)
		src.dir=NewDir;src.loc=NewLoc
		src.Owner=NewOwner;src.STR=NewStr
		spawn()
			while(src.Owner)
				if(MyGetDist(src,src.Owner)>10)	{del src;return}
				for(var/mob/M in src.loc)
					if(src.SoundList.len>=1)	PlaySoundEffect(view(M,M.SightRange),pick(src.SoundList))
					src.Owner.Damage(M,src.STR-(MyGetDist(src,src.Owner)*src.DistanceDown),src.Element,1,"Mystic")
				for(var/obj/Bankai/Chains/C in src.loc)
					if(src.SoundList.len>=1)	PlaySoundEffect(view(C,9),pick(src.SoundList))
					src.Owner.DamageChain(C,src.STR-(MyGetDist(src,src.Owner)*src.DistanceDown))
				sleep(2)
			del src

mob/proc/FreezeKidou(var/mob/Target,var/obj/Kidous/K)
	if(!Target)	{QuestShow(src,"Invalid Target");return}
	if(!src.UseRei(K.ReiCost))	return
	MyFlick("Blast",src)
	Target.StunProc(K.Level*K.AttPower,K.name,src)

mob/proc
	//bakudous
	Obstruction()
		for(var/obj/Kidous/Bakudous/Obstruction/K in src.Kidous)	src.FreezeKidou(src.Target,K)
	Conquer()
		for(var/obj/Kidous/Bakudous/Conquer/K in src.Kidous)	src.FreezeKidou(src.Target,K)
	Tracing_Sparrow()
		if(src.Target)	QuestShow(src,"[src.Target] ([src.Target.x],[src.Target.y],[src.Target.z])")
		else	QuestShow(src,"No Target Selected")
	Binding_Light()
		for(var/obj/Kidous/Bakudous/Binding_Light/K in src.Kidous)	src.FreezeKidou(src.Target,K)
	Iron_Brace()
		for(var/obj/Kidous/Bakudous/Iron_Brace/K in src.Kidous)	src.FreezeKidou(src.Target,K)
	Silky_Sky()
		src.ShowBL()
	Complete_Seal()
		var/Damage;for(var/obj/Kidous/Bakudous/Complete_Seal/K in src.Kidous)
			src.FreezeKidou(src.Target,K)
			Damage=1000*((0.25*(K.Level-1))+1)
		src.InstantAttack(src.Target,"EarthSpark",Damage,0,"Earth")
	//hadous
	White_Lightning_Release()
		for(var/obj/Damaging/White_Lightning/D in oview(src))	if(D.Owner==src)	del D
		src.CanMove=1;src.SkillBeingCharged=null;src.icon_state="";src.InfBeamCost=0
	White_Lightning()
		var/Damage;for(var/obj/Kidous/Hadous/White_Lightning/K in src.Kidous)
			Damage=(10+src.Kidou+src.MGC)*((0.25*(K.Level-1))+1)
		src.InfBeamAttack(20,"White Lightning",'Lightning.wav',Damage,"/obj/Damaging/White_Lightning")
	Red_Flame_Cannon()
		var/Damage;for(var/obj/Kidous/Hadous/Red_Flame_Cannon/K in src.Kidous)	Damage=(150+src.Kidou+src.MGC)*((0.25*(K.Level-1))+1)
		src.FireBall(150,Damage,"Red Flame Cannon")
	Blue_Fireball()
		if(!src.CanMove)	return
		var/Blasts=0
		var/Damage;for(var/obj/Kidous/Hadous/Blue_Fireball/K in src.Kidous)
			Damage=(100+src.Kidou+src.MGC)*((0.25*(K.Level-1))+1);Blasts=K.Level
		if(!src.UseRei(250))	return
		for(var/i=1,i<=Blasts,i++)
			spawn(-1)	if(src)	src.FireBall(0,Damage,"Blue Fireball",src.Target)
			sleep(5)
	Incinerating_Flame()
		var/Damage;for(var/obj/Kidous/Hadous/Incinerating_Flame/K in src.Kidous)
			Damage=(300+src.Kidou+src.MGC)*((0.25*(K.Level-1))+1)
		src.InstantAttack(src.Target,"Explosion",Damage,200,"Fire")
	Roaring_Thunder_Burn()
		var/Damage;for(var/obj/Kidous/Hadous/Roaring_Thunder_Burn/K in src.Kidous)
			Damage=(250+src.Kidou+src.MGC)*((0.25*(K.Level-1))+1)
		src.InfBeamAttack(150,"Roaring Thunder Burn",'Lightning.wav',Damage,"/obj/Damaging/Roaring_Thunder_Burn")
	Roaring_Thunder_Burn_Release()
		for(var/obj/Damaging/Roaring_Thunder_Burn/D in oview(src))	if(D.Owner==src)	del D
		src.CanMove=1;src.SkillBeingCharged=null;src.icon_state="";src.InfBeamCost=0
	Black_Coffin()
		var/Damage;for(var/obj/Kidous/Hadous/Black_Coffin/K in src.Kidous)
			Damage=(1500+src.Kidou+src.MGC)*((0.25*(K.Level-1))+1)
		src.InstantAttack(src.Target,"Black Coffin",Damage,250,null)

mob/proc/InstantAttack(var/mob/Target,var/IS,var/Damage,var/ReiCost,var/Element)
	if(!src.CanMove)	return
	if(!Target)	{QuestShow(src,"Invalid Target");return}
	if(!(Target in oview(src,src.SightRange)))	{QuestShow(src,"Target out of Range");return}
	if(!src.UseRei(ReiCost))	return
	var/atom/Stepy=new/mob(usr.loc)
	if(step_to(Stepy,Target,0))
		MyFlick("Blast",src)
		PlayVoice(view(src,src.SightRange),pick(src.AttVoices))
		ShowEffect(Target.loc,'Effects.dmi',"[IS]","",10)
		src.Damage(Target,Damage,Element,0,"Mystic")
	else	QuestShow(src,"Target out of Range")
	if(Stepy!=usr)	del Stepy

mob/proc/FireBall(var/ReiCost,var/AttackPower,var/IS,var/mob/NTarget)
	if(ReiCost && !src.UseRei(ReiCost))	return
	src.CanMove=0
	MyFlick("F2",src)
	src.icon_state="Stance"
	PlayVoice(view(src,src.SightRange),pick(src.AttVoices))
	var/obj/Projectile/FireBall/F=new(AttackPower,10,src.dir,src.loc,src,NTarget)
	F.icon_state="[IS]"
	sleep(15);if(src)	src.CanMove=1

mob/var/InfBeamCost=0
mob/proc/InfBeamAttack(var/ReiCost,var/MoveStance,var/Se2Play,var/Damage,var/AttackType)
	if(!src.CanMove)	return
	if(!src.UseRei(ReiCost))	return
	src.InfBeamCost=ReiCost
	src.CanMove=0;src.icon_state=MoveStance
	var/turf/LastLoc=src.loc
	if(Se2Play)	PlaySoundEffect(view(src,src.SightRange),Se2Play)
	for(var/i=0,i<9,i++)
		var/turf/TurfCheck=get_step(LastLoc,src.dir)
		if(!TurfCheck || TurfCheck.density==1)	return
		var/ThisPath=text2path(AttackType)
		new	ThisPath(src.dir,get_step(LastLoc,src.dir),src,Damage)
		LastLoc=get_step(LastLoc,src.dir)