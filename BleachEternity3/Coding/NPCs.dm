datum/PathDatum
	var/turf/Loc
	var/WaitTime=4
	New(var/x,var/y,var/z,var/WT=4)
		src.WaitTime=WT
		src.Loc=locate(x,y,z)
		return ..()

/*turf/Entered(var/obj/NPC/Pathed/P)
	if(istype(P,/obj/NPC/Pathed))
		if(src==P.CurPath.Loc)
			spawn(P.CurPath.WaitTime)
				if(P.CurPathNum+P.Dir<=0)	P.Dir=1
				if(P.CurPathNum+P.Dir>P.PathLocs.len)
					var/datum/PathDatum/PL=P.PathLocs[1]
					if(P.loc==PL.Loc)	{P.Dir=1;P.CurPathNum=1}
					else	P.Dir=-1
				P.CurPathNum+=P.Dir;P.CurPath=P.PathLocs[P.CurPathNum]
				walk_to(P,P.CurPath.Loc,0,P.WalkSpeed)
	return ..()*/

mob/Supplemental
	Falacy
		icon='SoulReaper.dmi'
		New()
			src.StmBar()
			src.ReiBar()
			src.AddName()
			src.AddHair("Toshiro")
			return ..()

obj/NPC
	layer=4
	density=1
	mouse_opacity=0
	var/list/Quests=list()
	icon='SoulReaper.dmi'
	New()
		src.AddName()
		if(src.name=="Yoruichi")	src.AddHair("Yoruichi")
		if(src.icon=='SoulReaper.dmi'||src.icon=='Captain.dmi'||src.icon=='SchoolFemale.dmi')
			var/obj/HO=new/obj/HairOver
			if(src.gender=="female"||src.icon=='SchoolFemale.dmi')	HO.icon='yoruichi.dmi'
			else	HO.icon=pick('ichigo.dmi','toshiro.dmi','urahara.dmi','uryu.dmi','renji.dmi','Byakuya.dmi','Kenpachi.dmi','Izuru.dmi','Maki.dmi')
			HO.icon=MyRGB(HO.icon,rgb(rand(0,100),rand(0,100),rand(0,55)))
			src.overlays+=HO
	Other
		Portal
			layer=8
			density=0
			var/mob/Owner
			var/PortalTo="Outpost"
			icon='Effects.dmi';icon_state="Portal"
			DblClick()
				if(usr.Chatting)	return
				if(usr.RegenWait>=0)	{QuestShow(usr,"Cannot be Entered During Combat");return}
				if(!src.Owner)
					if(src.icon_state!="invis")	del src
					return
				if(src in get_step(usr,usr.dir))
					var/DelWarning=""
					if(src.Owner==usr)	DelWarning="Entering your own Portal will cause it to Close."
					if(ShowAlert(usr,"Enter [src.Owner.name]'s Portal to [src.PortalTo]? > > [DelWarning]",list("Enter","Cancel"))=="Enter")
						if(!src || !src.Owner || src.icon_state=="invis")	return
						for(var/obj/NPC/Shopish/Transporter/M in world)	if(M.Place==src.PortalTo)
							usr.loc=get_step(M,M.dir);break
						if(src.Owner==usr)	del src
			New()
				MyFlick("PortalOpen",src)
			Del()
				src.icon_state="invis"
				MyFlick("PortalClose",src)
				sleep(4);return ..()
	Random
		var/Message="Hello"
		QuestChest
			icon='QuestItems.dmi';icon_state="Diary"
			var/Item2Give="/obj/Items/QuestItems/Diary"
			New()
				return
			DblClick()
				var/obj/O=new src.Item2Give
				if(usr.GetItem(O))
					src.loc=locate(rand(80,100),rand(80,100),2)
					spawn(300)	src.loc=locate(initial(src.x),initial(src.y),initial(src.z))
		Chest
			icon='Jungle.dmi';icon_state="Chest"
			var/Item2Give="/obj/Items/Potions/Energy_Drink"
			New()
				src.name="";return ..()
			DblClick()
				MyFlick("OpenChest",src);PlaySoundEffect(usr,'Open1.wav')
				if(src.Item2Give=="Empty")
					QuestShow(usr,"It Looks Empty...");return
				if(findtext(usr.ChestList,"*[src.x],[src.y],[src.z]",1,0))
					QuestShow(usr,"Already Looted this Chest!");return
				var/obj/O=new src.Item2Give
				if(usr.GetItem(O))	usr.ChestList+="*[src.x],[src.y],[src.z]"
		Window
			density=1;icon_state="Window"
			name="";icon='Interior.dmi'
			DblClick()
				PlaySoundEffect(usr,'Menu.wav')
				if(src.icon_state=="Window")	src.icon_state="ClosedWindow"
				else	src.icon_state="Window"
		Arena_Sign
			name=""
			icon='Arena.dmi';icon_state="SignL"
			pixel_y=-8
			DblClick()
				PlayMenuSound(usr,'TP_Talk_Start.wav')
				usr.ViewArenaScores();winset(usr,"MainWindow.MapMain","focus=true")
		Sign
			name="";icon='NPCs.dmi';icon_state="Sign"
			Message="- Posted Notice - > > Be Aware,  The following Areas are not 100% Completed at this point in time."
		Restaurant_Owner
			Message="Sorry, we're still getting a menu together.  Come back another time."
		Talker
			Message="..."
		Chilly_Girl
			icon='NPCs.dmi'
			icon_state="Little Girl"
			Message="Hey!  It's cold in here!"
		DblClick()
			if(src in get_step(usr,usr.dir))
				PlayMenuSound(usr,'TP_Talk_Start.wav')
				ShowText(usr,src.Message)
	Pathed
		var/CurPathNum=2;var/Dir=1
		var/datum/PathDatum/CurPath
		var/list/PathLocs=list()
		var/Message;var/WalkSpeed=4
		Krain
			Message="They say if you Graft hollow masks together you can make powerfull equipment Shards"
			New()
				var/PT=text2path("/datum/PathDatum")
				src.PathLocs=list(new PT(28,153,3,20),new PT(28,135,3,30));return ..()
		Energetic_Girl
			icon='NPCs.dmi'
			icon_state="Spaz"
			Message="AHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH"
			WalkSpeed=1
			New()
				var/PT=text2path("/datum/PathDatum")
				src.PathLocs=list(new PT(41,139,3),new PT(59,139,3),new PT(59,145,3),new PT(41,145,3),new PT(41,139,3))
				return ..()
		Trainee
			Message="Work hard and maybe someday you can become a Captain!"
			New()
				var/PT=text2path("/datum/PathDatum")
				src.PathLocs=list(new PT(165,23,3,100),new PT(165,34,3),new PT(173,34,3),new PT(173,17,3),new PT(182,17,3,50))
				return ..()
		DblClick()
			if(src in get_step(usr,usr.dir))
				PlayMenuSound(usr,'TP_Talk_Start.wav')
				ShowText(usr,src.Message)
		New()
			return ..()
			spawn(rand(5,10))
				src.CurPath=src.PathLocs[2]
				walk_to(src,src.CurPath.Loc,0,src.WalkSpeed)
			return ..()

	Shopish
		Arena_Manager
		BlankArenaManager
			icon=null;name=""
			DblClick()
				if(src in get_step(usr,usr.dir))
					//ShowText(usr,"The Arena is currently closed for maintenance.  We'll be in working condition again shortly!");return
					if(ShowAlert(usr,"Welcome to the Golden Arena! > > Here you can engage in battle with hollows from around the world! > Each round you successfully complete will net you some bonus Copper.  Of course, if you end up falling in combat that bonus will be lost. Be carefull not to exceed your limits! > > So whataya say? Interested in signing up?",list("Register","Cancel"))=="Register")
						usr.ArenaRound=0;usr.ArenaBonus=0
						usr.StartArena()
		Name_Changer
			DblClick()
				if(src in get_step(usr,usr.dir))
					if(!usr.Subscriber)
						ShowAlert(usr,"This Service is only Available to Stray Games Subscribers!");return
					if(ShowAlert(usr,"If you'd like I can change your character's name for you. > This service is provided for free and can be used an unlimited amount of times",list("Change","Cancel"))=="Change")
						usr.ChangeName()
						if(usr)	usr.AddName()
		Respeccer
			DblClick()
				if(src in get_step(usr,usr.dir))
					var/GoldCost=0;var/SilvCost=5;if(usr.Subscriber)	SilvCost=0
					SilvCost*=usr.RespecUses+1;SilvCost=min(10000,SilvCost)
					while(SilvCost>=100)	{GoldCost+=1;SilvCost-=100}
					var/GoldTag=(GoldCost ? "[GoldCost] Gold" : "");var/AndT=(GoldCost&&SilvCost ? " and " : "")
					var/SilvTag=(SilvCost ? "[SilvCost] Silver" : "");GoldTag=(!GoldCost&&!SilvCost ? "Free for Subs" : "[GoldTag]")
					if(ShowAlert(usr,"If you want I can Reset all your Skill, Stat, and Trait Points for [GoldTag][AndT][SilvTag].",list("Respec","Cancel"))=="Respec")
						if(CheckGold(TrueValue(usr),TrueValue(GoldCost,SilvCost,0)))
							usr.Respec();usr.RespecUses+=1
							usr.TakeGold(GoldCost,SilvCost,0)
							QuestShow(usr,"Your Character has been Respecced")
						else	ShowAlert(usr,"You dont have enough!  It costs [GoldTag][AndT][SilvTag] to Respec your Character!")
						if(!GoldCost && !SilvCost)	ShowAlert(usr,"To show our appreciation for your support of Stray Games... > This service has been provided free of charge!")
		Barber
			DblClick()
				if(src in get_step(usr,usr.dir))
					var/GoldCost=0;var/SilvCost=5;if(usr.Subscriber)	SilvCost=0
					SilvCost*=usr.BarberUses+1;SilvCost=min(10000,SilvCost)
					while(SilvCost>=100)	{GoldCost+=1;SilvCost-=100}
					var/GoldTag=(GoldCost ? "[GoldCost] Gold" : "");var/AndT=(GoldCost&&SilvCost ? " and " : "")
					var/SilvTag=(SilvCost ? "[SilvCost] Silver" : "");GoldTag=(!GoldCost&&!SilvCost ? "Free for Subs" : "[GoldTag]")
					if(ShowAlert(usr,"Interested in trying a new hair style?  Only [GoldTag][AndT][SilvTag].",list("Cut","Cancel"))=="Cut")
						if(CheckGold(TrueValue(usr),TrueValue(GoldCost,SilvCost,0)))
							usr.HairColor()
							usr.dir=SOUTH;usr.BarberUses+=1
							usr.TakeGold(GoldCost,SilvCost,0)
						else	ShowAlert(usr,"You dont have enough!  It costs [GoldTag][AndT][SilvTag] to Change your Hair Style!")
						if(!GoldCost && !SilvCost)	ShowAlert(usr,"To show our appreciation for your support of Stray Games... > This service has been provided free of charge!")
		Zanpakuto_Manager
			DblClick()
				if(src in get_step(usr,usr.dir))
					for(var/obj/Skills/SoulReaper/Shikai/S in usr.Skills)
						var/GoldCost=0;var/SilvCost=10000;if(usr.Subscriber)	SilvCost=0
						while(SilvCost>=100)	{GoldCost+=1;SilvCost-=100}
						var/GoldTag=(GoldCost ? "[GoldCost] Gold" : "");var/AndT=(GoldCost&&SilvCost ? " and " : "")
						var/SilvTag=(SilvCost ? "[SilvCost] Silver" : "");GoldTag=(!GoldCost&&!SilvCost ? "Free for Subs" : "[GoldTag]")
						if(ShowAlert(usr,"Interested in trying a new Zanpakuto and a Respec?  Only [GoldTag][AndT][SilvTag].",list("Change","Cancel"))=="Change")
							if(CheckGold(TrueValue(usr),TrueValue(GoldCost,SilvCost,0)))
								usr.TakeGold(GoldCost,SilvCost,0);usr.Respec();usr.ZanCreation()
							else	ShowAlert(usr,"You dont have enough!  It costs [GoldTag][AndT][SilvTag] to Change your Zanpakuto!")
							if(!GoldCost && !SilvCost)	ShowAlert(usr,"To show our appreciation for your support of Stray Games... > This service has been provided free of charge!")
						return
					ShowAlert(usr,"You don't seem to have a Zanpakuto available...")

		Transporter
			var/Place="Arial"
			var/list/Places=list("Outpost","Karakura","Cancel")
			DblClick()
				if(!(src in get_step(usr,usr.dir)))	return
				if(!(src.Place in usr.TransLocs))
					usr.TransLocs+=src.Place
					ShowAlert(usr,"Your soul has been connected with the Transporter at [src.Place].  You can now transport here from nearby locations.",list("OK"))
					return
				var/list/Options=list()
				for(var/v in src.Places)	if(v in usr.TransLocs)	Options+=v
				if(!Options.len)
					ShowAlert(usr,"Your soul isn't connected to any nearby locations.  I won't be able to transport you anywhere, sorry.  You must speak with other Transporters before I can send you to them.",list("OK"))
					return
				Options+="Cancel"
				var/Place2Go=ShowAlert(usr,"We are currently at [src.Place]. > Where would you like to go?",Options)
				for(var/obj/NPC/Shopish/Transporter/T in world)
					if(T.Place==Place2Go)
						ShowEffect(usr,'Effects.dmi',"PortalFlash","",4);sleep(3);if(!usr)	return
						usr.loc=get_step(T,T.dir)
						usr.dir=get_dir(usr,T)
		Spirit_Master
			DblClick()
				if(src in get_step(usr,usr.dir))
					for(var/obj/Items/Other/Progress_Cupon/C in usr.Inventory)
						switch(ShowAlert(usr,"It appears you have a Progress Cupon.  If you'd like I'll give you a Respec Cupon or a Barber Cupon in exchange for it.",list("Respec","Barber","Cancel")))
							if("Respec")
								C.Discard(1);usr.GetItem(new/obj/Items/Other/Respec_Cupon)
							if("Barber")
								C.Discard(1);usr.GetItem(new/obj/Items/Other/Barber_Cupon)
						return
					ShowText(usr,"If you bring me a Progress Cupon I'll trade you something good for it.")
		Spirit_Manager
			DblClick()
				if(src in get_step(usr,usr.dir))
					switch(ShowAlert(usr,"How can I help you?",list("Rest","Spawn","Cancel")))
						if("Rest")
							usr.STM=usr.MaxSTM
							usr.REI=usr.MaxREI
							usr.StmBar()
							usr.ReiBar()
							ShowAlert(usr,"Stamina and Reiatsu Restored!",list("OK"))
						if("Spawn")
							if(ShowAlert(usr,"Would you like to set your Respawn Point to this Location?",list("Yes","No"))=="Yes")
								usr.SetRespawn()