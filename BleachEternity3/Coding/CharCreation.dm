mob/var/Loaded=0
mob/var/Loading=0
mob/proc/SaveFileHUD()
	usr.Loading=1
	for(var/i=1,i<=5,i++)
		var/ySpot=17-((i-1)*3)
		if(i>=3)	ySpot-=1
		if(FileExists("[ckey(usr.key)][i]"))
			var/savefile/F = new("Players/[copytext(ckey(usr.key),1,2)]/[ckey(usr.key)][i].sav")
			var/mob/M=new
			M.mouse_opacity=0
			F["Class"]>>M.Class
			F["Level"]>>M.Level
			F["name"]>>M.name
			F["HairR"]>>M.HairR
			F["HairG"]>>M.HairG
			F["HairB"]>>M.HairB
			F["HairStyle"]>>M.HairStyle
			//Used for Global Save
			/*var/Text=world.Export("byond://166.82.8.113:4440?RequestLoad[ckey(src.key)][i]")
			var/CurSpot=1
			var/mob/M=new
			M.Class=copytext(Text,CurSpot,findtext(Text,"|",CurSpot+1,0));CurSpot=findtext(Text,"|",CurSpot+1,0)+1
			M.Level=copytext(Text,CurSpot,findtext(Text,"|",CurSpot,0));CurSpot=findtext(Text,"|",CurSpot,0)+1
			M.name=copytext(Text,CurSpot,findtext(Text,"|",CurSpot,0));CurSpot=findtext(Text,"|",CurSpot,0)+1
			M.HairR=copytext(Text,CurSpot,findtext(Text,"|",CurSpot,0));CurSpot=findtext(Text,"|",CurSpot,0)+1
			M.HairG=copytext(Text,CurSpot,findtext(Text,"|",CurSpot,0));CurSpot=findtext(Text,"|",CurSpot,0)+1
			M.HairB=copytext(Text,CurSpot,findtext(Text,"|",CurSpot,0));CurSpot=findtext(Text,"|",CurSpot,0)+1
			M.HairStyle=copytext(Text,CurSpot,findtext(Text,"|",CurSpot,0))
			M.HairR=text2num(M.HairR);M.HairG=text2num(M.HairG);M.HairB=text2num(M.HairB)*/
			M.layer=25;M.AddHair(M.HairStyle)
			src.WriteLine(6,12,ySpot,12,"LoadScreen","[M.name]",0)
			src.WriteLine(6,12,ySpot,2,"LoadScreen","Level [M.Level] [M.Class]",0)
			M.screen_loc="14,[ySpot-1]:4";M.icon_state="Stance";src.client.screen+=M
			if(M.Class=="Soul Reaper")	M.icon='SoulReaper.dmi'
			if(M.Class=="Quincy")	M.icon='Quincy.dmi'
			if(M.Class=="Bount")
				if(usr.gender!="female")	M.icon='School.dmi'
				else	M.icon='SchoolFemale.dmi'
		else	src.WriteLine(8,16,ySpot,-4,"LoadScreen","Empty Save Slot",0)
	usr.Loading=0

