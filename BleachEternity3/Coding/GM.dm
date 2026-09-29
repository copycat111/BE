var/list/GMs=list()
var/list/MuteList=list()
var/list/BanList=list()

datum/PlayerInfo
	var/name
	var/Key
	var/IP
	var/Reason
	var/Expires
	var/ExpireText

mob/proc/IsMuted()
	if("All" in MuteList)	{src<<"The World is Muted";return 1}
	if(src.CheckGlobalMute())	return 1
	for(var/datum/PlayerInfo/P in MuteList)
		if(P.IP==src.client.address || P.Key==src.key)	if(!src.MuteExpire(P))	return 1
	return 0

mob/proc/MuteExpire(var/datum/PlayerInfo/P)
	if(P.Expires)
		if(sorttext(time2text(world.realtime,"YYYYMMDDhhmm"),P.Expires)==-1)
			world<<"<font size=1>The Mute on [src] has Expired"
			MuteList-=P;del P
			return 1
	src<<"You are Currently Muted"
	src<<"Reason: [P.Reason]"
	if(P.ExpireText)	src<<"Effective Until: [P.ExpireText]"
	return 0

proc/ExecuteBan(var/NameN,var/KeyN,var/IPN,var/ReasonN,var/ExpiresN,var/ExpireT)
	var/datum/PlayerInfo/P=new
	P.name=NameN;P.Key=KeyN;P.IP=IPN
	P.Reason=ReasonN;P.Expires=ExpiresN
	P.ExpireText=ExpireT
	BanList+=P

proc/ExecuteMute(var/NameN,var/KeyN,var/IPN,var/ReasonN,var/ExpiresN,var/ExpireT)
	var/datum/PlayerInfo/P=new
	P.name=NameN;P.Key=KeyN;P.IP=IPN
	P.Reason=ReasonN;P.Expires=ExpiresN
	P.ExpireText=ExpireT
	MuteList+=P

