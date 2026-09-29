obj/Supplemental
	PartyInviteNotice
		layer=21
		screen_loc="1,13"
		icon='Hud.dmi';icon_state="PartyInviteNotice"
		var/mob/InvitedBy
		New(var/mob/M,var/mob/L)
			src.loc=L.contents
			src.InvitedBy=M;return ..()
		Click()
			if(usr.Chatting)	return
			var/mob/M=usr;var/mob/S=src.InvitedBy
			PlayMenuSound(M,'OOT_MainMenu_Select.wav')
			M.WriteLine(1,1,1,1,"PartyInviteNotice","",1);M.client.screen-=src
			if(!S || !S.Party)	{QuestShow(M,"Party is no longer online");goto DelSrc}
			if(S.Party.Members[1]!=S)	{QuestShow(M,"[S] is no longer leading");goto DelSrc}
			if(CustAlert(M,"[S.name] has Invited you to Join their Party",list("Accept","Decline"),0,10,5,12)=="Accept")
				if(!S || !M)	goto DelSrc
				if(!S.Party || M.Party)	goto DelSrc
				if(S.Party.Members[1]!=S)	{QuestShow(M,"[S] is no longer leading");goto DelSrc}
				if(S.Party.Members.len>=5)	{QuestShow(M,"Party Full");goto DelSrc}
				S.Party.Members+=M;M.Party=S.Party;M.overlays+=M.Party.PartyIcon
				for(var/mob/P in S.Party.Members)
					QuestShow(P,"[M] has Joined the Party");P.UpdatePartyHUD()
			DelSrc;del src
	PartyIcon
		pixel_x=8;pixel_y=-19
	PartyObj
		icon='PartyOrb.dmi'
		var/IconR=0;var/IconG=0;var/IconB=0
		var/list/Members=list();var/obj/PartyIcon
		DblClick()
			var/Text="<html><title>Party Info</title><body bgcolor=gray><center>"
			Text+="<table border=1 bordercolor=black bgcolor=gray width=100%>"
			Text+="<tr><td colspan=4><center>[src.name]"
			Text+="<tr><td>Members<td><center>Level<td align=right>STM<td align=right>REI"
			for(var/mob/M in src.Members)
				Text+="<tr><td>[M.name]<td><center>[M.Level]<td align=right>[M.STM] / [M.MaxSTM]<td align=right>[M.REI] / [M.MaxREI]"
			usr<<browse(Text,"window=PartyWindow")
		New()
			src.IconR=rand(0,255);src.IconG=rand(0,255);src.IconB=rand(0,255)
			src.icon=MyRGB(src.icon,rgb(src.IconR,src.IconG,src.IconB))
			src.PartyIcon=new/obj/Supplemental/PartyIcon;src.PartyIcon.icon=src.icon
			Parties+=src
		Del()
			Parties-=src
			return ..()

var/list/Parties=list()
mob/var
	obj/Supplemental/PartyObj/Party
	mob/PendingRequest

mob/proc/UpdatePartyHUD()
	if(!src.client)	return
	for(var/datum/LowCpuHudDatum/D in src.LowCpuHuds)	if(D.name=="Party")	D.Delete()
	for(var/obj/HUD/Supplemental/S in src.client.screen)
		if(S.icon_state=="/" && copytext(S.screen_loc,1,5)=="3:18")	del S
	for(var/obj/HUD/PartyBG/BG in src.client.screen)	del BG
	for(var/obj/HUD/PartyClassOrb/C in src.client.screen)	del C
	if(!src.Party)	return
	var/counter=0
	for(var/mob/M in src.Party.Members)
		counter+=1
		var/obj/HUD/PartyClassOrb/C=new(1,13-counter,M)
		C.icon_state="[M.Class]";src.client.screen+=C
		src.client.screen+=new/obj/HUD/PartyBG(1,13-counter)
		src.client.screen+=new/obj/HUD/PartyBG(2,13-counter)
		src.client.screen+=new/obj/HUD/PartyBG(3,13-counter)
		src.client.screen+=new/obj/HUD/PartyBG(4,13-counter)
		src.CreateHUDText(2,2,13-counter,22,"name",M,"Party","[M.name]  Lv.[M.Level]")
		src.CreateHUDText(2,21,13-counter,12,"STM",M,"Party")
		src.client.screen+=new/obj/HUD/Supplemental(3,18,13-counter,11,"/")
		src.CreateHUDText(3,29,13-counter,12,"MaxSTM",M,"Party")
		src.CreateHUDText(2,21,13-counter,2,"REI",M,"Party")
		src.client.screen+=new/obj/HUD/Supplemental(3,18,13-counter,1,"/")
		src.CreateHUDText(3,29,13-counter,2,"MaxREI",M,"Party")

mob/proc/RefreshPartyHUD()
	for(var/datum/LowCpuHudDatum/D in src.LowCpuHuds)	if(D.name=="Party")	D.Refresh()

mob/proc
	LeaveParty()
		if(!src.Party)	return
		for(var/mob/M in src.Party.Members)
			QuestShow(M,"[src] has Left the Party")
		src.Party.Members-=src;src.overlays-=src.Party.PartyIcon
		for(var/mob/M in src.Party.Members)
			if(src.Party.Members.len<=1)
				QuestShow(M,"Party Disbanded")
				M.overlays-=M.Party.PartyIcon;del src.Party
			M.UpdatePartyHUD()
		if(src.Party && src.Party.Members.len<=1)	del src.Party
		src.Party=null;src.UpdatePartyHUD()

	PartyInvite(var/mob/M)
		spawn()
			if(!src || !M)	return
			if(M.PendingRequest)
				QuestShow(src,"[M] already Pending an Invite");return
			if(M.Party)
				QuestShow(src,"[M] is already in a Party");return
			if(M.Chatting)
				QuestShow(src,"[M] is not Currently Available");return
			if(!src.Party)
				src.Party=new/obj/Supplemental/PartyObj;src.Party.Members+=src
				src.overlays+=src.Party.PartyIcon;src.Party.name="[src]'s Party"
			if(src.Party.Members.len>=5)
				QuestShow(src,"Party Full");return
			QuestShow(src,"Party Invite Sent to [M]")
			M.PendingRequest=new/obj/Supplemental/PartyInviteNotice(src,M)
			M.client.screen+=M.PendingRequest;M.WriteLine(2,0,13,8,"PartyInviteNotice","Party Invite from [src.name]",1)
