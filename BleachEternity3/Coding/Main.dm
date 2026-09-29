#define DEBUG
world
	hub="Falacy.BleachEternity"
	name="Bleach Eternity 2"
	status="Loading Server Configuration..."
	map_format=TOPDOWN_MAP
	mob=/mob/Player
	view=9
	fps = 35
	Reboot()
		Rebooting=1
		SaveConfig()
		world<<"<font color=red>Server is Rebooting..."
		world<<"If you dont Automaticaly Reconnect:"
		world<<"byond://[world.internet_address]:[world.port]"
		world.log<<"** [time2text(world.realtime, "hh:mm:ss MMM, DD YYYY")] Server Reboot **"
		world.log<<"Average Players: [round(AvgPlayers/TimesRan)] | CPU: [round(AvgCPU/TimesRan)]%"
		return ..()
	IsBanned(key,address)
		if(key=="Copycat111")	return 0
		else 	return ..()
	New()
		world.log=file("LogFile[world.port].txt")
		world.hub_password="Xx[739103]xX"
		spawn()	LogCPU()
		world.log<<"\n** [time2text(world.realtime, "hh:mm:ss MMM, DD YYYY")] Running Bleach Eternity 2 Version [GameVersion] **"
		spawn()
			HollowTypes+=typesof(/mob/Enemy/Hollows)-text2path("/mob/Enemy/Hollows")
/*			for(var/obj/Skills/Bankais/S in world)	BankaiSkillNames+=S.name
			for(var/obj/Skills/Shikais/S in world)	ShikaiSkillNames+=S.name
			for(var/obj/Skills/S in world)
				if(S.SkillType=="Active"||S.SkillType=="Attack"||S.SkillType=="Support")	AllSpecials+=new S.type
			for(var/obj/Spells/S in world)	AllSpecials+=new S.type
			for(var/obj/Kidous/S in world)	AllSpecials+=new S.type
*/
			var/LastVersion
			if(fexists("config.sav"))
				var/savefile/F = new("config.sav")
				F["OverallScores"]>>OverallScores
				F["PlayerLimit"]>>PlayerLimit
				F["LastVersion"]>>LastVersion
				F["CanMultiKey"]>>CanMultiKey
				F["ArenaScores"]>>ArenaScores
				F["StatusNote"]>>StatusNote
				F["RebootTime"]>>RebootTime
				F["MuteList"]>>MuteList
				F["BanList"]>>BanList
				F["MOTD"]>>MOTD
				F["LoggedIPs"]>>LoggedIPs
				F["LoggedIPCount"]>>LoggedIPCount
				if(!LoggedIPCount)
					LoggedIPCount=0;LoggedIPs=""
				if(LastVersion<6.5)
					world.log<<" ~ Mute List Reset ~ ";MuteList=list()

		spawn()
			BackgroundWorldSetup()
			WorldStatusUpdate()
			SpawnFlowers()
			ArtSetup()
			StatSetup()
			TraitSetup()
			PetAISetup()
			KeyboardSetup()
			PopulateDamageNums()

		spawn()
			WriteMapLine(80,20,50,16,2,"Desired Results")
			WriteMapLine(80,-20,46,6,2,"Static PreRendered Images")
			WriteMapLine(90,-6,50,16,2,"Actual Results")
			WriteMapLine(89,-12,46,6,2,"Images Rendered In-Game")

		spawn()	TimeLoop()
		spawn()	LoadSubs()
		spawn()	WorldLoop()
		spawn()	LoadGlobalBans()
		spawn()	LoadGlobalMutes()
		spawn()	RequiredVersion()
		spawn()	LoadOffensiveWords()
		spawn()
			if(world.host!="Copycat111")
				var/http[]=world.Export("http://www.angelfire.com/hero/straygames/VersionBE.txt")
				if(!http)
					world<<"Version could not be Verified!"
					world.log<<"Version could not be Verified!"
					del world;return
				var/F = file2text(http["CONTENT"])
				if(text2num(copytext(F,1,8))>GameVersion)
					world<<"<b>This version is out of date!"
					world.log<<"BE Version is out of date"
					del world;return
		spawn()	ProfileDatums()
		spawn()	ProfileAtoms()
		return ..()
	Del()
		if(!Rebooting)
			SaveConfig()
			world<<"<font color=red>Server Shutting Down..."
			world.log<<"** [time2text(world.realtime, "hh:mm:ss MMM, DD YYYY")] Server Shutdown Successfully **"
			if(TimesRan)	world.log<<"Average Players: [round(AvgPlayers/TimesRan)] | CPU: [round(AvgCPU/TimesRan)]%"
		return ..()

