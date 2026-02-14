turf/Supplemental/Map
	icon='Map.png'
obj/Supplemental/BeastIntel
	Click()
		for(var/mob/Enemy/M in world)	if(M.name==src.name)
			//if(M.MultiCore)	M=M.MultiCore
			var/Multiplyer=1;var/InitialLevel=initial(M.Level)-1
			if(istype(M,/mob/Enemy/Bosses))	Multiplyer=3
			winset(usr,"BeastiaryWindow.NAME","text='[initial(M.name)]'")
			winset(usr,"BeastiaryWindow.ELEMENT","text='[initial(M.Element)]'")
			winset(usr,"BeastiaryWindow.LEVEL","text='[InitialLevel+1]'")
			winset(usr,"BeastiaryWindow.STM","text='[(initial(M.MaxSTM)+((InitialLevel-1)*40))*Multiplyer]'")
			winset(usr,"BeastiaryWindow.REI","text='[(initial(M.MaxREI)+((InitialLevel-1)*20))*Multiplyer]'")
			winset(usr,"BeastiaryWindow.STR","text='[(initial(M.STR)+((InitialLevel-1)*MobStats))*Multiplyer]'")
			winset(usr,"BeastiaryWindow.VIT","text='[(initial(M.VIT)+((InitialLevel-1)*MobStats))*1]'")
			winset(usr,"BeastiaryWindow.MGC","text='[(initial(M.MGC)+((InitialLevel-1)*MobStats))*Multiplyer]'")
			winset(usr,"BeastiaryWindow.MGCDEF","text='[(initial(M.MGCDEF)+((InitialLevel-1)*MobStats))*1]'")
			winset(usr,"BeastiaryWindow.AGI","text='[(initial(M.AGI)+((InitialLevel-1)*MobStats))*1]'")
			winset(usr,"BeastiaryWindow.LCK","text='[(initial(M.LCK)+((InitialLevel-1)*MobStats))*Multiplyer]'")
			winset(usr,"BeastiaryWindow.ICON","image='[M.icon]'")
			winset(usr,"BeastiaryWindow.DROPS","cells=0x0")
			for(var/datum/EnemySpoils/D in M.Spoils)
				var/list/SplitPath=Split(D.ItemPath,"/");var/ItemName=SplitPath[SplitPath.len]
				winset(usr,"BeastiaryWindow.DROPS","cells=1x[M.Spoils.len]")
				usr<<output("[ItemName]","BeastiaryWindow.DROPS:1,[M.Spoils.Find(D)]")
			return
mob/var/list/TempBeastList=list()
mob/proc
	SearchBeastProc(t)
		winset(src,"BeastiaryWindow.SearchBeastiary","text='[t]'")
		var/list/SearchedList=Split(src.Beastiary,",")
		if(t)	for(var/x in SearchedList)
			if(!findtext(x,t,1,0))	SearchedList-=x
		winset(src,"BeastiaryWindow.BeastGrid","cells=1x[SearchedList.len]")
		src.TempBeastList=list()
		for(var/x in SearchedList)
			var/obj/Supplemental/BeastIntel/O=new();O.name=x
			src.TempBeastList+=O
			src<<output(O,"BeastiaryWindow.BeastGrid:1,[SearchedList.Find(x)]")
	SubmitTextProc(t)
		usr.TextCapture=t
		winset(usr,"TextInput","is-visible=false")

