var/bleachsymbol = new/obj/Supplemental/Symbol
var/GoldIcon=new/obj/Supplemental/GoldIcon
var/SilverIcon=new/obj/Supplemental/SilverIcon
var/CopperIcon=new/obj/Supplemental/CopperIcon
var/GC="<font color=yellow>"
var/SC="<font color=gray>"
var/CC="<font color=#CC9933>"
mob/var/obj/NullObj

obj
	Supplemental
		RefreshHUD
			icon='pointer.dmi'
			icon_state="1"
			screen_loc="10,10"
			mouse_opacity=0
			layer=1
		GoldIcon
			icon='Main.dmi'
			icon_state="Gold"
		SilverIcon
			icon='Main.dmi'
			icon_state="Silver"
		CopperIcon
			icon='Main.dmi'
			icon_state="Copper"
		Symbol
			name="Info"
			icon='Main.dmi'
			icon_state="bleachsymbol"
mob
	Stat()
		statpanel("Server")
		stat("Host:", "[world.host]")
		stat("Version:", "[GameVersion]")
		stat("Up Time:","[hours]:[minutes]:[seconds]")
		stat("Time Zone:","[time2text(world.timeofday,"hh:mm")]")
		if(PlayerLimit)	stat("Players:", "[PlayerCount] / [PlayerLimit]")
		else	stat("Players:", "[PlayerCount]")
		stat("Usage:", "[world.cpu]%")
		stat("Link:","[world.internet_address]:[world.port] [IsRouted]")
		stat("Tag:", "[StatusNote]")

		/*statpanel("Vote")
		stat("<b>Click to Interact")
		stat(VoteTypes)
		stat("<b>[Votes.len] Votes Currently Underway")
		stat(Votes)*/

		statpanel("Parties")
		stat("Double Click a Party for Details")
		stat("[Parties.len] Parties Online")
		stat(Parties)

		statpanel("Controls")
		stat("<b><u>Key","<b><u>Function")
		stat("Arrow Keys","Movement")
		stat("Numpad's /","Toggle AutoWalk")
		stat("A","Use Skill")
		stat("1-9","Use HotKey")
		stat("S","Low Attack/Charge Power/DeActivate Pet")
		stat("D","Mid Attack/Charge Distance/Activate Pet")
		stat("F","High Attack/Fire Arrow/Basic Attack")
		stat("G","Guard/Counter Step")
		stat("T","Target Enemy")
		stat("Q","Target Player")
		stat("Escape","Cancel Target")
		stat("Space","Spirit Form/Spiritual Overdrive")
		stat("Z","Spiritual Overdrive")
		stat("Tab","Return to Body")
		stat("Enter","Chat")
		stat("E","Role Play/Emote")
		stat("M","Toggle Map")
		stat("I","Toggle Inventory")
		stat("W","View Who")
		stat("?","View Help")
		stat("O","View Options")
		stat("U","View Updates")
		stat("L","View Quest Log")
		stat("F2","ScreenShot")
		stat("F8","View Buddy List")

	proc/RelocateWindows()
		return
		while(src)
			var/x="[winget(src,"MainWindow","pos")]"
			x=text2num(copytext(x,1,findtext(x,",")))
			var/y="[winget(src,"MainWindow","pos")]"
			y=text2num(copytext(y,findtext(y,",")+1,0))
			if(winget(src,"MainWindow","is-maximized")=="true")	{x=-4;y=-4}
			winset(src,"QuestShowWindow","pos=[x+8],[y+108]")
			sleep(1)

	proc/SecondLoop()
		if(!src.NullObj)	src.NullObj=new/obj/Supplemental/RefreshHUD
		if(!(src.NullObj in src.client.screen))	src.client.screen+=src.NullObj
		src.NullObj.icon_state="[rand(1,5)]"
		src.NullObj.screen_loc="[rand(1,19)],[rand(1,19)]"
		src.QuestClear-=1
		if(!src.QuestClear)
			for(var/i=0;i<=6;i++)	src<<output("","QuestShowWindow.Output")
		src.CheckAFK()
		src.SkillProcs()
		src.QuestDuration()
		src.StatusDuration()
		if(src.Party)	src.RefreshPartyHUD()
		if(src.STM>src.MaxSTM)	src.STM=src.MaxSTM-1
		if(src.REI>src.MaxREI)	src.REI=src.MaxREI-1
		if(src.z!=2)
			src.PlayTime+=1
			if(!src.Chatting && !src.invisibility)
				src.RegenWait-=1;src.ReiRegenWait-=1;src.PVPWait-=1;src.CombatPhase()
				if(src.Class=="Bount" || src.RegenWait<0 || (src.STM>1 && src.FindEffect("Regen")))
					var/Ok2Go=1
					if(src.Class=="Bount" && src.STM<src.MaxSTM)
						if(src.REI<src.StmRegenCost)	Ok2Go=0
						else	{src.REI-=src.StmRegenCost;src.ReiBar()}
					if(Ok2Go)
						var/StmBonus=src.StmRegenBonus
						if(!src.SpiritForm)	StmBonus+=1
						if(src.STM<src.MaxSTM)
							src.STM=min(src.MaxSTM,src.STM+(10*StmBonus));src.StmBar()
				if(src.ReiRegenWait<0 && !src.SkillBeingCharged)
					var/Ok2Go=1
					if(Ok2Go)
						var/ReiBonus=src.ReiRegenBonus
						if(!src.SpiritForm)	ReiBonus+=1
						if(src.REI<src.MaxREI)
							src.REI=min(src.MaxREI,src.REI+(10*ReiBonus));src.ReiBar()
		if(src.SkillBeingCharged)
			if(src.InfBeamCost)
				if(src.REI<InfBeamCost || !src.SpiritForm)	call(src,"[src.SkillBeingCharged] Release")()
				else	{src.ReiRegenWait=10;src.REI-=InfBeamCost;src.ReiBar()}
		spawn(10)	if(src)	src.SecondLoop()


