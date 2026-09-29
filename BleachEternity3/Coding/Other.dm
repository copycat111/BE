//Character Emote System
var/list/CommandList=list("/help","/music","/sit","/stand","/wave","/follow","/me")
mob/proc/Emote(var/T)
	usr=src;T=lowertext(T)
	if(T=="/help")
		usr<<"Available Commands:	/Help	/Music	/Sit	/Stand	/Wave	/Follow	/Me"
		return
	if(T=="/wave")
		usr.dir=SOUTH;MyFlick("Wave",usr)
	if(T=="/sit" && usr.icon_state=="")
		usr.dir=SOUTH;usr.icon_state="Sitting"
	if(T=="/stand" && usr.icon_state=="Sitting")
		usr.icon_state=""
	if(T=="/follow")
		if(usr.Target)	walk_to(usr,usr.Target,1,2)
		else	QuestShow(usr,"Invalid Target")
	if(T=="/music")
		if(!usr.SpiritForm)	{QuestShow(usr,"Spirit Form Required");return}
		usr.MusicMode=!usr.MusicMode
		if(usr.MusicMode)
			QuestShow(usr,"Press 1-8 to Play your Spirit Harp")
			QuestShow(usr,"Hold Shift or Ctrl to Change Octaves")
			usr.icon_state="Music";usr.CanMove=0;usr.dir=SOUTH
		else	{usr.icon_state="";usr.CanMove=1}
	if(!(T in CommandList))	usr<<"Invalid or Unknown Command '[T]'.  Type '/Help' for a Full List of Commands."


mob/var/obj/OverDriveBar
obj/Supplemental/OverDriveBar
	icon='OverDriveBar.dmi'
	layer=3;pixel_y=-23
mob/proc/UpdateOverDriveBar()
	var/pix_y=-23
	if(!src.StmBar || src.StmBar.icon_state=="32")	pix_y+=4
	if(!src.ReiBar || src.ReiBar.icon_state=="32")	pix_y+=4
	if(!src.OverDriveBar)	src.OverDriveBar=new/obj/Supplemental/OverDriveBar
	src.overlays-=src.OverDriveBar
	src.OverDriveBar.pixel_y=pix_y
	src.OverDriveBar.icon_state="[32-src.OverDriveStr]"
	src.overlays+=src.OverDriveBar

var/obj/Supplemental/OverDrive/OverDriveAura=new()
mob/var/OverDriveStr=32
mob/var/OverDriveOn=0
mob/verb/ActivateOverDrive()
	set hidden=1
	if(usr.OverDriveOn || usr.OverDriveStr<32)	return
	usr.OverDriveOn=1
	if(!usr.icon_state && usr.Class!="Quincy")	usr.icon_state="Stance"
	usr.overlays-=OverDriveAura;usr.overlays+=OverDriveAura
	PlayTimedSound(view(usr,9),'Energy.wav',32)
	while(usr && usr.OverDriveStr>0)
		usr.OverDriveStr-=1;usr.UpdateOverDriveBar()
		sleep(1)
	if(!usr)	return
	usr.OverDriveOn=0;usr.overlays-=OverDriveAura
	while(usr && usr.OverDriveStr<32)
		sleep(10)
		if(usr)	{usr.OverDriveStr+=1;usr.UpdateOverDriveBar()}

obj/Supplemental/OverDrive
	icon='OverDrive.dmi';icon_state="BL"
	layer=7.1;pixel_x=-6;pixel_y=-1
	New()
		var/obj/TL=new();TL.icon='OverDrive.dmi';TL.icon_state="TL"
		TL.pixel_y=32;TL.layer=7.1;src.overlays+=TL
		var/obj/TR=new();TR.icon='OverDrive.dmi';TR.icon_state="TR"
		TR.pixel_x=32;TR.pixel_y=32;TR.layer=7.1;src.overlays+=TR
		var/obj/BR=new();BR.icon='OverDrive.dmi';BR.icon_state="BR"
		BR.pixel_x=32;BR.layer=7.1;src.overlays+=BR
		return ..()