mob/GM/verb
	Host()
		set category="GM"
		winset(usr,,"command=\".host\"")
	Delete(var/M in world)
		set category="GM"
		if(alert("Are you sure you want to delete [M]?","Delete [M]","Delete","Cancel")=="Delete")
			if(istype(M,/mob))
				usr<<"Cannot Delete Players";return
			del M
	Watch_Player()
		set category="GM"
		if(usr.client.eye!=usr)
			usr<<"You Stop Watching [usr.client.eye]..."
			usr.client.eye=usr
			return
		var/list/MobList=list()
		for(var/mob/M in world)	if(M.client)	MobList+=M
		var/mob/M=input("Select a Player to Watch","Watch Player") as null|mob in MobList
		if(M && M.client)
			usr.client.eye=M;usr<<"Watching [M]"
	Boot()
		set category="GM"
		var/list/MobList=list()
		for(var/mob/M in world)	if(M.client)	MobList+=M
		var/mob/M=input("Select a Player to Boot","Boot Player") as null|mob in MobList
		if(M && M.client)
			world<<"<b><font color=green>Host: </font>[usr] is Booting [M]"
			del M.client
	Shut_Down()
		set category="GM"
		world<<"<b><font color=green>Host: </font>[usr] is Shutting Down the Server"
		world.log<<"[usr] is Shutting Down the Server"
		//Used for Global Save
		/*for(var/mob/Player/M in world)
			if(M.key)	M.Save()*/
		del world
	Auto_Reboot()
		set category="GM"
		RebootTime=round(input("Set Auto Reboot Time (in Hours) \nSet to 0 to Disable","Auto Reboot",RebootTime)as num)
		if(RebootTime>99)	RebootTime=99
		if(RebootTime<0)	RebootTime=0
		world<<"<b><font color=green>Host: </font>[usr] set Auto Reboot to [RebootTime] Hours"
		SaveConfig()
	Reboot()
		set category="GM"
		world<<"<b><font color=green>Host: </font>[usr] is Rebooting the Server"
		//Used for Global Save
		/*for(var/mob/Player/M in world)
			if(M.key)	M.Save()*/
		world.Reboot()
	Change_MOTD()
		set category = "GM"
		MOTD=input("HTML may be used to Improve Appearance","MOTD Setting",MOTD) as message
		SaveConfig()
	Change_Player_Limit()
		set category = "GM"
		PlayerLimit=round(input("Set the Maximum Number of Players Allowed on One Time","Player Limit",PlayerLimit) as num)
		if(PlayerLimit<0)	PlayerLimit=0
		if(PlayerLimit>999)	PlayerLimit=999
		world<<"<b><font color=green>Host: </font>[usr] has Changed the Player Limit to [PlayerLimit]"
		WorldStatusUpdate()
		SaveConfig()
	Change_MultiKey()
		set category = "GM"
		CanMultiKey=alert("MultiKeying Allows Multiple Players to Login from the same IP Address \nCurrently set to: [CanMultiKey]","MultiKeying","Allow","Disable")
		world<<"<b><font color=green>Host: </font>[usr] has set the Sever to [CanMultiKey] Multikeying"
		SaveConfig()
	Ban()
		set category = "GM"
		var/list/listy=list()
		for(var/mob/Player/M in world)
			if(M.client)	listy+=M
		var/mob/M=input("Select a Player to Ban","Ban Player") as null|anything in listy
		if(!M)	return
		if(M.key==world.host || M.key=="Falacy")
			usr<<"Cannot be Banned!";return
		if(alert("Ban [M]?","Ban Player","Yes","Cancel")=="Yes")
			var/ReasonN=input("Input Reason for Ban","Reason")as text
			for(var/mob/X in world)
				if(X.client && M.client && M!=X && X.client.address==M.client.address)	del X.client
			world<<"<b><font color=green>GM: </font>[usr] has Banned [M]"
			world<<"<b>Reason:</b> [ReasonN]"
			ExecuteBan(M.name,M.key,M.client.address,ReasonN)
			del M.client
		SaveConfig()
	UnBan()
		set category = "GM"
		var/datum/PlayerInfo/M=input("Select Player to UnBan","UnBan") as null|anything in BanList
		if(!istype(M,/datum/PlayerInfo))
			BanList-=M;return
		if(alert("UnBan [M.Key]? \nIP: [M.IP] \nReason: [M.Reason]?","UnBan","Yes","No")=="Yes")
			BanList-=M
			world<<"<b><font color=green>GM: </font>[usr] has UnBanned [M]"
		SaveConfig()

	Mute()
		set category = "GM"
		var/list/listy=list()
		for(var/mob/Player/M in world)
			if(M.client)	listy+=M
		var/mob/M=input("Select a Player to Mute","Mute Player") as null|anything in listy
		if(!M)	return
		if(M.key==world.host || M.key=="Falacy")
			usr<<"Cannot be Muted!";return
		if(alert("Mute [M]?","Mute Player","Yes","Cancel")=="Yes")
			var/ReasonN=input("Input Reason for Mute","Reason")as text
			ExecuteMute(M.name,M.key,M.client.address,ReasonN)
			world<<"<b><font color=green>GM: </font>[usr] has Muted [M]"
			world<<"<b>Reason:</b> [ReasonN]"
		SaveConfig()
	UnMute()
		set category = "GM"
		var/datum/PlayerInfo/M=input("Select Player to UnMute","UnMute") as null|anything in MuteList
		if(!istype(M,/datum/PlayerInfo))
			MuteList-=M;return
		if(alert("UnMute [M.Key]? \nIP: [M.IP] \nReason: [M.Reason]? \nExpires: [M.ExpireText]","UnMute","Yes","No")=="Yes")
			MuteList-=M
			world<<"<b><font color=green>GM: </font>[usr] has UnMuted [M]"
		SaveConfig()

	Mute_World()
		set category = "GM"
		if("All" in MuteList)
			usr<<"The world is Already Muted"
		else
			MuteList+="All"
			world<<"<b><font color=green>GM: </font>[usr] has Muted the World"
		SaveConfig()
	UnMute_World()
		set category = "GM"
		if("All" in MuteList)
			MuteList-="All"
			world<<"<b><font color=green>GM: </font>[usr] has UnMuted the World"
		else
			usr<<"The world isn't Muted"
		SaveConfig()

	Summon_Player()
		set category = "GM"
		var/list/listy=list()
		for(var/mob/Player/M in world)
			if(M.client)	listy+=M
		var/mob/M=input("Select a Player to Summon","Summon") as null|anything in listy
		if(M)	M.loc=usr.loc

	Goto_Player()
		set category = "GM"
		var/list/listy=list()
		for(var/mob/Player/M in world)
			if(M.client)	listy+=M
		var/mob/M=input("Select a Player to Teleport to","Goto Player") as null|anything in listy
		if(M)	usr.loc=M.loc
	Goto_NPC()
		set category = "GM"
		var/list/listy=list()
		for(var/obj/NPC/M in world)	listy+=M
		var/mob/M=input("Select an NPC to Teleport to","Goto NPC") as null|anything in listy
		if(M)	usr.loc=M.loc

	Goto_Enemy()
		set category = "GM"
		var/list/listy=list()
		for(var/mob/Enemy/M in world)	listy+=M
		var/mob/M=input("Select an Enemy NPC to Teleport to","Goto Enemy") as null|anything in listy
		if(M)	usr.loc=M.loc

	Edit_Zanpakuto()
		set category = "GM"
		var/list/listo=list()
		for(var/mob/Player/M in world)
			if(M.client)	listo+=M
		var/mob/mob2edit=input("Who will Edit their Zanpakuto?","Select Player") as null|anything in listo
		if(mob2edit)	mob2edit.ZanCreation()
	Edit_Mode()
		set category = "GM"
		usr.client.show_popup_menus=!usr.client.show_popup_menus
		if(usr.client.show_popup_menus)	usr<<"Right Click to Edit"
		else	usr<<"Normal Game Mode"
	Edit(obj/O as obj|mob|turf|area in world)
		set category = "GM"
		var/Var2Edit=input("Select Variable to Edit","Edit") as null|anything in O.vars
		if(!Var2Edit)	return
		var/default
		var/VarValue = O.vars[Var2Edit]
		if(Var2Edit=="GM"||Var2Edit=="startx"||Var2Edit=="starty"||Var2Edit=="startz")
			usr<<"Contains: [VarValue]"
			usr<<"This cannot be edited!"
			return
		if(isnull(VarValue))
			usr << "Variable appears to be <b>NULL</b>."
		if(isnum(VarValue))
			usr << "Variable appears to be <b>NUM</b>."
			default = "num"
		if(istext(VarValue))
			usr << "Variable appears to be <b>TEXT</b>."
			default = "text"
		if(isloc(VarValue))
			usr << "Variable appears to be <b>REFERENCE</b>."
			default = "reference"
			if(alert("Switch to Editing this Object?","Edit New Reference","Yes","No")=="Yes")
				Edit(VarValue)
				return
		if(istype(VarValue,/atom) || istype(VarValue,/datum))
			usr << "Variable appears to be <b>PATH</b>."
			default = "type"
		if(istype(VarValue,/list))
			usr << "Variable appears to be <b>LIST</b>."
			for(var/L in VarValue)
				usr<<L
			usr << "*** Warning!  Lists are uneditable in s_admin! ***"
			default = "cancel"
		if(istype(VarValue,/client))
			usr << "Variable appears to be <b>CLIENT</b>."
			usr << "*** Warning!  Clients are uneditable in s_admin! ***"
			default = "cancel"
		if(isicon(VarValue))
			usr << "Variable appears to be <b>ICON</b>."
			VarValue = "\icon[VarValue]"
			default = "icon"
		else
			if(isfile(VarValue))
				usr << "Variable appears to be <b>FILE</b>."
				default = "file"
		usr << "Variable contains: [VarValue]"

		var/class = input("What kind of variable?","Variable Type",default) in list("text",
			"num","type","reference","icon","file","restore to default","nullify","cancel")

		switch(class)
			if("cancel")	return
			if("nullify")	O.vars[Var2Edit] = null
			if("restore to default")	O.vars[Var2Edit] = initial(O.vars[Var2Edit])
			if("text")
				O.vars[Var2Edit] = input("Enter new text:","Text",O.vars[Var2Edit]) as text
			if("num")
				O.vars[Var2Edit] = input("Enter new number:","Num",O.vars[Var2Edit]) as num
			if("type")
				O.vars[Var2Edit] = input("Enter type:","Type",O.vars[Var2Edit]) in typesof(/obj,/mob,/area,/turf)
			if("reference")
				O.vars[Var2Edit] = input("Select reference:","Reference",O.vars[Var2Edit]) as mob|obj|turf|area in world
			if("file")
				O.vars[Var2Edit] = input("Pick file:","File",O.vars[Var2Edit]) as file
			if("icon")
				O.vars[Var2Edit] = input("Pick icon:","Icon",O.vars[Var2Edit]) as icon