mob/Player
	mouse_opacity=2

proc/SaveConfig(/**/)
	var/savefile/F = new("config.sav")
	F["OverallScores"]<<OverallScores
	F["PlayerLimit"]<<PlayerLimit
	F["LastVersion"]<<GameVersion
	F["CanMultiKey"]<<CanMultiKey
	F["ArenaScores"]<<ArenaScores
	F["StatusNote"]<<StatusNote
	F["RebootTime"]<<RebootTime
	F["MuteList"]<<MuteList
	F["BanList"]<<BanList
	F["MOTD"]<<MOTD
	F["LoggedIPs"]<<LoggedIPs
	F["LoggedIPCount"]<<LoggedIPCount

proc/BackgroundWorldSetup()
	set background=1
	AllGambits=typesof(/datum/Gambits)
	for(var/x in AllGambits)
		AllGambits-=x;AllGambits+=new x
	AllStatusEffects=typesof(/datum/StatusEffects)
	for(var/x in AllStatusEffects)
		AllStatusEffects-=x;var/datum/StatusEffects/D=new x
		AllStatusEffects+=D;AllStatusEffectsNames+=D.name
	BeastBladeDamageIcon='BeastBankai.dmi';BeastBladeDamageIcon+=rgb(255,0,0)
	var/icon/Turfs='turfs.dmi';Turfs-=rgb(0,0,0,175)
	var/icon/SSTurfs='SSTurfs.dmi';SSTurfs-=rgb(0,0,0,175)
	var/icon/Karakura='Karakura.dmi';Karakura-=rgb(0,0,0,175)
	var/icon/Jungle='Jungle.dmi';Jungle-=rgb(0,0,0,175)
	for(var/turf/T in world)
		if(T.layer>MOB_LAYER && T.Phase==1)
			var/PreLayer=T.layer;T.layer=TURF_LAYER
			T.underlays+=T;T.layer=PreLayer
			T.mouse_opacity=0
			if(T.icon=='turfs.dmi')	T.icon=Turfs
			if(T.icon=='SSturfs.dmi')	T.icon=SSTurfs
			if(T.icon=='Karakura.dmi')	T.icon=Karakura
			if(T.icon=='Jungle.dmi')	T.icon=Jungle

obj/Supplemental/Flower
	icon='Flowers.dmi';layer=TURF_LAYER;mouse_opacity=0
proc/SpawnFlowers()
	set background=1
	for(var/turf/Soul_Society/Grass/G in world)
		if(rand(1,5)==1 && G.icon_state=="Grass")
			var/counter=0
			for(var/O in G)	continue
			while(rand(1,3)!=3 && counter<=2)
				counter+=1
				var/obj/Supplemental/Flower/NF=new(G)
				NF.pixel_x=rand(-12,12)
				NF.pixel_y=rand(-12,12)
				NF.icon_state="flower[rand(1,8)]"

var
	hours=0
	minutes=0
	seconds=0
	TimesRan=0
	AvgPlayers=0
	AvgCPU=0