//Music System
obj/Supplemental/Musical_Note
	icon='Other.dmi'
	icon_state="Note"
	layer=8
	New(var/mob/M)
		src.loc=M.loc
		spawn()
			while(src)
				src.pixel_y+=rand(-1,2)*2
				src.pixel_x-=rand(1,2)
				sleep(1)
		spawn(30)
			MyFlick("NoteOut",src)
			spawn(5)	del src


mob/proc/PlayNote(var/HKD,var/Secondary)
	if(HKD!="9")
		MyFlick("Play[rand(1,2)]",src)
		new/obj/Supplemental/Musical_Note(src)
	if(!Secondary)
		if(HKD=="1")	PlaySoundEffect(view(src,src.SightRange),'L1.wav')
		if(HKD=="2")	PlaySoundEffect(view(src,src.SightRange),'L2.wav')
		if(HKD=="3")	PlaySoundEffect(view(src,src.SightRange),'L3.wav')
		if(HKD=="4")	PlaySoundEffect(view(src,src.SightRange),'L4.wav')
		if(HKD=="5")	PlaySoundEffect(view(src,src.SightRange),'L5.wav')
		if(HKD=="6")	PlaySoundEffect(view(src,src.SightRange),'L6.wav')
		if(HKD=="7")	PlaySoundEffect(view(src,src.SightRange),'L7.wav')
		if(HKD=="8")	PlaySoundEffect(view(src,src.SightRange),'L8.wav')
	if(Secondary=="Shift")
		if(HKD=="1")	PlaySoundEffect(view(src,src.SightRange),'M1.wav')
		if(HKD=="2")	PlaySoundEffect(view(src,src.SightRange),'M2.wav')
		if(HKD=="3")	PlaySoundEffect(view(src,src.SightRange),'M3.wav')
		if(HKD=="4")	PlaySoundEffect(view(src,src.SightRange),'M4.wav')
		if(HKD=="5")	PlaySoundEffect(view(src,src.SightRange),'M5.wav')
		if(HKD=="6")	PlaySoundEffect(view(src,src.SightRange),'M6.wav')
		if(HKD=="7")	PlaySoundEffect(view(src,src.SightRange),'M7.wav')
		if(HKD=="8")	PlaySoundEffect(view(src,src.SightRange),'M8.wav')
	if(Secondary=="Ctrl")
		if(HKD=="1")	PlaySoundEffect(view(src,src.SightRange),'EL1.wav')
		if(HKD=="2")	PlaySoundEffect(view(src,src.SightRange),'EL2.wav')
		if(HKD=="3")	PlaySoundEffect(view(src,src.SightRange),'EL3.wav')
		if(HKD=="4")	PlaySoundEffect(view(src,src.SightRange),'EL4.wav')
		if(HKD=="5")	PlaySoundEffect(view(src,src.SightRange),'EL5.wav')
		if(HKD=="6")	PlaySoundEffect(view(src,src.SightRange),'EL6.wav')
		if(HKD=="7")	PlaySoundEffect(view(src,src.SightRange),'EL7.wav')
		if(HKD=="8")	PlaySoundEffect(view(src,src.SightRange),'EL8.wav')



mob/proc/KeyboardLine()
	PlayMenuSound(src,'OOT_MainMenu_Select.wav')
	src.WriteLine(5,12,16,11,"InputVariable","[usr.InputVariable]",1)

proc/ArtSetup()
	WriteMapLine(62,4,34,12,2,"Kidous: Magic Spells available to Soul Reapers")
	WriteMapLine(62,4,31,12,2,"Silver Tube: Spirit Energy Attacks for Quincies")
	WriteMapLine(62,4,28,12,2,"Spells: Generic Magic available to Everyone")

