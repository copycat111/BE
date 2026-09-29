var/list/TrackList=list('Asterisk.mid','IchirinNoHana.mid','LifeisLikeaBoat.mid','NeverMeanttoBelong.mid','SiamShadeDreams.mid','Tecnolife.mid','WilloftheHeart.mid','WingStockPiano.mid','WingStockViolin.mid')

//Used for Global Save
/*world/Topic(T,Addr,Master,Key)
	if(T=="Test-Load")	return 1
	var/savefile/F = new(world.Import())
	for(var/mob/Player/M in world)
		if(ckey(M.key)==copytext(T,1,length(T)))
			M.Load(F);return*/

mob/Topic(href,href_list[])
	src=usr
	if(href_list["CheckPlayer"])
		var/mob/M=locate(href_list["CheckPlayer"])
		if(M)	usr.CheckPlayer(M)
	if(href_list["action"] == "Help")
		var/HF=href_list["Help"];call(src,"[HF]Help")()
	if(href_list["action"] == "PlayTrack")
		var/TrackNum=href_list["TrackNum"]
		PlayMusic(usr,TrackList[text2num(TrackNum)])
	if(href_list["action"] == "ViewQuest")
		var/TQ=href_list["Quest"]
		usr.ViewQuestDetails(TQ)
	if(href_list["action"] == "SortWho")
		var/HF=href_list["SortBy"]
		var/list/FullList=list();var/list/SortedList=list()
		for(var/mob/Player/M in world)	if(M.client)	FullList+=M
		var/Highest=0;var/mob/ThisMob
		while(FullList.len>0)
			for(var/mob/M in FullList)
				if(M.vars["[HF]"]>=Highest)	{ThisMob=M;Highest=M.vars["[HF]"]}
			Highest=0
			SortedList+=ThisMob;FullList-=ThisMob
		src.WhoProc(SortedList)
	if(href_list["action"] == "CloseMOTD")
		src<<browse(null,"window=MOTD")
	if(href_list["action"] == "PrivateMessage")
		var/keyo=href_list["KeyName"]
		//open window
		if(!ListCheck("[keyo]",usr.Messages))
			for(var/datum/PlayerInfo/P in MuteList)
				if(P.IP==src.client.address || P.Key==src.key)
					if(!src.MuteExpire(P))	return
			winclone(usr,"MessengerWindow","[keyo]")
			usr.Messages+="[keyo]"
		if(!winget(usr,"[keyo].label3","text"))
			world.log<<"Window Fix: [usr] - [keyo]"
			winclone(usr,"MessengerWindow","[keyo]")
		winset(usr,"[keyo]","title=[keyo];is-visible=true")
		winset(usr,"[keyo].MessageInput","focus=true")
		usr.NewMessages-=keyo;usr.MailUpdate()
		//send mesages
		if(href_list["SendMes"] == "Yes")
			if(!usr.AllowPMs)
				usr<<output("<b>You are Currently Ignoring All PMs","[keyo].MessageOutput");return
			if(usr.IsMuted())
				usr<<output("<b>You Cannot Send PMs when Muted","[keyo].MessageOutput");return
			if(keyo in usr.IgnoreList)	usr<<"This Player is on your Ignore List!"
			else
				for(var/mob/Player/M in world)
					if(M.MyKey==keyo)
						if(M.IsMuted())
							usr<<output("<b>[keyo] is Muted!","[keyo].MessageOutput");return
						if(usr.key in M.IgnoreList)
							usr<<output("<b>[keyo] is Ignoring You!","[keyo].MessageOutput");return
						if(!M.AllowPMs)
							usr<<output("<b>This Player is Currently Ignoring All PMs","[keyo].MessageOutput");return
						var/t=href_list["Message"]
						//open window for other person
						if(!t)	return
						usr<<output("<b><font color=yellow>[usr.name]:</font color></B> [t]","[keyo].MessageOutput")
						if(M.AFK)	usr<<output("<B>[M.name] is Currently AFK</B>","[keyo].MessageOutput")
						if(M.client)
							var/ResetW=0
							if(winget(M,"MainWindow.MapMain","focus")=="true")	ResetW=1
							if(!M)	return
							if(!ListCheck("[usr.MyKey]",M.Messages))
								winclone(M,"MessengerWindow","[usr.MyKey]")
								M.Messages+="[usr.MyKey]"
							if(!winget(M,"[usr.MyKey].label3","text"))
								world.log<<"Window Fix: [M] - [usr.MyKey]"
								winclone(M,"MessengerWindow","[usr.MyKey]")
							//winset(M,"[usr.MyKey]","title=[usr.MyKey];is-visible=true")
							if(ResetW)	winset(M,"MainWindow.MapMain","focus=true")
							M<<sound('Ring.wav',volume=M.PMVol)
							if(winget(M,"[usr.MyKey]","is-visible")!="true")
								if(!(usr.MyKey in M.NewMessages))	M.NewMessages+=usr.MyKey
								M.MailUpdate();
							M<<output("<b><font color=red>[usr.name]:</font color></B> [t]","[usr.MyKey].MessageOutput")
							if(M.AFK)	M<<output("<B>[M.name] is Currently AFK</B>","[usr.MyKey].MessageOutput")
						return
				usr<<output("<b>[keyo] is no longer online.","[keyo].MessageOutput")
	if(href_list["action"]=="PreviewVoice")
		var/PreVoice=src.VoiceSet
		src.VoiceSet=href_list["Voice"]
		src.LoadVoiceSet()
		PlayVoice(src,pick(src.AttVoices))
		src.VoiceSet=PreVoice
	if(href_list["action"]=="SelectVoice")
		src.VoiceSet=href_list["Voice"]
		winset(src,"VoiceWindow","is-visible=false")

	if(href_list["action"]=="HairStyle")
		src.HairStyle=href_list["HairStyle"]
		if(src.HairStyle!="Bald")
			for(var/obj/HUD/HairPreview/O in src.client.screen)
				O.HairConfigure(src.HairStyle)
				O.icon=MyRGB(O.icon,rgb(src.HairR,src.HairG,src.HairB))
		else
			for(var/obj/HUD/HairPreview/O in src.client.screen)	O.icon=null
		src.HairColor()
	if(href_list["HR"])
		src.HairR=min(255,max(0,text2num(href_list["HR"])))
		src.HairG=min(255,max(0,text2num(href_list["HG"])))
		src.HairB=min(255,max(0,text2num(href_list["HB"])))
		if(src.HairStyle!="Bald")
			for(var/obj/HUD/HairPreview/O in src.client.screen)
				O.HairConfigure(src.HairStyle)
				O.icon=MyRGB(O.icon,rgb(src.HairR,src.HairG,src.HairB))
		src.HairColor()
		if(src.z!=2)	src.AddHair(src.HairStyle)

	if(href_list["action"]=="RemoveZan")
		if(src.CurZanOver)
			for(var/obj/HUD/ZanDisp/Z in src.client.screen)	if(Z.name==src.CurZanOver.name)	del Z
			for(var/datum/ZanOvers/D in src.ZanpakutoOverlays)
				if(D.name==src.CurZanOver.name)	{src.ZanpakutoOverlays-=D;del D;return}
	if(href_list["action"]=="ClearZan")
		for(var/datum/D in src.ZanpakutoOverlays)	del D
		src.ZanpakutoOverlays=list()
		for(var/obj/HUD/ZanDisp/Z in src.client.screen)	del Z
	if(href_list["action"]=="ZanOver")
		var/hrefy=href_list["ZanObj"]
		for(var/datum/ZanOvers/D in src.ZanpakutoOverlays)
			if(D.name==hrefy)
				src.CurZanOver=D
				goto AlreadyThere

		var/Pathy=text2path("/datum/ZanOvers/[hrefy]")
		src.CurZanOver=new Pathy
		src.ZanpakutoOverlays+=src.CurZanOver
		src.client.screen+=new/obj/HUD/ZanDisp(hrefy)
		AlreadyThere
		for(var/obj/HUD/ZanDisp/Z in src.client.screen)
			if(Z.name==hrefy)
				Z.ZanConfigure(src.CurZanOver)
				Z.icon=MyRGB(Z.icon,rgb(src.CurZanOver.R,src.CurZanOver.G,src.CurZanOver.B))
		src.ZanOvers()
	if(href_list["ZR"])
		if(src.CurZanOver)
			src.CurZanOver.R=min(255,max(0,text2num(href_list["ZR"])))
			src.CurZanOver.G=min(255,max(0,text2num(href_list["ZG"])))
			src.CurZanOver.B=min(255,max(0,text2num(href_list["ZB"])))
			for(var/obj/HUD/ZanDisp/O in src.client.screen)
				if(O.name==src.CurZanOver.name)
					O.ZanConfigure(src.CurZanOver)
					O.icon=MyRGB(O.icon,rgb(src.CurZanOver.R,src.CurZanOver.G,src.CurZanOver.B))
		src.ZanOvers()