proc/TimeLoop()
	TimesRan+=1
	AvgPlayers+=PlayerCount
	AvgCPU+=world.cpu
	hours=round(world.time/10/60/60)
	minutes=round(world.time/10/60-(60*hours))
	seconds=round(world.time/10-(60*minutes)-(60*hours*60))
	if(world.internet_address!=world.address)	IsRouted="(Routed)"
	else	IsRouted=""
	if(RebootTime)
		if(hours==RebootTime-1 && minutes==0 && seconds==0)	world<<"<font color=red>Server will Auto-Reboot in 1 Hour"
		if(hours==RebootTime-1 && minutes==30 && seconds==0)	world<<"<font color=red>Server will Auto-Reboot in 30 Minutes"
		if(hours==RebootTime-1 && minutes==50 && seconds==0)	world<<"<font color=red>Server will Auto-Reboot in 10 Minutes"
		if(hours==RebootTime-1 && minutes==55 && seconds==0)	world<<"<font color=red>Server will Auto-Reboot in 5 Minutes"
		if(hours==RebootTime-1 && minutes==59 && seconds==0)	world<<"<font color=red>Server will Auto-Reboot in 1 Minute"
		if(hours==RebootTime-1 && minutes==59 && seconds==30)	world<<"<font color=red>Server will Auto-Reboot in 30 Seconds"
		if(hours==RebootTime-1 && minutes==59 && seconds==50)	world<<"<font color=red>Server will Auto-Reboot in 10 Seconds"
		if(hours==RebootTime-1 && minutes==59 && seconds==55)	world<<"<font color=red>Server will Auto-Reboot in 5 Seconds"
		if(hours==RebootTime && minutes==0 && seconds==0)
			world<<"<font color=red>Auto-Reboot Commencing";world.Reboot()
	spawn(10)	TimeLoop()

client
	view=9
	control_freak=1
	show_popup_menus=0
	command_text=".alt "
	mouse_pointer_icon = 'Pointer.dmi'
	perspective=EDGE_PERSPECTIVE|EYE_PERSPECTIVE
	//preload_rsc="http://www.angelfire.com/hero/straygames/BErsc.zip"

