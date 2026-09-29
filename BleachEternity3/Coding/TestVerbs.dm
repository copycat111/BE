mob/Test/verb/Test(/**/)
	set category="Test"
	if(usr.key=="Falacy")
		usr.Skills+=new/obj/Skills/SoulReaper/Bankai
		usr.Zanpakuto=new/obj/Zanpakuto
		usr.Zanpakuto.SpiritType="Beast"
		//usr.loc=locate(43,102,10)	//volcano location
		//usr.GetItem(new/obj/Items/Other/Progress_Cupon)
		//ShowAlert(usr,"aAbBcCdDeEfFgGhHiIjJkKlLmMnNoOpPqQrRsStTuUvVwWxXyYzZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")
	else
		usr<<"This verb is used to test various things around the game."
		usr<<"It can only be used by Falacy and was left visible accidentally."

mob/Test/verb/CheckObjects()
	set category="Test"
	if(usr.key!="Falacy")	return
	var/counter=0
	for(var/obj/O in world)	counter+=1
	usr<<"Object Count: [counter]"

proc/ProfileDatums()
	for(var/datum/D)
		var/FindLoc=LastDatumList.Find("[D.type]")
		if(!FindLoc)
			LastDatumList+="[D.type]";FindLoc=LastDatumList.len
		LastDatumList["[D.type]"]+=1

var/list/LastDatumList=list()
mob/Test/verb/Profile_Datums()
	set category="Test"
	set background=1
	if(usr.key!="Falacy")	return
	usr<<"Starting Datum Profiler..."
	var/list/DatumList=list()
	var/TotalCount=0
	for(var/datum/D)
		if(istype(D,/atom))	continue
		var/FindLoc=DatumList.Find("[D.type]")
		if(!FindLoc)
			DatumList+="[D.type]";FindLoc=DatumList.len
		DatumList["[D.type]"]+=1;TotalCount+=1
	var/UpOutput="<center><table border=1><tr><td><b>Datum Type<td><b>UP Type Count"
	UpOutput+="<tr><td><b>Total Datum Count<td><b>[TotalCount]"
	var/DownOutput="<table border=1><tr><td><b>Datum Type<td><b>DOWN Type Count"
	var/NewOutput="<table border=1><tr><td><b>Datum Type<td><b>NEW Type Count"
	var/HtmlOutput="<table border=1><tr><td><b>Datum Type<td><b>Type Count"
	for(var/v in DatumList)
		if(v in LastDatumList)
			if(LastDatumList[v]<DatumList[v])
				var/OT="";if(DatumList[v]>=100)	OT="<font color=red>"
				UpOutput+="<tr><td>[v]<td><b>[OT][DatumList[v]] (Up From) [LastDatumList[v]]"
			else
				if(LastDatumList[v]>DatumList[v])
					var/OT="";if(DatumList[v]>=100)	OT="<font color=red>"
					DownOutput+="<tr><td>[v]<td><i>[OT][DatumList[v]] (Down From) [LastDatumList[v]]"
				else
					var/OT="";if(DatumList[v]>=100)	OT="<font color=red>"
					HtmlOutput+="<tr><td>[v]<td>[OT][DatumList[v]]"
		else
			var/OT="";if(DatumList[v]>=100)	OT="<font color=red>"
			NewOutput+="<tr><td>[v]<td>[OT][DatumList[v]] (New)"
	LastDatumList=list();LastDatumList+=DatumList
	UpOutput+="</table>";DownOutput+="</table>";NewOutput+="</table>";HtmlOutput+="</table>"
	usr<<browse(UpOutput+DownOutput+NewOutput+HtmlOutput,"window=Profile Datums")
	usr<<"Datum Profiler Complete!"

mob/Test/verb/CheckLoggedIPs()
	set category="Test"
	if(usr.key!="Falacy")	return
	var/text="<center><table border=1><tr><td colspan=2>[LoggedIPCount] Logged IPs"
	text+="<center><tr><td><b>Key<td><b>IP"
	text+="[LoggedIPs]"
	usr<<browse(text,"window=LoggedIPs")

proc/ProfileAtoms()
	for(var/mob/A)
		if(!istype(A,/turf) && !istype(A,/area))
			var/FindLoc=LastAtomList.Find("[A.type]")
			if(!FindLoc)
				LastAtomList+="[A.type]";FindLoc=LastAtomList.len
			LastAtomList["[A.type]"]+=1

