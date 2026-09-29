var/obj/ZoneChatIcon=new/obj/Supplemental/ZoneChatIcon
var/obj/ChatIcon=new/obj/Supplemental/ChatIcon
var/obj/SubIcon=new/obj/Supplemental/SubIcon
var/obj/GMIcon=new/obj/Supplemental/GMIcon
var/CRGRTN={"
"}
obj/Supplemental
	ZoneChatIcon
		icon='Other.dmi';icon_state="ZoneChat"
	ChatIcon
		icon='Other.dmi';icon_state="PM"
	SubIcon
		icon='Other.dmi';icon_state="Sub"
	GMIcon
		icon='Other.dmi';icon_state="GM"
	ElemSpark
		icon='Effects.dmi'
		layer=8
		New(var/mob/M,var/Elem)
			src.pixel_x+=rand(-8,8)
			src.pixel_y+=rand(-8,8)
			src.loc=locate(M.x,M.y,M.z)
			MyFlick("[Elem]Spark",src)
			spawn(10)	del src
			return ..()
	Follower
		var/xoff=1
		var/yoff=1
mob/verb
	NullBeastSearch(var/t as null|text)
		set hidden=1
		usr.SearchBeastProc(t)
	NullText(var/t as null|text)
		set hidden=1
		SubmitTextProc(t)
	Forums()
		set hidden=1
		usr<<link("http://www.byond.com/members/Falacy/forum")
	Role_Play(t as text)
		set desc="Type a RP Based Action to Perform"
		set hidden=1
		if(!t)	return
		if(usr.IsMuted())	return
		t=SpamGuard(t);if(!t)	return
		var/Formatting="<B><font size=2 face=Frosty's Winterland><font color=green>"
		var/Icon2Show="\icon[ChatIcon]"
		var/list/Output2=world
		if(src.Subscriber)	Icon2Show="\icon[SubIcon]"
		if(src.ChatMode=="Local" && src.icon)
			Output2=view(src.SightRange,src);Icon2Show="\icon[src.PlayerIcon]"
		if(src.ChatMode=="Zone" && src.icon)
			Output2=list();Icon2Show="\icon[ZoneChatIcon]"
		if(src.ChatMode=="Zone" && src.icon)	for(var/mob/Player/M in Players)	if(M.z==src.z)	Output2+=M
		if(src.ChatMode=="Party")
			if(src.Party)
				Output2=src.Party.Members;Icon2Show="<IMG CLASS=icon SRC=\ref[src.Party.icon] ICONSTATE='ChatState'>"
			else	src<<"You aren't in a Party..."
		if(src.ChatMode=="Party" && !src.Party)	return
		var/dispo="<a href='?src=\ref[usr];action=PrivateMessage;SendMes=Yes;KeyName=[usr.MyKey]'>[Icon2Show]</a>"
		Output2<<"[dispo][Formatting] * [src] [html_encode(t)] *"
		usr.LastSays+=html_encode(t);if(src.LastSays.len>20)	src.LastSays=src.LastSays.Copy(2,0)

	Say(var/t as text)
		set hidden=1
		if(!t)	return
		if(copytext(lowertext(t),1,5)=="/me ")	{usr.Role_Play(copytext(t,5,0));return}
		if(copytext(t,1,2)=="/")	{usr.Emote(t);return}
		if(usr.IsMuted())	return
		t=SpamGuard(t);if(!t)	return
		var/Formatting="<B><font size=2 face=Frosty's Winterland><font color=white>"
		var/Icon2Show="\icon[ChatIcon]"
		var/list/Output2=world
		if(src.Subscriber)	Icon2Show="\icon[SubIcon]"
		if(src.ChatMode=="Local" && src.icon)
			Output2=view(src.SightRange,src);Icon2Show="\icon[src.PlayerIcon]"
		if(src.ChatMode=="Zone" && src.icon)
			Output2=list();Icon2Show="\icon[ZoneChatIcon]"
		if(src.ChatMode=="Zone" && src.icon)	for(var/mob/Player/M in Players)	if(M.z==src.z)	Output2+=M
		if(src.ChatMode=="Party")
			if(src.Party)
				Output2=src.Party.Members;Icon2Show="<IMG CLASS=icon SRC=\ref[src.Party.icon] ICONSTATE='ChatState'>"
			else	src<<"You aren't in a Party..."
		if(src.ChatMode=="Party" && !src.Party)	return
		var/dispo="<a href='?src=\ref[usr];action=PrivateMessage;SendMes=Yes;KeyName=[usr.MyKey]'>[Icon2Show]</a>"
		var/SubFormatting="<font color=[src.FontColor]><font face=[src.FontFace]>"
		Output2<<"[dispo][Formatting][src]:[SubFormatting] [html_encode(t)]"
		usr.LastSays+=html_encode(t);if(src.LastSays.len>20)	src.LastSays=src.LastSays.Copy(2,0)

		var/EC=copytext(t,length(t),length(t)+1)
		if(EC!="?" && EC!="!")	EC=null
		var/obj/Supplemental/Follower/X = new();X.density=0;X.layer=5;X.icon='Effects.dmi';MyFlick("Chat[EC]",X)
		src.Followers+=X;X.loc=locate(src.x+1,src.y+1,src.z)
		X.pixel_x=-8;X.pixel_y=-4
		spawn(20)	if(X)	del X
		if(src.SpiritForm)
			if(findtext(t,"Bankai!",1,0))
				for(var/obj/Skills/SoulReaper/Bankai/B in src.Skills)	spawn()	src.Bankai()
			if(src.Zanpakuto)
				if(findtext(t,"[src.Zanpakuto.Command]. [src.Zanpakuto.name]!",1,0))	spawn()	src.Shikai()
				if(findtext(t,"[src.Zanpakuto.Command], [src.Zanpakuto.name]!",1,0))	spawn()	src.Shikai()
				if(findtext(t,"[src.Zanpakuto.Command]! [src.Zanpakuto.name]!",1,0))	spawn()	src.Shikai()

	MainHelp()
		set hidden=1
		var/Help={"
			<html><body bgcolor=black>
			<title>Help</title>
			<font color=yellow><b><center>
			<font size=8>Bleach Eternity<br>
			<font size=5>Help Files<p></font size></font size></center>

			General:<br>
			<a href='?src=\ref[usr];action=Help;Help=FAQs'>FAQs</a><p>

			Combat:<br>
			<a href='?src=\ref[usr];action=Help;Help=Shini'>Basic Combat - Soul Reaper</a><br>
			<a href='?src=\ref[usr];action=Help;Help=Quincy'>Basic Combat - Quincy</a><br>
			<a href='?src=\ref[usr];action=Help;Help=AdvCombat'>Advanced Combat</a><p>

			Mini Games:<br>
			<a href='?src=\ref[usr];action=Help;Help=Chess'>Chess</a><br>
			<a href='?src=\ref[usr];action=Help;Help=Checkers'>Checkers</a><br>
			<a href='?src=\ref[usr];action=Help;Help=Poker'>Poker</a><br>
			<a href='?src=\ref[usr];action=Help;Help=BlackJack'>Black Jack</a><br>
			<a href='?src=\ref[usr];action=Help;Help=FSF'>Flash Step Fenzy</a><br>
		"}
		usr<<browse(Help,"window=Help")
	FAQsHelp()
		set hidden=1
		var/Help={"[MainHelpFormat("FAQs")]
		<font color=gray>Can I Logout During Votes?<br></font color>
		Logging out while a Vote is in Progress will have no Effect on its Outcome<br>
		Feel free to Logout at any time<p>

		<font color=gray>When do I get Transformations?<br></font color>
		- Shikai can be attained at level 20 by completing Urahara's Training<br>
		- Bankai can be attained at level 50 by completing Yoruichi's Training<br>
		- Visored can be attained at level 125 by completing Hiyori's Training<br>
		- Final Form can be attained at level 25 by completing Uryu's Grandfather's Training<p>

		<font color=gray>How do I Rest?<br></font color>
		Your character will automaticaly regian Stamina and Reiatsu after avoiding damage for 10 seconds<br>
		If you return to your body you will recover both stats at a faster rate<p>

		<font color=gray>How do I Save my Game?<br></font color>
		The Game will Automaticaly Save your Character<p>
		"}
		usr<<browse(Help,"window=Help")
	ShiniHelp()
		set hidden=1
		var/Help={"[MainHelpFormat("Soul Reaper Combat")]"}
		usr<<browse(Help,"window=Help")
	QuincyHelp()
		set hidden=1
		var/Help={"[MainHelpFormat("Quincy Combat")]"}
		usr<<browse(Help,"window=Help")
	AdvCombatHelp()
		set hidden=1
		var/Help={"[MainHelpFormat("Advanced Combat")]"}
		usr<<browse(Help,"window=Help")
	ChessHelp()
		set hidden=1
		var/Help={"[MainHelpFormat("Chess")]"}
		usr<<browse(Help,"window=Help")
	CheckersHelp()
		set hidden=1
		var/Help={"[MainHelpFormat("Checkers")]"}
		usr<<browse(Help,"window=Help")
	PokerHelp()
		set hidden=1
		var/Help={"[MainHelpFormat("Poker")]"}
		usr<<browse(Help,"window=Help")
	BlackJackHelp()
		set hidden=1
		var/Help={"[MainHelpFormat("Black Jack")]"}
		usr<<browse(Help,"window=Help")
	FSFHelp()
		set hidden=1
		var/Help={"[MainHelpFormat("Flash Step Frenzy")]"}
		usr<<browse(Help,"window=Help")

proc/MainHelpFormat(var/Page)
	var/Help={"
			<html><body bgcolor=black>
			<title>Help</title>
			<font color=yellow><b><center>
			<font size=8>Bleach Eternity<br>
			<font size=5>[Page]<p></font size></font size></center>
			<a href='?src=\ref[usr];action=Help;Help=Main'>Main</a><p>"}
	return Help