mob/verb
	ScreenShot()
		set hidden=1
		winset(usr,,"command=\".screenshot\"")
	SetFocus(var/WindowID as null|text)
		set hidden=1
		winset(usr,"[WindowID]","focus=true")
	NoCommand(var/t as null|text)
		set hidden=1
		return
	InventoryToggle()
		set hidden=1
		for(var/obj/HUD/InventoryToggle/I in usr.client.screen)	I.Click()
	Options()
		set hidden=1
		winset(usr,"OptionsWindow","is-visible=true;pos=100,100")
		winset(usr,"OptionsWindow.Orb","background-color=#272b58")
		winset(usr,"OptionsWindow.Screen","background-color=#272b58")
		winset(usr,"OptionsWindow.Both","background-color=#272b58")
		winset(usr,"OptionsWindow.None","background-color=#272b58")
		winset(usr,"OptionsWindow.[usr.ExpDisplay]","background-color=#4e55b1")
		winset(usr,"OptionsWindow.MusicVolume","text='[usr.MusicVol]'")
		winset(usr,"OptionsWindow.EffectVolume","text='[usr.EffectVol]'")
		winset(usr,"OptionsWindow.VoiceVolume","text='[usr.VoiceVol]'")
		winset(usr,"OptionsWindow.MenuVolume","text='[usr.MenuVol]'")
		winset(usr,"OptionsWindow.PMVolume","text='[usr.PMVol]'")
		if(usr.LoopMusic)	winset(usr,"OptionsWindow.LoopButton","is-checked=true")
		else	winset(usr,"OptionsWindow.LoopButton","is-checked=false")
		if(usr.AllowPMs)	winset(usr,"OptionsWindow.AllowPMs","is-checked=true")
		else	winset(usr,"OptionsWindow.AllowPMs","is-checked=false")
		if(usr.AutoTargetFace)	winset(usr,"OptionsWindow.AutoTargetFace","is-checked=true")
		else	winset(usr,"OptionsWindow.AutoTargetFace","is-checked=false")
		if(usr.AutoAttackFace)	winset(usr,"OptionsWindow.AutoAttackFace","is-checked=true")
		else	winset(usr,"OptionsWindow.AutoAttackFace","is-checked=false")
		if(usr.AutoSkillFace)	winset(usr,"OptionsWindow.AutoSkillFace","is-checked=true")
		else	winset(usr,"OptionsWindow.AutoSkillFace","is-checked=false")
	ExpDisplay(var/T as text)
		set hidden=1
		usr.ExpDisplay=T
		winset(usr,"OptionsWindow","focus=true")
		usr.Options()
	SearchBeastiary()
		set hidden=1
		usr.SearchBeastProc(winget(usr,"BeastiaryWindow.SearchBeastiary","text"))
	SubmitOptions()
		set hidden=1
		QuestShow(usr,"Applying New Option Settings...")
		usr.MusicVol=max(0,min(100,round(text2num(winget(usr,"OptionsWindow.MusicVolume","text")))))
		usr.EffectVol=max(0,min(100,round(text2num(winget(usr,"OptionsWindow.EffectVolume","text")))))
		usr.VoiceVol=max(0,min(100,round(text2num(winget(usr,"OptionsWindow.VoiceVolume","text")))))
		usr.MenuVol=max(0,min(100,round(text2num(winget(usr,"OptionsWindow.MenuVolume","text")))))
		usr.PMVol=max(0,min(100,round(text2num(winget(usr,"OptionsWindow.PMVolume","text")))))
		if(winget(usr,"OptionsWindow.LoopButton","is-checked")=="true")	usr.LoopMusic=1
		else	usr.LoopMusic=0

		if(winget(usr,"OptionsWindow.AllowPMs","is-checked")=="true")	usr.AllowPMs=1
		else	usr.AllowPMs=0

		if(winget(usr,"OptionsWindow.AutoTargetFace","is-checked")=="true")	usr.AutoTargetFace=1
		else	usr.AutoTargetFace=0

		if(winget(usr,"OptionsWindow.AutoAttackFace","is-checked")=="true")	usr.AutoAttackFace=1
		else	usr.AutoAttackFace=0

		if(winget(usr,"OptionsWindow.AutoSkillFace","is-checked")=="true")	usr.AutoSkillFace=1
		else	usr.AutoSkillFace=0
		winset(usr,"OptionsWindow.MusicVolume","text='[usr.MusicVol]'")
		winset(usr,"OptionsWindow.EffectVolume","text='[usr.EffectVol]'")
		winset(usr,"OptionsWindow.VoiceVolume","text='[usr.VoiceVol]'")
		winset(usr,"OptionsWindow.MenuVolume","text='[usr.MenuVol]'")
		winset(usr,"OptionsWindow.PMVolume","text='[usr.PMVol]'")
		winset(usr,"OptionsWindow","focus=true")
		usr.SavePlayerConfig()
		if(!usr.MusicVol)	usr<<sound(null)
		QuestShow(usr,"Option Settings Saved")
	GlobalChat()
		set hidden=1
		usr.ChatMode="Global"
		winset(usr,"MainWindow.GlobalChat","background-color=#252525")
		winset(usr,"MainWindow.ZoneChat","background-color=#000000")
		winset(usr,"MainWindow.LocalChat","background-color=#000000")
		winset(usr,"MainWindow.PartyChat","background-color=#000000")
		winset(usr,"MainWindow.MapMain","focus=true")
	ZoneChat()
		set hidden=1
		usr.ChatMode="Zone"
		winset(usr,"MainWindow.GlobalChat","background-color=#000000")
		winset(usr,"MainWindow.ZoneChat","background-color=#252525")
		winset(usr,"MainWindow.LocalChat","background-color=#000000")
		winset(usr,"MainWindow.PartyChat","background-color=#000000")
		winset(usr,"MainWindow.MapMain","focus=true")
	LocalChat()
		set hidden=1
		usr.ChatMode="Local"
		winset(usr,"MainWindow.GlobalChat","background-color=#000000")
		winset(usr,"MainWindow.ZoneChat","background-color=#000000")
		winset(usr,"MainWindow.LocalChat","background-color=#252525")
		winset(usr,"MainWindow.PartyChat","background-color=#000000")
		winset(usr,"MainWindow.MapMain","focus=true")
	PartyChat()
		set hidden=1
		usr.ChatMode="Party"
		winset(usr,"MainWindow.GlobalChat","background-color=#000000")
		winset(usr,"MainWindow.ZoneChat","background-color=#000000")
		winset(usr,"MainWindow.LocalChat","background-color=#000000")
		winset(usr,"MainWindow.PartyChat","background-color=#252525")
		winset(usr,"MainWindow.MapMain","focus=true")
	SubmitText()
		set hidden=1
		SubmitTextProc(winget(usr,"TextInput.Text","text"))
	ShowBL()
		set hidden=1
		winset(usr,"PMWindow","is-visible=true;size=200x480;pos=100,100")
		usr.UpdateBL()
	ViewMap()
		set hidden=1
		if(usr.z==2 || usr.z==5 || usr.z==8)
			QuestShow(usr,"No Map Available for this Area");return
		if(usr.client.eye!=usr || !usr.icon)
			if(usr.client.eye==locate(10,67,2))
				usr.client.eye=usr;usr.HUD()
				PlayMenuSound(usr,'OOT_MainMenu_Cancel.wav')
				for(var/obj/HUD/UnLearned_Skill/O in usr.client.screen)	del O
			return
		PlayMenuSound(usr,'OOT_MainMenu_Select.wav')
		usr.client.eye=locate(10,67,2)
		for(var/O in usr.client.screen)
			if(!istype(O,/obj/Items)&&O!=src)	del O
			else	usr.client.screen-=src
		var/StartX;var/StartY
		if(usr.z==1)	{StartX=200;StartY=200}
		if(usr.z==3)	{StartX=200;StartY=0}
		if(usr.z==4)	{StartX=0;StartY=200}
		if(usr.z==6)	{StartX=0;StartY=0}
		if(usr.z==7)	{StartX=0;StartY=400}
		if(usr.z==9)	{StartX=400;StartY=200}
		if(usr.z==10)	{StartX=400;StartY=400}
		StartX+=4+usr.x;StartY+=usr.y
		var/Xpos=1;var/Ypos=1
		while(StartX-16>32)	{Xpos+=1;StartX-=32}
		while(StartY>32)	{Ypos+=1;StartY-=32}
		var/obj/NO=new/obj/HUD/UnLearned_Skill(1,1);NO.icon='Other.dmi';NO.icon_state="You Are Here"
		NO.screen_loc="[Xpos]:[StartX-16],[Ypos]:[StartY-1]";src.client.screen+=NO
	Diagnostic()
		set hidden=1
		if(!usr.icon)	return
		if(usr.client.eye==usr)
			PlayMenuSound(usr,'OOT_MainMenu_Select.wav')
			usr.client.eye=locate(86,48,2)
			var/obj/NO=new/obj/HUD/UnLearned_Skill(14,10);NO.icon_state="Learnable";src.client.screen+=NO
			usr.client.screen+=new/obj/HUD/UnLearned_Skill(16,10)
	MOTD()
		set hidden=1
		var/motdd={"<html><title>Message of the Day</title>
					[MOTD]
					<p><center>
					<a href='?src=\ref[src];action=CloseMOTD'>Close</a></html>"}
		usr<<browse(motdd,"window=MOTD;can_close=No;size=300x300")
	MenuAbout()
		set hidden=1
		winset(usr,"About","is-visible=true;pos=100,100;size=248x312")
	MenuBrowser()
		set hidden=1
		winset(usr,"MainWindow.MapMain","focus=true")
	SmallMode()
		set hidden=1
		winset(usr,"MainWindow.MapMain","icon-size=24;size=456x456")
		winset(usr,"MainWindow","Size=800x608;pos=0,0")
	Screen800()
		set hidden=1
		usr.WindowReset()
		winset(usr,"MainWindow","Size=800x608;is-maximized=false;pos=0,0")
	Screen1024()
		set hidden=1
		usr.WindowReset()
		winset(usr,"MainWindow","Size=1024x768;is-maximized=false;pos=0,0")
	WindowReset(/**/)
		set hidden=1
		var/list/Tracks=list("Asterisk","Ichirin No Hana","Life is Like a Boat","Never Meant to Belong","Siam Shade Dreams","Tecnolife","Will of the Heart","Wing Stock Piano","Wing Stock Violin")
		for(var/i=1;i<=9;i+=1)
			var/ThisTrack=Tracks[i];var/MesTag="<a href='?src=\ref[src];action=PlayTrack;TrackNum=[i]'>"
			usr<<output("[MesTag][ThisTrack]</a>","OptionsWindow.MusicSelect:1,[i]")
		winset(usr,"MainWindow.input1","text='Press Enter to Chat'")
		winset(usr,"MainWindow.MapMain","icon-size=32;size=608x608")
		winset(usr,"TextInput","pos=100,100")
		//screws up the anchors if you resize something!
		/*winset(usr,"MainWindow.button1","pos=608,0;size=192x80")
		winset(usr,"MainWindow.child1","pos=608,80;size=192x456")
		winset(usr,"MainWindow.ChatButton","pos=608,536;size=192x80")
		winset(usr,"MainWindow.label2","pos=608,616;size=48x24")
		winset(usr,"MainWindow.input1","pos=656,616;size=144x24")
		winset(usr,"MainWindow.button2","pos=0,608;size=608x32")*/
	ViewWho()
		set hidden=1
		src.WhoProc()
	Send(t as text)
		set hidden=1
		var/list/SplitList=Split(winget(usr,null,"focus"),".")
		if(!SplitList.len)	return
		var/keyo=SplitList[1]
		if(!keyo || !(keyo in usr.Messages))	return
		var/list/lst=list("action"="PrivateMessage","SendMes"="Yes","KeyName"="[keyo]","Message"="[t]")
		usr.Topic("PrivateMessage",lst)

mob/proc/WhoProc(var/list/SortedPlayers)
	if(!SortedPlayers)
		var/list/AllPlayers=list();SortedPlayers=list()
		for(var/mob/Player/M in world)
			if(M.client)	AllPlayers+=M
		while(AllPlayers.len>=1)
			var/HighestLevel=0;var/ThisMob
			for(var/mob/M in AllPlayers)
				if(M.Level>HighestLevel)	{HighestLevel=M.Level;ThisMob=M}
			AllPlayers-=ThisMob;SortedPlayers+=ThisMob
	var/LevelSort="<a href='?src=\ref[src];action=SortWho;SortBy=Level'>Level</a>"
	var/PlayTimeSort="<a href='?src=\ref[src];action=SortWho;SortBy=PlayTime'>Play Time</a>"
	var/TextList="<html><body bgcolor=black><b><font color=gray>"
	TextList+="<title>Who List</title>"
	TextList+="<center><table border=1 bgcolor=black bordercolor=gray>"
	TextList+="<tr><td colspan=6><center><b><font color=gray>[PlayerCount] Players Online"
	TextList+="<tr><td><b><font color=gray>Name<td><b><font color=gray>Key"
	TextList+="<td><b><font color=gray>[LevelSort]<td><b><font color=gray>Class"
	TextList+="<td colspan=2><b><font color=gray>[PlayTimeSort]"
	var/FM="<td align=right><b><font color=gray>"
	for(var/mob/M in SortedPlayers)
		var/Phours=round(M.PlayTime/60/60)
		var/Pminutes=round(M.PlayTime/60-(60*Phours))
		var/SubStar=""
		if(M.Subscriber)	SubStar="* "
		//var/Pseconds=round(M.PlayTime-(60*Pminutes)-(60*Phours*60))
		TextList+="<tr><td><b><font color=gray><a href='?src=\ref[src];CheckPlayer=\ref[M]'>[M.name]"
		TextList+="<td><b><font color=gray>[SubStar][M.key]"
		TextList+="<td><b><font color=gray><center>[M.Level]<td><b><font color=gray>[M.Class]"
		TextList+="[FM][Phours]h[FM][Pminutes]m"
	TextList+="<tr><td colspan=6><b><font color=gray><center>[SortedPlayers.len] Players Online"
	usr<<browse("[TextList]","window=WhoBrowser")
	winset(usr,"WhoWindow","is-visible=true")