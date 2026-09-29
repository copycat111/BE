mob/var/TurnDir=0
mob/var/obj/Bankai/Chains/ChainHead
mob/var/list/ChainList=list()
var/BeastBladeDamageIcon

mob/verb/StartChain()
	set hidden=1
	usr.ChainStart()

mob/proc/ChainStart()
	if(!src.CanMove)	return
	if(src.dir==5||src.dir==6||src.dir==9||src.dir==10)	src.dir=2
	src.ChainHead=new/obj/Bankai/Chains/Beast_Blade(get_step(src,src.dir))
	var/turf/T=get_step(src,src.dir)
	if(!T.Enter(src.ChainHead))
		del src.ChainHead;return
	src.ChainList=list()
	src.CanMove=0
	src.TurnMode=2
	src.TurnDir=src.dir
	src.icon_state="Blast"
	src.ChainHead.Owner=src;src.ChainHead.icon_state="Head";src.ChainHead.Damage=src.STR;src.ChainHead.dir=src.dir
	src.ChainHead.LastLoc=src.loc;src.ChainHead.LastDir=src.dir
	src.ChainHead.ActualDir=src.dir;src.ChainHead.NextDir=src.dir

obj/Bankai
	Chains
		density=1
		var/HP=100
		var/MaxHP=100
		var/mob/Owner
		var/Damage=0
		var/LastLoc
		var/LastDir
		var/ActualDir
		var/NextDir
		var/DamageIcon
		Beast_Blade
			icon='BeastBankai.dmi'
			icon_state="Body"
			New()
				src.DamageIcon=BeastBladeDamageIcon
				return ..()

		proc/Destroy(/**/)
			if(!src.HP)	return
			src.HP=0;src.density=0
			MyFlick("Destroy",src);src.icon_state="invis"
			spawn(10)	if(src)	del src
			sleep(1);for(var/obj/Bankai/Chains/C in get_step(src,src.BackDir(src.ActualDir)))	spawn()	C.Destroy()

		proc/DestroyForward()
			if(!src.HP)	return
			src.HP=0;src.density=0
			MyFlick("Destroy",src);src.icon_state="invis"
			spawn(10)	if(src)	del src
			sleep(1);for(var/obj/Bankai/Chains/C in get_step(src,src.NextDir))	spawn()	C.DestroyForward()

		New()
			spawn(1)
				spawn()	src.PixelShift()
				while(src.Owner)	sleep(5)
				del src
		Move(turf/NewLoc,NewDir)
			if(!ListCheck(NewLoc,oview(src.Owner.SightRange,src.Owner)))	return
			if(NewLoc.Enter(src))
				var/obj/Bankai/Chains/NP=new src.type(src.loc)
				NP.dir=get_dir(src.LastLoc,NewLoc)
				NP.ActualDir=get_dir(src.LastLoc,src);NP.NextDir=NewDir
				if(get_dir(src.LastLoc,src)==NORTH && NewDir==WEST)	NP.dir=9
				if(get_dir(src.LastLoc,src)==NORTH && NewDir==EAST)	NP.dir=5
				if(get_dir(src.LastLoc,src)==SOUTH && NewDir==WEST)	NP.dir=10
				if(get_dir(src.LastLoc,src)==SOUTH && NewDir==EAST)	NP.dir=6
				if(get_dir(src.LastLoc,src)==EAST && NewDir==NORTH)	NP.dir=10
				if(get_dir(src.LastLoc,src)==EAST && NewDir==SOUTH)	NP.dir=9
				if(get_dir(src.LastLoc,src)==WEST && NewDir==NORTH)	NP.dir=6
				if(get_dir(src.LastLoc,src)==WEST && NewDir==SOUTH)	NP.dir=5
				NP.Owner=src.Owner
				src.Owner.ChainList+=NP
				src.LastLoc=NP.loc;src.LastDir=get_dir(NP,NewLoc)
				src.ActualDir=get_dir(src,NewLoc);src.NextDir=get_dir(src,NewLoc)
			return ..()
		Bump(atom/M)
			if(!src.Owner)	return
			if(ismob(M))
				src.Owner.Damage(M,src.Damage,src.Owner.Element)
				return
			if(istype(M,/obj/Bankai/Chains))
				src.Owner.DamageChain(M,src.Owner.STR+rand(-5,5))
				return
			src.Owner.DamageChain(src,src.Owner.STR+rand(-5,5))
			/* BELOW = INSTANT src DEATH ON BUMP
			src.Owner.TurnMode=0
			MyFlick("Destroy",src)
			src.icon_state="invis"
			src.density=0
			for(var/obj/Bankai/Chains/C in get_step(src,src.BackDir(src.LastDir)))	C.Destroy()
			if(src.Owner)
				src.Owner.icon_state=""
				src.Owner.CanMove=1
			del src
			*/

atom/proc/PixelShift(var/ShiftVal=0,var/ShiftBy=1,var/ShiftMin=-2,var/ShiftMax=2)
	while(src)
		ShiftVal+=ShiftBy
		if(ShiftVal>=ShiftMax || ShiftVal<=ShiftMin)	ShiftBy=-ShiftBy
		if(src.dir==NORTH||src.dir==SOUTH)	src.pixel_x=ShiftVal
		if(src.dir==EAST||src.dir==WEST)	src.pixel_y=ShiftVal
		sleep(2)