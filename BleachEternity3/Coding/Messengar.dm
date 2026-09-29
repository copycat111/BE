var/NewMessageTag=new/obj/Supplemental/NewMessageTag
obj/Supplemental
	NewMessageTag
		icon='Other.dmi'
		icon_state="NewMessage"

mob/proc/MailUpdate()
	if(!src.client)	return
	for(var/obj/HUD/Mail_System/MS in src.client.screen)
		if(src.NewMessages.len>=1)	MS.icon_state="MailFlash"
		else	MS.icon_state="MailSystem"
	src.UpdateBL()

var/list/BuddyList=list()
proc/SortBuddyList()
	BuddyList=AscSort(BuddyList)

mob/proc/UpdateBL(/**/)
	if(!src.client)	return
	winset(src,"PMWindow.Grid","cells=1x[BuddyList.len]")
	if(!src)	return
	var/Html="<body bgcolor=black link=yellow alink=yellow vlink=yellow>\
		<center><table border=1 width=100% frame=below rules=columns>"
	for(var/v in src.NewMessages)
		var/MesTag="<a href='?src=\ref[src];action=PrivateMessage;SendMes=Yes;KeyName=[v]'>"
		//var/x="[MesTag]\icon[NewMessageTag]   [v]</a>"
		var/x="[MesTag]* [v]</a>"
		Html+="<tr><td><font face='Arial Black' color=yellow>[x]</td></tr>"
	for(var/v in BuddyList-src.NewMessages)
		var/MesTag="<a href='?src=\ref[src];action=PrivateMessage;SendMes=Yes;KeyName=[v]'>"
		var/x="[MesTag][v]</a>"
		Html+="<tr><td><font face='Arial Black'>[x]</td></tr>"
	Html+="</table>"
	src<<browse(Html,"window=PMBrowser")

mob/proc/OldUpdateBL(var/mob/X)	//X is to be removed for use in Logout()
	if(!src.client)	return
	var/counter=0
	for(var/mob/Player/M in world)	if(M.client && M!=X)	counter+=1
	winset(src,"PMWindow.Grid","cells=1x[counter]");counter=0
	var/list/NewMsgList=list()
	var/list/NewMsgKeys=list()
	var/list/SortedList=list()
	for(var/mob/Player/M in world)
		if(!M.client || M==X || !src)	continue
		var/MesTag="<a href='?src=\ref[src];action=PrivateMessage;SendMes=Yes;KeyName=[M.MyKey]'>"
		if(M.MyKey in src.NewMessages)
			NewMsgList+="[MesTag]\icon[NewMessageTag]   [M.name]</a>"
			NewMsgKeys+=M.MyKey
		else	SortedList+="<a href=[M.name]></a>[MesTag][M.name]</a>"
	SortedList=AscSort(SortedList)
	for(var/x in src.NewMessages)
		if(!(x in NewMsgKeys))
			var/MesTag="<a href='?src=\ref[src];action=PrivateMessage;SendMes=Yes;KeyName=[x]'>"
			counter+=1;src<<output("[MesTag]\icon[NewMessageTag]   [x]</a>","PMWindow.Grid:1,[counter]")
	for(var/x in NewMsgList)
		counter+=1;src<<output("[x]","PMWindow.Grid:1,[counter]")
	for(var/x in SortedList)
		counter+=1;src<<output("[x]","PMWindow.Grid:1,[counter]")