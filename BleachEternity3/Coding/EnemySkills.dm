//Enemies go through basic attack stuff (animations and counter step) before using a skill; in the EnemyAI() proc
mob/Enemy/proc
	Cry_for_Help()
		if(src.Blocking||!src.CanMove||src.Stunned)	return
		if(src.STM>src.MaxSTM/10)	return
		if(!src.UseRei(10))	return
		for(var/mob/Enemy/M in oview(9,src))
			if(src.StartedBy)	src.StartedBy.ForceEnemyStart(M)
			break

mob/proc/Blocked()
	if(src.Blocking)
		PlaySoundEffect(view(src,src.SightRange),pick('SwordBlock1.wav','SwordBlock2.wav'),2)
		ShowEffect(src,'Effects.dmi',"counterspark","between2",10)
		return 1

mob/proc
	Woosh()
		if(src.Blocking||!src.CanMove||src.Stunned)	return
		if(!src.UseRei(25))	return
		ShowEffect(get_step(src,src.dir),'Effects.dmi',"AirWoosh","",5,NewDir=src.dir)
		for(var/mob/M in get_step(src,src.dir))
			if(!M.Blocked())	{src.KnockBack(M,src);src.KnockBackFollow(M)}
	Slam()
		if(src.Blocking||!src.CanMove||src.Stunned)	return
		if(!src.UseRei(50))	return
		ShowEffect(get_step(src,src.dir),'SkillEffects.dmi',"Burst","",5)
		for(var/mob/M in get_step(src,src.dir))
			if(!M.Blocked())	M.StunProc(2,"Stun",src)
	Radial_Slam()
		if(src.Blocking||!src.CanMove||src.Stunned)	return
		if(!src.UseRei(50))	return
		for(var/turf/T in oview(1,src.loc))	ShowEffect(T,'SkillEffects.dmi',"Burst","",5)
		for(var/mob/M in oview(1,src))
			if(!M.Blocked())	M.StunProc(2,"Stun",src)
	Sting()
		if(src.Blocking||!src.CanMove||src.Stunned)	return
		if(!src.UseRei(50))	return
		ShowEffect(get_step(src,src.dir),'Effects.dmi',"PoisonCloud","",5)
		for(var/mob/M in get_step(src,src.dir))	if(!M.Blocked())
			M.AddEffect(new/datum/StatusEffects/PoisonTypes/Poison(10,src,10,"Deals 10 Poison Damage per Second for 10 Secs"))
	Poison_Cloud()
		if(src.Blocking||!src.CanMove||src.Stunned)	return
		if(!src.UseRei(50))	return
		for(var/turf/T in oview(1,src.loc))	ShowEffect(T,'Effects.dmi',"PoisonCloud","",5)
		for(var/mob/M in oview(1,src))	if(!M.Blocked())
			M.AddEffect(new/datum/StatusEffects/PoisonTypes/Poison(10,src,10,"Deals 10 Poison Damage per Second for 10 Secs"))