proc/StatSetup()
	WriteMapLine(5,4,53,12,2,"Stamina Increases your Maximum Health")
	WriteMapLine(5,4,52,17,2,"Reiatsu Increases your Maximum Spirit Energy")
	WriteMapLine(5,4,52,6,2,"Also Effects Spiritual Pressure")
	WriteMapLine(5,4,50,17,2,"Strength Increases the Damage done by Melee Attacks")
	WriteMapLine(5,4,50,6,2,"Figures Directly into Soul Reaper's Normal Attacks")
	WriteMapLine(5,4,49,12,2,"Vitality Increases your Defense Against Melee Attacks")
	WriteMapLine(5,4,47,17,2,"Magic Increases the Damage done by Mystic Attacks")
	WriteMapLine(5,4,47,6,2,"Figures Directly into Quincy's Normal Attacks")
	WriteMapLine(5,4,46,12,2,"Magic Defense Increases your Defense Against Mystic Attacks")
	WriteMapLine(5,4,44,17,2,"Agility Increases your Chance to Hit and Dodge Attacks")
	WriteMapLine(5,4,44,6,2,"Also Determines how easily you can Track Flash Steps")
	WriteMapLine(5,4,43,17,2,"Luck Increases your Chance to Hit Critical")
	WriteMapLine(5,4,43,6,2,"Also Increases Item Drop Rates")

proc/TraitSetup()
	WriteMapLine(24,4,54,17,2,"Zanjutsu: Zanpakuto Combat")
	WriteMapLine(24,4,54,6,2,"+1% Damage Dealt by Melee Attacks")
	WriteMapLine(24,4,52,17,2,"Hakuda: Hand-to-Hand Combat")
	WriteMapLine(24,4,52,6,2,"+1% Chance to Land Attacks")
	WriteMapLine(24,4,50,17,2,"Hohou: Speed Based Combat")
	WriteMapLine(24,4,50,6,2,"+1% Chance to Dodge Attacks")
	WriteMapLine(24,4,48,17,2,"Kidou: Spirit Energy Combat")
	WriteMapLine(24,4,48,6,2,"+1% Mystic Damage.  Required to learn Higher Level Kidous")
	WriteMapLine(24,4,46,17,2,"Prodigy")
	WriteMapLine(24,4,46,6,2,"Lowers Required EXP by 100")
	WriteMapLine(24,4,44,17,2,"Training")
	WriteMapLine(24,4,44,6,2,"+1 Skill Points")
	WriteMapLine(24,4,42,17,2,"Income")
	WriteMapLine(24,4,42,6,2,"+1% Copper Earned from Kills")

proc/PetAISetup()
	for(var/n=0;n<=19;n+=19)
		for(var/i=131;i>=119;i-=3)
			WriteMapLine(2+n,2,i,0,2,"If...")
			WriteMapLine(3+n,2,i,0,2,"Target's")
			WriteMapLine(6+n,2,i,0,2,"Variable")
			WriteMapLine(9+n,2,i,0,2,"Is...")
			WriteMapLine(12+n,2,i,0,2,"Amount/Effect")
			WriteMapLine(15+n,2,i,0,2,"Then:")
			if(n)	return