mob/proc/VoiceSelect()
	var/F="<font color=white>"
	var/messagewindow= {"
	<html>
	<head><title>Voice Select</title></head>
	<body bgcolor="black" scroll=no>
	<center><table bgcolor="black" border=1 bordercolor=white width=100%>
	<tr><td colspan=3><center>[F]Select Voice Set
	<tr><td>[F]Ichigo<td><a href='?src=\ref[src];action=PreviewVoice;Voice=Ichigo'>Preview</a>
	<td><a href='?src=\ref[src];action=SelectVoice;Voice=Ichigo'>Select</a>

	<tr><td>[F]Toshiro<td><a href='?src=\ref[src];action=PreviewVoice;Voice=Toshiro'>Preview</a>
	<td><a href='?src=\ref[src];action=SelectVoice;Voice=Toshiro'>Select</a>

	<tr><td>[F]Sora<td><a href='?src=\ref[src];action=PreviewVoice;Voice=Sora'>Preview</a>
	<td><a href='?src=\ref[src];action=SelectVoice;Voice=Sora'>Select</a>

	<tr><td>[F]Young Link<td><a href='?src=\ref[src];action=PreviewVoice;Voice=Young Link'>Preview</a>
	<td><a href='?src=\ref[src];action=SelectVoice;Voice=Young Link'>Select</a>

	<tr><td>[F]Link<td><a href='?src=\ref[src];action=PreviewVoice;Voice=Link'>Preview</a>
	<td><a href='?src=\ref[src];action=SelectVoice;Voice=Link'>Select</a>

	<tr><td>[F]Rukia<td><a href='?src=\ref[src];action=PreviewVoice;Voice=Rukia'>Preview</a>
	<td><a href='?src=\ref[src];action=SelectVoice;Voice=Rukia'>Select</a>
	</table>
	</body>
	</html>"}
	src<<browse(messagewindow,"window=VoiceBrowser")
	winset(src,"VoiceWindow","is-visible=true")
	src<<browse(messagewindow,"window=VoiceBrowser")

mob/proc/HairColor(/**/)
	if(src.HairStyle!="Bald")
		var/obj/I=new();I.HairConfigure(src.HairStyle)
		I.icon=MyRGB(I.icon,rgb(src.HairR,src.HairG,src.HairB))
		src<<browse_rsc(I.icon,"HairIMG")
	else
		src<<browse_rsc('CharCreation.dmi',"HairIMG")
	var/C="<center>";var/F="<font color=white>";var/S="width=68"
	var/messagewindow= {"
	<html>
	<head><title>Hair Style</title></head>
	<body bgcolor="black" scroll=no>
	<center><table bgcolor="black" border=1 bordercolor=white width=100% height=100%>
	<tr><td [S]><a href='?src=\ref[src];action=HairStyle;HairStyle=Bald'>[C]Bald</a></td>
		<td [S]><a href='?src=\ref[src];action=HairStyle;HairStyle=Ichigo'>[C]Ichigo</a></td>
		<td [S]><a href='?src=\ref[src];action=HairStyle;HairStyle=Toshiro'>[C]Toshiro</a></td></tr>
	<tr><td [S]><a href='?src=\ref[src];action=HairStyle;HairStyle=Uryu'>[C]Uryu</a></td>
		<td [S]><a href='?src=\ref[src];action=HairStyle;HairStyle=Renji'>[C]Renji</a></td>
		<td [S]><a href='?src=\ref[src];action=HairStyle;HairStyle=Urahara'>[C]Urahara</a></td></tr>
	<tr><td [S]><a href='?src=\ref[src];action=HairStyle;HairStyle=Byakuya'>[C]Byakuya</a></td>
		<td [S]><a href='?src=\ref[src];action=HairStyle;HairStyle=Kenpachi'>[C]Kenpachi</a></td>
		<td [S]><a href='?src=\ref[src];action=HairStyle;HairStyle=Izuru'>[C]Izuru</a></td></tr>
	<tr><td [S]><a href='?src=\ref[src];action=HairStyle;HairStyle=Maki'>[C]Maki</a></td>
		<td [S]><a href='?src=\ref[src];action=HairStyle;HairStyle=Yoruichi'>[C]Yoruichi</a></td>
		<td [S]><a href='?src=\ref[src];action=HairStyle;HairStyle=Bald'>[C]     </a></td></tr>
	<tr><td colspan=3 bgcolor=gray><center><img src=HairIMG></td></tr>
	<form method=get action='' name=form>
		<input type=hidden name=src value=\ref[src]>
		<tr><td colspan=2>[F]Red Dye</td><td>
			<input name=HR type=text value='[src.HairR]' size='9'>
		<tr><td colspan=2>[F]Green Dye</td><td>
			<input name=HG type=text value='[src.HairG]' size='9'>
		<tr><td colspan=2>[F]Blue Dye</td><td>
			<input name=HB type=text value='[src.HairB]' size='9'>
		<tr><td colspan=3><center><input type=submit value='Apply Dye'>
	</form>
	</table>
	</body>
	</html>"}
	src<<browse(messagewindow,"window=HairBrowser")
	winset(src,"HairWindow","is-visible=true")
	src<<browse(messagewindow,"window=HairBrowser")

mob/proc/ZanOvers()
	var/R2Show=0;var/G2Show=0;var/B2Show=0
	if(src.CurZanOver)
		R2Show=src.CurZanOver.R;G2Show=src.CurZanOver.G;B2Show=src.CurZanOver.B
		var/obj/I=new()
		I.ZanConfigure(src.CurZanOver)
		I.icon=MyRGB(I.icon,rgb(src.CurZanOver.R,src.CurZanOver.G,src.CurZanOver.B))
		src<<browse_rsc(I.icon,"ZanIMG")
	else	src<<browse_rsc('CharCreation.dmi',"ZanIMG")
	var/C="<center>";var/F="<font color=white>";var/S="width=93"
	var/messagewindow= {"
	<html>
	<head><title>Zanpakuto Customization</title></head>
	<body bgcolor="black" scroll=no>
	<center><table bgcolor="black" border=1 bordercolor=white width=100% height=100%>
	<tr><td><b>[F]Blades
		<td [S]><a href='?src=\ref[src];action=ZanOver;ZanObj=Overall'>[C]Slim</a></td>
		<td [S]><a href='?src=\ref[src];action=ZanOver;ZanObj=Enlarge'>[C]Large</a></td>
	<tr><td><b>[F]Spikes
		<td [S]><a href='?src=\ref[src];action=ZanOver;ZanObj=FrontSpikes'>[C]Front</a></td>
		<td [S]><a href='?src=\ref[src];action=ZanOver;ZanObj=BackSpikes'>[C]Back</a></td>

	<form method=get action='' name=form>
		<input type=hidden name=src value=\ref[src]>
		<tr><td colspan=2>[F]Red Paint</td><td>
			<input name=ZR type=text value='[R2Show]' size='9'>
		<tr><td colspan=2>[F]Green Paint</td><td>
			<input name=ZG type=text value='[G2Show]' size='9'>
		<tr><td colspan=2>[F]Blue Paint</td><td>
			<input name=ZB type=text value='[B2Show]' size='9'>
		<tr><td colspan=3><center><input type=submit value='Apply Paint'><br>
		<a href='?src=\ref[src];action=RemoveZan'>[C]Remove</a>
		<a href='?src=\ref[src];action=ClearZan'>[C]Remove All</a></tr>
	</form>
	</table>
	</body>
	</html>"}
	src<<browse(messagewindow,"window=ZanBrowser")
	winset(src,"ZanWindow","is-visible=true")
	src<<browse(messagewindow,"window=ZanBrowser")
	//<tr><td colspan=3 bgcolor=gray><center><img src=ZanIMG></td></tr>