var/list/LastAtomList=list()
mob/Test/verb/Profile_Atoms()
	set category="Test"
	set background=1
	if(usr.key!="Falacy")	return
	usr<<"Starting Atom Profiler..."
	var/list/AtomList=list()
	var/TotalCount=0
	for(var/atom/A)
		if(!istype(A,/turf) && !istype(A,/area))
			var/FindLoc=AtomList.Find("[A.type]")
			if(!FindLoc)
				AtomList+="[A.type]";FindLoc=AtomList.len
			AtomList["[A.type]"]+=1;TotalCount+=1
	var/UpOutput="<center><table border=1><tr><td><b>Atom Type<td><b>UP Type Count"
	UpOutput+="<tr><td><b>Total Atom Count<td><b>[TotalCount]"
	var/DownOutput="<table border=1><tr><td><b>Atom Type<td><b>DOWN Type Count"
	var/NewOutput="<table border=1><tr><td><b>Atom Type<td><b>NEW Type Count"
	var/HtmlOutput="<table border=1><tr><td><b>Atom Type<td><b>Type Count"
	for(var/v in AtomList)
		if(v in LastAtomList)
			if(LastAtomList[v]<AtomList[v])
				var/OT="";if(AtomList[v]>=100)	OT="<font color=red>"
				UpOutput+="<tr><td>[v]<td><b>[OT][AtomList[v]] (Up From) [LastAtomList[v]]"
			else
				if(LastAtomList[v]>AtomList[v])
					var/OT="";if(AtomList[v]>=100)	OT="<font color=red>"
					DownOutput+="<tr><td>[v]<td><i>[OT][AtomList[v]] (Down From) [LastAtomList[v]]"
				else
					var/OT="";if(AtomList[v]>=100)	OT="<font color=red>"
					HtmlOutput+="<tr><td>[v]<td>[OT][AtomList[v]]"
		else
			var/OT="";if(AtomList[v]>=100)	OT="<font color=red>"
			NewOutput+="<tr><td>[v]<td>[OT][AtomList[v]] (New)"
	LastAtomList=list();LastAtomList+=AtomList
	UpOutput+="</table>";DownOutput+="</table>";NewOutput+="</table>";HtmlOutput+="</table>"
	usr<<browse(UpOutput+DownOutput+NewOutput+HtmlOutput,"window=Profile Atoms")
	usr<<"Atom Profiler Complete!"

mob/Test/verb/CheckOverlays()
	set category="Test"
	if(usr.key!="Falacy")	return
	var/counter=0
	var/real=0
	var/totals=0
	for(var/atom/A in world)
		totals+=A.overlays.len
		for(var/O in A.overlays)
			if(O)	real+=1
			else	counter+=1
	usr<<"Null Overlay Count: [counter]"
	usr<<"Real Overlay Count: [real]"
	usr<<"Total Overlay Count: [totals]"

mob/Test/verb/CheckShadows()
	set category="Test"
	if(usr.key!="Falacy")	return
	var/counter=0
	for(var/obj/Decoration/Shadow/S in world)	counter+=1
	for(var/obj/Decoration/Shadow_Edges/S in world)	counter+=1
	usr<<"Shadow Tally: [counter]"

mob/Test/verb/GetBankai()
	set category="Test"
	if(usr.key!="Falacy")	return
	for(var/obj/Skills/SoulReaper/Shikai/S in usr.Skills)	{usr.Skills-=S;del S}
	for(var/obj/Skills/SoulReaper/Bankai/S in usr.Skills)	{usr.Skills-=S;del S}
	for(var/obj/Skills/Quincy/Final_Form/S in usr.Skills)	{usr.Skills-=S;del S}
	usr.Skills+=new/obj/Skills/SoulReaper/Shikai
	usr.Skills+=new/obj/Skills/SoulReaper/Bankai
	usr.Skills+=new/obj/Skills/Quincy/Final_Form
	usr.SkillPoints+=99
	usr.ZanCreation()

mob/Test/verb/CheckEnemies()
	set category="Test"
	if(usr.key!="Falacy")	return
	var/counter=0
	for(var/mob/Enemy/M in world)
		if(M.StartedBy)	counter+=1
	usr<<"[counter] Active Enemies"

mob/Test/verb/OldCheckCPU()
	set category="Test"
	usr<<"Average Players:	[round(AvgPlayers/TimesRan)]"
	usr<<"Average CPU:	[round(AvgCPU/TimesRan)]%"

mob/Test/verb/DisplayExpFormula()
	set category="Test"
	if(usr.key!="Falacy")	return
	var/Nexp=100
	var/Level=0
	var/ExpBoost=input("Input Exp Increase per Level","Exp Boost",25)as num
	while(Level<150)
		Nexp+=Level*ExpBoost
		Level+=1
		usr<<"[Level]: [Nexp] EXP TNL ([round(Nexp/(Level*13))] Kills) at [Level*13] Exp Each"
		sleep(1)
	usr<<"<b>Exp Information displayed at [ExpBoost] point increments"

mob/Test/verb/Test_Location()
	set category="Test"
	if(usr.key=="Falacy")
		var/newx=input("Input X Coordinate","X",usr.x)as num
		var/newy=input("Input Y Coordinate","Y",usr.y)as num
		var/newz=input("Input Z Coordinate","Z",usr.z)as num
		usr.loc=locate(newx,newy,newz)
	else	usr<<"Only useable by Falacy."

mob/Test/verb
	CheckIP(var/mob/M in world)
		set category="Test"
		if(M.client)	usr<<"[M.client.address]	<b>[M.key]	</b>[M.client.computer_id]"
		else	usr<<"[M] has no client!"
	Download_File()
		set category="Test"
		usr<<ftp(file(input("Input the File to Download","Download File","LogFile.txt") as text))
	Refresh_Offensive_Words()
		set category="Test"
		LoadOffensiveWords(0)
	Refresh_Global_Mutes()
		set category="Test"
		LoadGlobalMutes(0)
	Refresh_Subs()
		set category="Test"
		LoadSubs(0)
	Refresh_Bans()
		set category="Test"
		LoadGlobalBans(0)
	Change_World_Status()
		set category = "Test"
		StatusNote=input("Input Message to Appear on Hub","Status Note",StatusNote)as message
		WorldStatusUpdate()
		SaveConfig()
	Reset_Enemy()
		set category = "Test"
		var/list/listy=list()
		for(var/mob/Enemy/M in world)	listy+=M
		var/mob/M=input("Select an Enemy NPC to Reset their Position to","Reset Enemy") as null|anything in listy
		if(M)	M.loc=locate(M.RespawnX,M.RespawnY,M.RespawnZ)