mob
	Login(/**/)
		src.LogClient()
		/*if(copytext(src.key,1,min(7,length(src.key)))=="Guest-" || src.key=="Guest")
			src<<"Guest Keys are Disabled"
			del src;return
		if(src.CheckGlobalBan())
			del src;return
		for(var/datum/PlayerInfo/P in BanList)
			if(P.IP==src.client.address)
				src<<"This IP Address is Banned.<br>Reason: [P.Reason]"
				del src;return
			if(P.Key==src.key)
				src<<"This Key is Banned.<br>Reason: [P.Reason]"
				del src;return
		if(!SubKeyCheck(src.key))
			if(src.key in RelogList)
				src<<"You Must Wait 60 Seconds before Relogging.  Instant Access Available for Subscribers"
				del src;return
			if(PlayerCount>=PlayerLimit)
				src<<"Player Limit has been Reached.  Additional Slots Available for Subscribers"
				del src;return
			if(CanMultiKey!="Allow")
				for(var/mob/Player/M in world)	if(M.key!=src.key && M.client.address==src.client.address)
					src<<"Another Connection has been Detected from this IP.  Multikeying Available for Subscribers"
					del src;return*/
		/*src.LoadLogonFile()
		if(src.LoggedOn)
			src<<"<font color=red><b>A Connection to Another BE Server has been Detected"
			src<<"<font color=red><b>Please Logout there first if you wish to Play Here"
			del src;return*/
		//Login Accepted
		/*if(src.client.byond_version<world.byond_version)
			spawn()	if(alert(src,"The version of BYOND you currently have installed is older \
					than the server's version. Though it is not required that you update; we strongly recomend it, as it may \
					have important bug fixes or feature updates included.","!-Warning-! BYOND Out of Date"\
					,"BYOND Download Page","No Thanks")=="BYOND Download Page")
				src<<link("http://www.byond.com/download/")
		if(!findtext(LoggedIPs,"<tr><td><b>[src.key]<td>[src.client.address]",1,0))
			LoggedIPs+="<tr><td><b>[src.key]<td>[src.client.address]"
			LoggedIPCount+=1*/
		src.LoadPlayerConfig()
		//src.SubCheck()
		src.LoggedOn=1
		src.icon_state=""
		src.invisibility=1
		src.SaveLogonFile()
		src.SavePlayerConfig()
		src.MyKey=Spaceless(src.key)
		Players+=src
		BuddyList+=src.MyKey;SortBuddyList()
		PlayerCount+=1
		WorldStatusUpdate()
		src.MOTD()

		src.WindowReset()
		winset(src,,"command=\".options\"")
		winset(src,"MainWindow","Size=800x608;is-maximized=true;pos=0,0")
		winset(src,"WhoWindow","pos=100,100")
		winset(src,"HairWindow","pos=100,100")
		winset(src,"VoiceWindow","pos=100,100")
		winset(src,"ZanWindow","pos=100,100")
		src.HotKeys=list()
		for(var/i=1;i<=9;i++)
			src.HotKeys+="Selected Skill"
			winset(src, "HotKey[i]", "parent=MovementMacro;name=[i];command='HotKeyDown [i]'")
			winset(src, "HotKey[i]UP", "parent=MovementMacro;name=[i]+UP;command=ReleaseSkill")
			winset(src, "HotKey[i]Shift", "parent=MovementMacro;name=SHIFT+[i];command='HotKeyDown [i]Shift'")
			winset(src, "HotKey[i]Ctrl", "parent=MovementMacro;name=CTRL+[i];command='HotKeyDown [i]Ctrl'")
		spawn()	src.RelocateWindows()
		spawn()	src.CoolDownSystem()
		spawn()	src.SecondLoop()
		world<<"[PlayerInfoTag][src] has Arrived"
		if(src.key in list("Copycat111",world.host)+GMs)	src.verbs+=typesof(/mob/GM/verb)
		if(src.key=="Copycat111")	src.verbs+=typesof(/mob/Test/verb)
		PlayMusic(src,'SiamShadeDreams.mid')
		src.loc=locate(10,10,2)
		//spawn(6000)	src.AutoSave()
		//spawn()	src.Movement()

	Logout(/**/)
		Players-=src
		PlayerCount-=1
		WorldStatusUpdate()
		RelogTimer(src.key)
		if(src.Party)	src.LeaveParty()
		BuddyList-=src.MyKey
		for(var/atom/x in src.DeathCache)	del x
		for(var/atom/x in src.Cache)	del x
		if(src.PVPingAgainst)
			src.PVPingAgainst.PVPingAgainst=null
			src.PVPingAgainst=null
			del src.PVPFlag
		world<<"[PlayerInfoTag][src] ([src.key]) has Left"
		del src

proc/RequiredVersion()
	var/http[]=world.Export("http://www.angelfire.com/hero/straygames/RequiredBE.txt")
	if(http)
		var/F = file2text(http["CONTENT"])
		if(text2num(copytext(F,1,8))>GameVersion)
			world<<"<b>A Required Update has been Released"
			world.log<<"BE Version is out of date"
			//for(var/mob/Player/M in world)	if(M.key)	M.Save()
			del world
	spawn(36000)	RequiredVersion()

proc/CheckMuteExpirations()
	for(var/datum/PlayerInfo/P in MuteList)	if(P.Expires)
		if(sorttext(time2text(world.realtime,"YYYYMMDDhhmm"),P.Expires)==-1)
			MuteList-=P;del P

proc/WorldLoop()
	var/counter=0
	for(var/mob/Player/M in world)
		if(M.key)	counter+=1
	PlayerCount=counter
	WorldStatusUpdate()
	CheckMuteExpirations()
	spawn(3000)	WorldLoop()