mob/var/obj/ClassOrb
mob/var/LastCombatPhase="Free"
mob/proc/CombatPhase()
	var/ThisCombatPhase="Free"
	if(src.RegenWait>=0 || (src.PVP && src.PVPWait>0))	ThisCombatPhase="Combat"
	if(ThisCombatPhase!=src.LastCombatPhase)
		src.LastCombatPhase=ThisCombatPhase
		if(src.ClassOrb)
			if(ThisCombatPhase=="Combat")	src.ClassOrb.icon_state="[src.Class] Combat"
			else	src.ClassOrb.icon_state="[src.Class]"
		if(src.Party)	for(var/mob/M in src.Party.Members)
			if(M.client)	for(var/obj/HUD/PartyClassOrb/O in M.client.screen)	if(O.MyMob==src)
				if(ThisCombatPhase=="Combat")	O.icon_state="[src.Class] Combat"
				else	O.icon_state="[src.Class]"
				break


var/obj/AFKicon=new/obj/Supplemental/AFK
obj/Supplemental/AFK
	layer=9;pixel_x=8;pixel_y=6
	icon='Other.dmi';icon_state="AFK"

mob/proc/CheckAFK()
	if(src.client.inactivity>=3000)//15 Minutes
		/*if(!src.Subscriber)
			world<<"<b><font color=red><font size=1>[src] has been AFK Booted"
			src<<"<font size=1>Subscription required to Bypass AFK Booter"
			del src.client;return*/
		if(!src.AFK)
			src.overlays-=AFKicon;src.overlays+=AFKicon
			src.AFK=1;world<<"[PlayerInfoTag][src] has been Switched to AFK Mode"
	else	if(src.AFK)
		src.overlays-=AFKicon
		src.AFK=0;world<<"[PlayerInfoTag][src] has Returned from AFK Mode"

mob/proc/SkillProcs()
	if(!usr.invisibility)
		if("Scatter" in src.ToggledSkills)
			if(!src.Shikai && !src.Bankai)	src.Scatter()
			var/Damage;for(var/obj/Skills/Shikais/Light_Dragon/Scatter/S in src.Skills)
				Damage=(S.Level-1+25+src.MGC)*((0.25*(S.Level-1))+1)
			for(var/mob/M in oview(1,src))	src.Damage(M,Damage-round(M.REI/100),"Petal",1,"Mystic")