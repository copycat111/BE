mob/Pets
	var/list/Gambits[5]
	var/tmp/Pulling=0
	var/tmp/Thinking=0
	RespawnX=0;RespawnY=0;RespawnZ=0
	Click(location,control,params)
		var/listy[]=params2list(params)
		if(listy["right"])
			if(MyGetDist(usr,src)>usr.SightRange)	return
			usr.ClearCharOptions();usr.LastClicked=src
			var/list/co2show=list();var/YO=-18
			if(src.Owner==usr)
				co2show+="Name"
				co2show+="Close"
			for(var/T in co2show)
				YO+=18;var/Pathy=text2path("/obj/HUD/CharOptions/[T]")
				usr.client.screen+=new Pathy(10-(usr.x-src.x),text2num(listy["icon-x"]),9-(usr.y-src.y),text2num(listy["icon-y"])-YO)
	New()
		src.AddName()
		spawn()	while(src)
			src.StatusDuration()
			sleep(10)
		if(!src.Gambits[1])
			var/datum/Gambits/GambitHolder/G=new
			src.Gambits[1]=G
			G.Target=new/datum/Gambits/Targets/Enemy
			G.Variable=new/datum/Gambits/Variables/Stamina
			G.Operator=new/datum/Gambits/Operators/GreaterThan
			G.VariableType=new/datum/Gambits/VariableTypes/Amount
			G.VariableType.Value=0
			G.Action=new/datum/Gambits/Actions/Attack
		return ..()
	proc/ActivateAI()
		if(src.Thinking)	return
		src.Thinking=1
		while(src && src.Owner)
			if(src.Owner.invisibility)
				src.loc=null;src.Thinking=0;return
			if(src.Thinking && MyGetDist(src,src.Owner)<=9)
				walk(src,0)
				for(var/datum/Gambits/GambitHolder/G in src.Gambits)
					if(G.ActivateGambit(src.Owner,src))	goto GambitActivated
			src.Thinking=0;walk_to(src,src.Owner,1);return
			GambitActivated
			sleep(5)
	GenericPets
		Nibblet
			icon='Nibblet.dmi'
	BountPets
		Fly_Trap
			icon='BountPet.dmi'

obj/Items/PetItems
	Nibblet_Flute
		Unique=1;icon='OtherItems.dmi'
		desc="Play this Flute to Summon your Nibblet."
		icon_state="Nibblet Flute";mouse_drag_pointer="Nibblet Flute"
		Use(var/mob/M)
			for(var/mob/Pets/GenericPets/Nibblet/P in M.Pets)
				if(MyGetDist(M,P)>=10)
					MyFlick("Blast",M);M.icon_state="Stance"
					PlaySoundEffect(view(M,M.SightRange),'Flute.mid')
					P.STM=P.MaxSTM;P.REI=P.MaxREI
					P.StmBar();P.ReiBar();P.Thinking=0
					P.loc=M.loc;step_rand(P);walk_to(P,M,1)
					ShowEffect(P,'Effects.dmi',"Appear",duration=10)