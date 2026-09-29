obj/Supplemental
	PVPFlag
		mouse_opacity=0
		density=0;layer=TURF_LAYER
		icon='Other.dmi';icon_state="PVPFlag"
	DuelNotice
		layer=21
		screen_loc="1,13"
		icon='Hud.dmi';icon_state="DuelNotice"
		var/mob/InvitedBy
		New(var/mob/M,var/mob/L)
			src.loc=L.contents
			src.InvitedBy=M;return ..()
		Click()
			if(usr.Chatting)	return
			var/mob/M=usr;var/mob/S=src.InvitedBy
			PlayMenuSound(M,'OOT_MainMenu_Select.wav')
			M.WriteLine(1,1,1,1,"DuelNotice","",1);M.client.screen-=src
			if(!S)	{QuestShow(M,"Challenger is no longer online");goto DelSrc}
			if(CustAlert(M,"[S.name] has challenged you to a PVP Duel",list("Accept","Decline"),0,10,5,12)=="Accept")
				if(!S || !M)	goto DelSrc
				if(S.PVPingAgainst)	{QuestShow(M,"[S] is Dueling [S.PVPingAgainst]");goto DelSrc}
				if(M.PVPingAgainst)	{QuestShow(M,"You are Dueling [M.PVPingAgainst]");goto DelSrc}
				if(MyGetDist(M,S)>9)	{QuestShow(M,"[S] has left the area");goto DelSrc}
				var/obj/Supplemental/PVPFlag/F=new(S.loc)
				F.name="[S] vs [M]";F.AddName()
				S.PVPFlag=F;M.PVPFlag=F
				S.PVPingAgainst=M
				M.PVPingAgainst=S
			DelSrc;del src