proc/KeyboardSetup()
	for(var/obj/HUD/LetterInput/B in world)
		if(B.y<68)	B.name="Space"
	for(var/obj/HUD/LetterInput/B in locate(31,68,2))	B.name="Backspace"
	for(var/obj/HUD/LetterInput/B in locate(32,68,2))	B.name="Backspace"

	WriteMapLine(22,12,70,11,2,"Q");for(var/obj/HUD/LetterInput/B in locate(22,70,2))	B.name="Q"
	WriteMapLine(23,12,70,11,2,"W");for(var/obj/HUD/LetterInput/B in locate(23,70,2))	B.name="W"
	WriteMapLine(24,12,70,11,2,"E");for(var/obj/HUD/LetterInput/B in locate(24,70,2))	B.name="E"
	WriteMapLine(25,12,70,11,2,"R");for(var/obj/HUD/LetterInput/B in locate(25,70,2))	B.name="R"
	WriteMapLine(26,12,70,11,2,"T");for(var/obj/HUD/LetterInput/B in locate(26,70,2))	B.name="T"

	WriteMapLine(28,12,70,11,2,"Y");for(var/obj/HUD/LetterInput/B in locate(28,70,2))	B.name="Y"
	WriteMapLine(29,12,70,11,2,"U");for(var/obj/HUD/LetterInput/B in locate(29,70,2))	B.name="U"
	WriteMapLine(30,12,70,11,2,"I");for(var/obj/HUD/LetterInput/B in locate(30,70,2))	B.name="I"
	WriteMapLine(31,12,70,11,2,"O");for(var/obj/HUD/LetterInput/B in locate(31,70,2))	B.name="O"
	WriteMapLine(32,12,70,11,2,"P");for(var/obj/HUD/LetterInput/B in locate(32,70,2))	B.name="P"

	WriteMapLine(22,12,69,11,2,"A");for(var/obj/HUD/LetterInput/B in locate(22,69,2))	B.name="A"
	WriteMapLine(23,12,69,11,2,"S");for(var/obj/HUD/LetterInput/B in locate(23,69,2))	B.name="S"
	WriteMapLine(24,12,69,11,2,"D");for(var/obj/HUD/LetterInput/B in locate(24,69,2))	B.name="D"
	WriteMapLine(25,12,69,11,2,"F");for(var/obj/HUD/LetterInput/B in locate(25,69,2))	B.name="F"
	WriteMapLine(26,12,69,11,2,"G");for(var/obj/HUD/LetterInput/B in locate(26,69,2))	B.name="G"

	WriteMapLine(28,12,69,11,2,"H");for(var/obj/HUD/LetterInput/B in locate(28,69,2))	B.name="H"
	WriteMapLine(29,12,69,11,2,"J");for(var/obj/HUD/LetterInput/B in locate(29,69,2))	B.name="J"
	WriteMapLine(30,12,69,11,2,"K");for(var/obj/HUD/LetterInput/B in locate(30,69,2))	B.name="K"
	WriteMapLine(31,12,69,11,2,"L");for(var/obj/HUD/LetterInput/B in locate(31,69,2))	B.name="L"

	WriteMapLine(22,12,68,11,2,"Z");for(var/obj/HUD/LetterInput/B in locate(22,68,2))	B.name="Z"
	WriteMapLine(23,12,68,11,2,"X");for(var/obj/HUD/LetterInput/B in locate(23,68,2))	B.name="X"
	WriteMapLine(24,12,68,11,2,"C");for(var/obj/HUD/LetterInput/B in locate(24,68,2))	B.name="C"
	WriteMapLine(25,12,68,11,2,"V");for(var/obj/HUD/LetterInput/B in locate(25,68,2))	B.name="V"
	WriteMapLine(26,12,68,11,2,"B");for(var/obj/HUD/LetterInput/B in locate(26,68,2))	B.name="B"

	WriteMapLine(28,12,68,11,2,"N");for(var/obj/HUD/LetterInput/B in locate(28,68,2))	B.name="N"
	WriteMapLine(29,12,68,11,2,"M");for(var/obj/HUD/LetterInput/B in locate(29,68,2))	B.name="M"

	WriteMapLine(34,12,70,11,2,"7");for(var/obj/HUD/LetterInput/B in locate(34,70,2))	B.name="7"
	WriteMapLine(35,12,70,11,2,"8");for(var/obj/HUD/LetterInput/B in locate(35,70,2))	B.name="8"
	WriteMapLine(36,12,70,11,2,"9");for(var/obj/HUD/LetterInput/B in locate(36,70,2))	B.name="9"

	WriteMapLine(34,12,69,11,2,"4");for(var/obj/HUD/LetterInput/B in locate(34,69,2))	B.name="4"
	WriteMapLine(35,12,69,11,2,"5");for(var/obj/HUD/LetterInput/B in locate(35,69,2))	B.name="5"
	WriteMapLine(36,12,69,11,2,"6");for(var/obj/HUD/LetterInput/B in locate(36,69,2))	B.name="6"

	WriteMapLine(34,12,68,11,2,"1");for(var/obj/HUD/LetterInput/B in locate(34,68,2))	B.name="1"
	WriteMapLine(35,12,68,11,2,"2");for(var/obj/HUD/LetterInput/B in locate(35,68,2))	B.name="2"
	WriteMapLine(36,12,68,11,2,"3");for(var/obj/HUD/LetterInput/B in locate(36,68,2))	B.name="3"

	WriteMapLine(26,28,67,11,2,"Space")
	WriteMapLine(31,16,68,11,2,"Back")