turf
	CharCreation
		density=1
		TitleScreen
			icon='BE1.png'
			Click()
				if(usr.Loading)	return
				if(usr.Chatting)	return
				if(usr.loc==locate(10,10,2))
					//usr<<"Testing Connection..."
					/*if(world.Export("byond://166.82.8.113:4440?Connection-Test"))
						usr<<"<b>Successfully Established Connection with Save Server"
					else
						world<<"<b><font color=red>Connection with Save Server could not be Established";return*/
					//Test connection with host for Loading
					//Used for Global Save
					/*if(!world.Export("byond://166.82.8.113:4440?Test-Load"))
						usr<<"<b><font color=red>Save Server could not Establish a Connection with Host";return*/
					PlayMenuSound(usr,'OOT_MainMenu_Select.wav')
					usr.loc=locate(86,10,2)
					usr.SaveFileHUD()
				else
					PlayMenuSound(usr,'OOT_MainMenu_Cancel.wav')
					usr.loc=locate(10,10,2)
					usr.ClearHUD()
		ClassSelect
			layer=3
			icon='Class.png'
		LoadScreen
			layer=3
			icon='Load.png'
		SelectButton
			layer=3
			icon='SelectButton.png'
		DeleteButton
			layer=3
			icon='Delete.png'
		ZanpakutoCreation
			layer=3
			icon='Zanpakuto.png'
		CharCreation
			layer=3
			icon='CharCreation.png'

		Buttons
			mouse_opacity=2
			layer=4
			icon=null
			LoadGame
				var/Slot=1
				Click()
					if(usr.Loaded)	return
					if(usr.Loading)	return
					if(usr.Chatting)	return
					if(usr.loc!=locate(86,10,2))	return
					PlayMenuSound(usr,'OOT_MainMenu_Select.wav')
					usr.Loaded=1;usr.ClearHUD();usr.loc=locate(10,10,2)
					usr.SaveSlot=src.Slot
					if(FileExists("[ckey(usr.key)][usr.SaveSlot]"))
						if(ShowAlert(usr,"Load the Character from Slot [src.Slot]?",list("Load","Cancel"))=="Load")
							usr.Load();return
					else
						if(!usr.Subscriber && src.Slot>=3)
							ShowAlert(usr,"Additional Save Slots Available for Subscribers")
							if(!usr)	return
							usr.loc=locate(86,10,2);usr.SaveFileHUD()
							usr.Loaded=0;return
						if(ShowAlert(usr,"No File Detected. > Create a New Character in Slot [src.Slot]?",list("Create","Cancel"))=="Create")
							usr.loc=locate(29,10,2);return
					if(!usr)	return
					usr.Loaded=0;usr.loc=locate(86,10,2);usr.SaveFileHUD()
			DeleteGame
				var/Slot=1
				Click()
					if(usr.Loaded)	return
					if(usr.Loading)	return
					if(usr.Chatting)	return
					if(usr.loc!=locate(86,10,2))	return
					PlayMenuSound(usr,'OOT_MainMenu_Cancel.wav')
					usr.ClearHUD();usr.loc=locate(10,10,2)
					if(FileExists("[ckey(usr.key)][src.Slot]"))
						if(ShowAlert(usr,"Are you sure you want to Delete the Character in Slot [src.Slot]?",list("Delete","Cancel"))=="Delete")
							usr.Chatting=1
							if((input("Delete Character?  Are you sure?\nThis process cannot be reversed.\n\
									Type DELETE in the area below to confirm.","Delete Character") as text)=="DELETE")
								//Used for Global Save
								//world.Export("byond://166.82.8.113:4440?Delete[ckey(usr.key)][src.Slot]")
								fdel("Players/[copytext(ckey(usr.key),1,2)]/[ckey(usr.key)][src.Slot].sav")
							usr.Chatting=0
					else	ShowAlert(usr,"No Character Saved to this Slot.  Cannot Delete File.")
					if(usr)
						usr.loc=locate(86,10,2);usr.SaveFileHUD()
			ClassConstruction
				mouse_opacity=2
				Click()
					ShowAlert(usr,"This Class is Still Under Construction",list("OK"))
			ClassSelect
				var/Class="Soul Reaper"
				desc="Soul Reapers are masters of the blade.  They prefer close quarter combat, using swift combo chains and defensive maneuvers to quickly dispatch their foes"
				mouse_opacity=2
				Click()
					if(ShowAlert(usr,"[src.desc] > > Play as a [src.Class]?",list("Yes","No"))=="Yes")
						if(src in oview(10,usr))
							usr.Class=src.Class
							usr.loc=locate(48,10,2)
							spawn()	while(usr.loc==locate(48,10,2))
								sleep(10);if(!usr)	return
								for(var/obj/O in usr.client.screen)
									if(istype(O,/obj/HUD/CharPreview)||istype(O,/obj/HUD/HairPreview))
										if(O.dir==2)	O.dir=8
										else if(O.dir==8)	O.dir=1
										else if(O.dir==1)	O.dir=4
										else if(O.dir==4)	O.dir=2
							var/obj/CP=new/obj/HUD/CharPreview
							usr.client.screen+=CP
							if(usr.Class=="Soul Reaper")	CP.icon='SoulReaper.dmi'
							if(usr.Class=="Quincy")	CP.icon='Quincy.dmi'
							if(usr.Class=="Bount")
								if(usr.gender!="Female")	CP.icon='School.dmi'
								else	CP.icon='SchoolFemale.dmi'
							var/obj/HP=new/obj/HUD/HairPreview
							usr.client.screen+=HP
							usr.name=html_encode(copytext(usr.key,1,15))
							usr.WriteLine(7,7,16,11,"NameDisplay",usr.name,1)
			Name
				Click()
					usr.ChangeName()
					if(usr) usr.WriteLine(7,7,16,11,"NameDisplay",usr.name,1)
			HairStyle
				Click()
					usr.HairColor()
			VoiceSet
				Click()
					usr.VoiceSelect()
			Done	//Done	//new char setup
				Click()
					if(ShowAlert(usr,"Start the game with this Character? > > \
						Class:  [usr.Class] > Name:  [usr.name] > Hair Style:  \
						[usr.HairStyle] > Voice Set:  [usr.VoiceSet]",list("Yes","No"))!="Yes")	return
					if(!usr)	return
					if(usr.icon)	return
					usr.icon='School.dmi'
					if(usr.gender==FEMALE)	usr.icon='SchoolFemale.dmi'
					usr.LHD=round((usr.Level*3+7)/6)
					//usr.DamageIcon=src.icon+rgb(255,0,0)
					//usr.GuardIcon=src.icon+rgb(155,155,155)
					usr.LoadVoiceSet()
					usr.AddHair(usr.HairStyle)
					usr.AddName()
					winset(usr,"HairWindow","is-visible=false")
					winset(usr,"VoiceWindow","is-visible=false")
					usr.HUD()
					usr.ReiBar()
					usr.StmBar()
					if(usr.Class=="Quincy")
						usr.Skills+=new/obj/Skills/Quincy/Spirit_Arrow
						usr.Skills+=new/obj/Skills/Universal/Flash_Step
						usr.CanShunpo=1
						usr.StmRegenBonus=0
					if(usr.Class=="Soul Reaper")
						usr.Skills+=new/obj/Skills/SoulReaper/Basic_Combat
						usr.Skills+=new/obj/Skills/SoulReaper/Guard
						usr.ComboList=list("S1","D1","F1","F2","F3")
						usr.ReiRegenBonus=0
					if(usr.Class=="Bount")
						usr.Skills+=new/obj/Skills/Bount/Summon_Pet
						usr.Skills+=new/obj/Skills/Bount/Dismiss_Pet
						usr.Skills+=new/obj/Skills/Bount/Heal_Pet
						usr.Skills+=new/obj/Skills/Bount/Pet_Skills
						usr.Pets+=new/mob/Pets/BountPets/Fly_Trap
						for(var/mob/Pets/P in usr.Pets)	P.Owner=usr
						usr.ComboList=list("F1")
					usr.Spells+=new/obj/Spells/Teleportation/Teleportation
					usr.Spells+=new/obj/Spells/Teleportation/Recall
					for(var/obj/Skills/O in usr.Skills)	O.Level=1
					usr.QuestRefresh()
					usr.loc=locate(50,88,1)
					usr.invisibility=0
					//usr.Save()
					usr.CreatePlayerIcon()
					PlayMenuSound(usr,'TP_Talk_Start.wav')
					ShowAlert(usr,"This Game Uses an AutoSave Feature")
					ShowText(usr,"Welcome to Bleach Eternity! > > ** Press the F Key to Advance Messages")
					ShowText(usr,"** NPCs with an ! over their head Have Important Information for you. > > ** Press the F Key to Talk with them")