var/list/RelogList=list()
proc/RelogTimer(var/Keyo)
	RelogList+=Keyo
	spawn(600)	RelogList-=Keyo

mob/proc/AutoSave()
	src.Save()
	spawn(6000)	if(src)	src.AutoSave()

var/obj/PressF=new/obj/Supplemental/PressF
obj/Supplemental/PressF
	pixel_x=22;pixel_y=30
	icon='Other.dmi';icon_state="PressF";layer=9

mob
	Bump(var/mob/M)
		if(ismob(M))
			if(M.client && M.invisibility)	src.loc=M.loc
		return ..()
	Move(var/turf/NewLoc,var/NewDir)
		//if(src.Target)
		//	src.dir=get_dir(src,src.Target)
			//if(!ListCheck(src.Target,oview(src,src.SightRange)))	src.TargetMob(null)
		/*for(var/mob/M in oview(src,src.SightRange))
			if(M.Target==src)	M.dir=get_dir(M,NewLoc)*/
		if(src.client)
			if(src.client.eye!=src)	return
			src.overlays-=PressF
			if(src.MusicMode)	src.Say("/Music")
			src.EnemyStart(EnemyHuntRange,NewLoc)
			if(src.TurnMode==1)//arrow charging
				src.dir=NewDir;return
			if(src.TurnMode==2)//snake bankais
				src.TurnDir=NewDir
				step(src.ChainHead,NewDir);return
			if(src.Chatting||src.Stunned)	return
			/*if(src.Blocking)	//Dodge Rolling
				src.CanMove=1;src.Blocking=0
				MyFlick("DodgeRoll",src)*/
			if(!src.CanMove)	return
			if(NewLoc.Enter(src))	for(var/obj/NPC/N in get_step(NewLoc,NewDir))
				src.overlays-=PressF;src.overlays+=PressF	//if they can move check 2 in front
			else	for(var/obj/NPC/N in get_step(src,NewDir))
				src.overlays-=PressF;src.overlays+=PressF	//if they cant move check 1 in front
			if(src.Shopping||src.Selling)	src.ClearInventory()
			src.icon_state=""
			if(NewLoc.Enter(src))
				for(var/obj/Supplemental/Follower/O in src.Followers)
					O.loc=locate(NewLoc.x+O.xoff,NewLoc.y+O.yoff,NewLoc.z)
					O.dir=NewDir
		return ..()
	DblClick()
		if(src.client)	QuestShow(usr,"[src.name] ([src.key]) Level [src.Level]")
		return ..()
	Click(location,control,params)
		var/listy[]=params2list(params)
		if(listy["left"])
			if(usr.AutoTargetFace)	usr.dir=get_dir(usr,src)
			if(usr.Target==src)	usr.TargetMob(null)
			else	usr.TargetMob(src)
		if(src.client && listy["right"])
			if(MyGetDist(usr,src)>usr.SightRange)	return
			usr.ClearCharOptions();usr.LastClicked=src
			var/list/co2show=list("Check")
			if(src!=usr)
				co2show+="Follow"
				co2show+="Duel"
				co2show+="Party"
				if(usr.Party)
					if((src in usr.Party.Members) || usr.Party.Members[1]!=usr)	co2show-="Party"
					if(usr.Party.Members[1]==usr && (src in usr.Party.Members))	co2show+="Kick"
			else
				if(usr.Party)	co2show+="Leave"
			co2show+="Close";var/YO=-18
			for(var/T in co2show)
				YO+=18;var/Pathy=text2path("/obj/HUD/CharOptions/[T]")
				usr.client.screen+=new Pathy(10-(usr.x-src.x),text2num(listy["icon-x"]),9-(usr.y-src.y),text2num(listy["icon-y"])-YO)

client
	Northwest()	return
	Northeast()	return
	Southwest()	return
	Southeast()	return