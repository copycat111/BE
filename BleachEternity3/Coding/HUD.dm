var/PVPicon=new/obj/Supplemental/PVP
obj/Supplemental/PVP
	icon='Main.dmi'
	icon_state="PVP"
	pixel_x=-8
	pixel_y=-19
obj
	HUD
		icon='Hud.dmi'
		layer=20
		ButtonFlick
			icon='Skills.dmi'
			icon_state="invis"
		LetterInput
			icon_state="LetterBox"
			Click()
				if(src.name=="LetterInput")	return
				if(length(usr.InputVariable)>=41)	return
				if(src.name=="Backspace")
					usr.InputVariable=copytext(usr.InputVariable,1,length(usr.InputVariable))
				else	if(src.name=="Space")
					if(usr.InputVariable)	usr.InputVariable="[usr.InputVariable] "
				else	usr.InputVariable="[usr.InputVariable][src.name]"
				usr.KeyboardLine()
		Quincy
			ArrowType
				icon='QuincySkills.dmi'
				icon_state="Spirit Arrow"
				screen_loc="7,18"
				Click()
					var/ypos=17
					PlayMenuSound(usr,'menu.wav')
					usr.WriteLine(9,0,17,12,"ArrowNames","",1)
					if(src.icon_state=="Selecting Skill")
						src.icon_state=usr.ArrowType
						for(var/obj/HUD/Quincy/Arrow_Display/D in usr.client.screen)
							del D
					else
						src.icon_state="Selecting Skill"
						for(var/obj/Skills/S in usr.Skills)
							if(S.SkillType=="Passive Attack")
								usr.client.screen+=new/obj/HUD/Quincy/Arrow_Display(ypos,initial(S.name))
								usr.WriteLine(8,1,ypos,11,"ArrowNames","[initial(S.name)]",0)
								ypos-=1
			Arrow_Display
				icon='QuincySkills.dmi'
				New(var/yo,var/IS)
					src.name=IS
					src.icon_state=IS
					src.screen_loc="7,[yo]"
				Click()
					PlayMenuSound(usr,'menu.wav')
					usr.WriteLine(9,0,17,12,"ArrowNames","",1)
					usr.ArrowType=src.icon_state
					for(var/obj/HUD/Quincy/ArrowType/S in usr.client.screen)	S.icon_state=src.icon_state
					for(var/obj/HUD/Quincy/Arrow_Display/D in usr.client.screen)
						if(D!=src)	del D
					del src
			ArrowStrength
				icon_state="ArrowStr"
				screen_loc="9,18"
			ArrowDistance
				icon_state="ArrowDist"
				screen_loc="11,18"
		A
			icon='Skills.dmi'
			icon_state="A"
			screen_loc="13,18"
			mouse_opacity=0
		CoolDown
			icon='CoolDown.dmi'
			mouse_opacity=0
			var/SkillRef
			New(var/SL,var/SR)
				src.screen_loc=SL;src.SkillRef=SR
		ReportBug
			icon='NewHUD.dmi'
			icon_state="ReportBug"
			screen_loc="15,18"
		TransBugBG
			icon='NewHUD.dmi';layer=21
			icon_state="TransBG"
			screen_loc="15,18 to 18,18"
			Click()
				PlayMenuSound(usr,'OOT_MainMenu_Select.wav')
				usr<<link("http://www.byond.com/members/Falacy/forum")
		Class_Display
			icon='NewHUD.dmi'
			screen_loc="4,19"
			MouseUp(object,location,control)
				PlayMenuSound(usr,'OOT_MainMenu_Select.wav')
				for(var/obj/HUD/CharOptions/O in usr.client.screen)	del O
				var/listy[]=params2list(control)
				usr.client.screen+=new/obj/HUD/CharOptions/PVP_Toggle(4,text2num(listy["icon-x"]),18,text2num(listy["icon-y"]))
				usr.client.screen+=new/obj/HUD/CharOptions/Close(4,text2num(listy["icon-x"]),18,text2num(listy["icon-y"])-18)
			New(var/C)
				src.icon_state="[C]"
				return ..()
		PartyClassOrb
			icon='NewHUD.dmi'
			var/MyX;var/MyY;var/mob/MyMob
			MouseUp(object,location,control)
				PlayMenuSound(usr,'OOT_MainMenu_Select.wav')
				for(var/obj/HUD/CharOptions/O in usr.client.screen)	del O
				usr.LastClicked=src.MyMob
				var.DispOff=0
				var/listy[]=params2list(control)
				usr.client.screen+=new/obj/HUD/CharOptions/Check(MyX,text2num(listy["icon-x"]),MyY-1,text2num(listy["icon-y"]))
				if(usr!=src.MyMob && usr.Party && usr.Party.Members[1]==usr && (src.MyMob in usr.Party.Members))
					DispOff-=18;usr.client.screen+=new/obj/HUD/CharOptions/Kick(MyX,text2num(listy["icon-x"]),MyY-1,text2num(listy["icon-y"])-DispOff)
				DispOff-=18;usr.client.screen+=new/obj/HUD/CharOptions/Leave(MyX,text2num(listy["icon-x"]),MyY-1,text2num(listy["icon-y"])-DispOff)
				DispOff-=18;usr.client.screen+=new/obj/HUD/CharOptions/Close(MyX,text2num(listy["icon-x"]),MyY-1,text2num(listy["icon-y"])-DispOff)
			New(var/NewX,var/NewY,var/mob/M)
				src.MyMob=M
				src.MyX=NewX;src.MyY=NewY
				src.screen_loc="[NewX],[NewY]"
		PartyBG
			icon='NewHUD.dmi';mouse_opacity=0
			icon_state="PartyBG";layer=19.9
			New(var/SX,var/SY)
				if(SX>=4)	src.icon_state="PartyBGR"
				src.screen_loc="[SX],[SY]"
		COUnder1
			layer=25;icon_state="Extend1";pixel_x=-5
		COUnder2
			layer=25;icon_state="Extend2"
			New(var/xo)
				src.pixel_x=2+((xo-4)*6)-5
		PetDropDown
			icon='Skills.dmi';icon_state="DropDown";desc="Description Error!"
			mouse_opacity=2;var/Category="Targets";var/WriteX=3
			MouseEntered()
				usr.WriteLine(3,4,4,12,"GambitDesc","[src.desc]",1)
			MouseExited()
				usr.WriteLine(0,0,0,0,"GambitDesc","",1)
			Click()
				if(usr.Chatting)	return
				PlayMenuSound(usr,'menu.wav')
				usr.WriteLine(0,0,0,0,"Gambits","",1)
				var/FoundSome
				for(var/obj/HUD/PetAISelection/P in usr.client.screen)
					if("[P.Category]"=="[src.Category]")	FoundSome=1
					del P
				if(FoundSome)	return
				var/WriteY=16
				if(src.Category=="PetSelect")
					for(var/mob/Pets/G in usr.Pets)
						WriteY-=1;usr.WriteLine(src.WriteX,4,WriteY,12,"Gambits","[G]",0)
						var/obj/HUD/PetAISelection/P=new(G.name);P.screen_loc="[WriteX],[WriteY]"
						P.Category=src.Category;P.Gambit=G;usr.client.screen+=P
				else
					for(var/datum/Gambits/G in AllGambits)
						if("[G.parent_type]"=="/datum/Gambits/[src.Category]")
							if(src.Category=="Operators" && usr.CurGambit && usr.CurGambit.Variable)
								if(usr.CurGambit.Variable.name=="Has Status Effect" || usr.CurGambit.Variable.name=="Lacks Status Effect")
									return
							if(G.name=="Effect")	continue
							if(src.Category=="VariableTypes" && usr.CurGambit && usr.CurGambit.Variable)
								if(usr.CurGambit.Variable.name=="Stamina" || usr.CurGambit.Variable.name=="Reiatsu")
									if(G.name=="Status Effect")	continue
								else	if(usr.CurGambit.Variable.name=="Has Status Effect" || usr.CurGambit.Variable.name=="Lacks Status Effect")
									if(G.name!="Status Effect")	continue
								else	if(G.name!="Amount")	continue
							WriteY-=1;usr.WriteLine(src.WriteX,4,WriteY,12,"Gambits","[G]",0)
							var/obj/HUD/PetAISelection/P=new(G.name);P.screen_loc="[WriteX],[WriteY]"
							P.Category=src.Category;P.Gambit=G;usr.client.screen+=P
		GambitDropDown
			icon='Skills.dmi';icon_state="DropDown";desc="Description Error!"
			mouse_opacity=2;var/ID=1
			Click()
				if(usr.Chatting)	return
				PlayMenuSound(usr,'menu.wav')
				usr.CurGambit=usr.CurPet.Gambits[src.ID]
				if(!usr.CurGambit)
					usr.CurGambit=new/datum/Gambits/GambitHolder
					usr.CurPet.Gambits[src.ID]=usr.CurGambit
				usr.WriteLine(0,0,0,0,"Gambits","",1)
				usr.WriteLine(0,0,0,0,"GambitDesc","",1)
				for(var/obj/HUD/PetAISelection/P in usr.client.screen)	del P
				usr.client.eye=locate(29,124,2);usr.UpdateGambitScreen(usr.CurGambit)
		PetAISelection
			icon='Skills.dmi';icon_state="BoxL"
			mouse_opacity=2;var/Category="Targets";var/datum/Gambits/Gambit
			New(var/NameL)
				var/obj/O=new;O.icon='Skills.dmi';O.icon_state="BoxM";O.pixel_x=32;src.overlays+=O
				var/Xoff=64;var/Xmax=32
				if(length(NameL)>13)	Xmax=64
				if(length(NameL)>18)	Xmax=96
				while(Xoff<=Xmax)
					var/obj/M=new;M.icon='Skills.dmi';M.icon_state="BoxM";M.pixel_x=Xoff;src.overlays+=M
					Xoff+=32
				var/obj/R=new;R.icon='Skills.dmi';R.icon_state="BoxR";R.pixel_x=Xoff;src.overlays+=R
			MouseEntered()
				usr.WriteLine(3,4,4,12,"GambitDesc","[src.Gambit.desc]",1)
			MouseExited()
				usr.WriteLine(0,0,0,0,"GambitDesc","",1)
			Click()
				if(usr.Chatting)	return
				PlayMenuSound(usr,'menu.wav')
				usr.WriteLine(0,0,0,0,"Gambits","",1)
				usr.WriteLine(0,0,0,0,"GambitDesc","",1)
				for(var/obj/HUD/PetAISelection/P in usr.client.screen)	if(P!=src)	del P
				if(src.Category=="PetSelect")
					usr.client.eye=locate(10,124,2)
					usr.CurPet=src.Gambit
					usr.UpdateFullGambits()
				else	if(usr.CurPet)
					var/datum/Gambits/NewGambit=new src.Gambit.type
					src.invisibility=1
					NewGambit.GetValueInput(usr.CurPet)
					usr.CurGambit.vars["[copytext(src.Category,1,length(src.Category))]"]=NewGambit
					if(src.Category=="Variables")
						usr.CurGambit.Operator=null;usr.CurGambit.VariableType=null
					if(NewGambit.name=="Has Status Effect" || NewGambit.name=="Lacks Status Effect")
						usr.CurGambit.Operator=new/datum/Gambits/Operators/Effect
					usr.UpdateGambitScreen(usr.CurGambit)
				del src
		CharOptions
			layer=30
			New(var/nx,var/nxo,var/ny,var/nyo)
				src.screen_loc="[nx]:[nxo],[ny]:[nyo+1]"
				if(src.icon_state!="PVP")
					src.screen_loc="[nx]:[nxo+5],[ny]:[nyo+1]"
					src.underlays+=new/obj/HUD/COUnder1()
					src.underlays+=new/obj/HUD/COUnder2(length(src.icon_state))
			PVP_Toggle
				icon_state="PVP"
				Click()
					if(usr.PVPWait>0)
						QuestShow(usr,"Cannot Toggle PVP Yet!");return
					usr.PVP=!usr.PVP
					usr.PVPWait=10
					usr.CombatPhase()
					if(usr.PVP)
						usr.overlays+=PVPicon;QuestShow(usr,"PVP Enabled")
					else
						usr.overlays-=PVPicon;QuestShow(usr,"PVP Disabled")
					usr.ClearCharOptions()
			Party
				icon_state="Party"
				Click()
					if(usr.LastClicked)	usr.PartyInvite(usr.LastClicked)
					usr.ClearCharOptions()
			Leave
				icon_state="Leave"
				Click()
					usr.LeaveParty()
					usr.ClearCharOptions()
			Follow
				icon_state="Follow"
				Click()
					if(usr.LastClicked)	walk_to(usr,usr.LastClicked,1,2)
					usr.ClearCharOptions()
			Name
				icon_state="Name"
				Click()
					if(usr.LastClicked && (usr.LastClicked in usr.Pets))
						var/mob/ThisClicked=usr.LastClicked
						ThisClicked.name=copytext(html_encode(input("Input the new name for your pet:","Change Pet Name",ThisClicked.name)as text),1,25)
						if(ThisClicked)	ThisClicked.AddName()
					if(usr)	usr.ClearCharOptions()
			Duel
				icon_state="Duel"
				Click()
					if(usr.LastClicked)
						var/mob/M=usr.LastClicked
						if(M.PendingRequest)	{QuestShow(usr,"[M] already Pending an Invite");goto ClearSpot}
						if(M.Chatting)	{QuestShow(usr,"[M] is not Currently Available");goto ClearSpot}
						if(M.PVPingAgainst)	{QuestShow(usr,"[M] is Dueling [M.PVPingAgainst]");goto ClearSpot}
						if(MyGetDist(usr,M)>9)	{QuestShow(usr,"[M] has left the area");goto ClearSpot}
						QuestShow(usr,"Challenge Sent to [M]")
						M.PendingRequest=new/obj/Supplemental/DuelNotice(usr,M)
						M.client.screen+=M.PendingRequest;M.WriteLine(2,0,13,8,"DuelNotice","PVP Challenge from [usr.name]",1)
					ClearSpot;usr.ClearCharOptions()
			Sync
				icon_state="Sync"
				Click()
					//do level sync stuff
					usr.ClearCharOptions()
			Check
				icon_state="Check"
				Click()
					if(!usr.LastClicked)	return
					usr.CheckPlayer(usr.LastClicked)
					usr.ClearCharOptions()
			Kick
				icon_state="Kick"
				Click()
					if(!usr.LastClicked)	return
					usr.LastClicked.LeaveParty();QuestShow(usr.LastClicked,"Kicked from Party by [usr]")
					usr.ClearCharOptions()
			Close
				icon_state="Close"
				Click()
					usr.ClearCharOptions()

		Level_Display
			screen_loc="4:16,19:-16"
			icon_state="LevelDisplay"
		HotKeyDisplay
			screen_loc="19,16"
			Click()
				PlayMenuSound(usr,'menu.wav')
				usr.ExtendedHotKeys=!usr.ExtendedHotKeys
				if(usr.ExtendedHotKeys)	usr.FullHotKeys()
				else	usr.CloseHotKeys()
			New(var/IS="HotKey")
				src.icon_state="[IS]"
				src.layer+=1
		Selected_HotKey
			icon='UniversalSkills.dmi'
			icon_state="Selecting Skill"
			var/KeyID
			Click()
				usr.UseSkillProc(src.icon_state)
			New(var/yo=16,var/fo,var/IS)
				src.KeyID=fo
				src.overlays+=new/obj/HUD/HotKeyDisplay(src.KeyID)
				src.icon_state="[IS]"
				screen_loc="19,[yo]"
		Selected_Skill
			icon='Skills.dmi'
			icon_state="Selected Skill"
			screen_loc="13,18"
			Click()
				PlayMenuSound(usr,'menu.wav')
				usr.WriteLine(9,0,17,12,"SkillNames","",1)
				if(src.icon_state=="Selecting Skill")
					src.icon_state=usr.CurSkill
					for(var/obj/HUD/SkillListTypes/D in usr.client.screen)	del D
					for(var/obj/HUD/Skill_Display/D in usr.client.screen)	del D
				else
					var/OtherCats=0
					if(usr.Kidous.len>0)
						OtherCats+=1;usr.client.screen+=new/obj/HUD/SkillListTypes/ArtsList(OtherCats)
						usr.WriteLine(14,1,17-OtherCats,11,"SkillNames","Arts",0)
					if(usr.Spells.len>0)
						OtherCats+=1;usr.client.screen+=new/obj/HUD/SkillListTypes/SpellList(OtherCats)
						usr.WriteLine(14,1,17-OtherCats,11,"SkillNames","Spells",0)
					if(usr.ShikaiSkills.len>0)
						OtherCats+=1;usr.client.screen+=new/obj/HUD/SkillListTypes/SpecialSkillList(OtherCats,usr.ShikaiSkills,"ShikaiBut")
						usr.WriteLine(14,1,17-OtherCats,11,"SkillNames","Shikai Skills",0)
					if(usr.BankaiSkills.len>0)
						OtherCats+=1;usr.client.screen+=new/obj/HUD/SkillListTypes/SpecialSkillList(OtherCats,usr.BankaiSkills,"BankaiBut")
						usr.WriteLine(14,1,17-OtherCats,11,"SkillNames","Bankai Skills",0)
					if(usr.FinalFormSkills.len>0)
						OtherCats+=1;usr.client.screen+=new/obj/HUD/SkillListTypes/SpecialSkillList(OtherCats,usr.FinalFormSkills,"FinalFormBut")
						usr.WriteLine(14,1,17-OtherCats,11,"SkillNames","Final Form Skills",0)
					src.icon_state="Selecting Skill"
					usr.client.screen+=new/obj/HUD/SkillListTypes/SkillList
					usr.WriteLine(14,1,17,11,"SkillNames","Skills",0)

		SkillListTypes
			New(var/YO=0)
				src.screen_loc="13,[17-YO]"
				return ..()
			SkillList
				icon='Skills.dmi'
				icon_state="SkillBut"
				screen_loc="13,17"
				Click()
					var/ypos=17
					PlayMenuSound(usr,'menu.wav')
					usr.WriteLine(14,1,ypos,11,"SkillNames","",1)
					for(var/obj/HUD/SkillListTypes/D in usr.client.screen)	if(D!=src)	del D
					for(var/obj/Skills/S in usr.Skills)
						if(S in usr.ShikaiSkills)	continue
						if(S in usr.BankaiSkills)	continue
						if(S in usr.FinalFormSkills)	continue
						if(S.SkillType=="Attack"||S.SkillType=="Active"||S.SkillType=="Support")
							usr.client.screen+=new/obj/HUD/Skill_Display(ypos,initial(S.name),S.icon)
							usr.WriteLine(14,1,ypos,11,"SkillNames","[initial(S.name)]",0)
							ypos-=1
					del src
			ArtsList
				icon='Skills.dmi'
				icon_state="ArtsBut"
				screen_loc="13,16"
				Click()
					var/ypos=17
					PlayMenuSound(usr,'menu.wav')
					usr.WriteLine(14,1,ypos,11,"SkillNames","",1)
					for(var/obj/HUD/SkillListTypes/D in usr.client.screen)	if(D!=src)	del D
					for(var/obj/Kidous/S in usr.Kidous)
						usr.client.screen+=new/obj/HUD/Skill_Display(ypos,initial(S.name),S.icon)
						usr.WriteLine(14,1,ypos,11,"SkillNames","[initial(S.name)]",0)
						ypos-=1
					del src
			SpellList
				icon='Spells.dmi'
				icon_state="SpellBut"
				screen_loc="13,14"
				Click()
					var/ypos=17
					PlayMenuSound(usr,'menu.wav')
					usr.WriteLine(14,1,ypos,11,"SkillNames","",1)
					for(var/obj/HUD/SkillListTypes/D in usr.client.screen)	if(D!=src)	del D
					for(var/obj/Spells/S in usr.Spells)
						if(S.SkillType=="Knowledge")
							usr.client.screen+=new/obj/HUD/SkillListTypes/Knowledge(ypos,initial(S.name),S.icon)
							usr.WriteLine(14,1,ypos,11,"SkillNames","[initial(S.name)]",0)
							ypos-=1
					del src
			Knowledge
				var/SkillType
				New(var/ypos,var/NewIS,var/NewIcon)
					src.icon=NewIcon;src.icon_state=NewIS
					src.SkillType=NewIS;src.screen_loc="13,[ypos]"
				Click()
					var/ypos=17
					PlayMenuSound(usr,'menu.wav')
					usr.WriteLine(14,1,ypos,11,"SkillNames","",1)
					for(var/obj/HUD/SkillListTypes/D in usr.client.screen)	if(D!=src)	del D
					for(var/obj/Spells/S in usr.Spells)
						if(S.SkillType==src.SkillType)
							usr.client.screen+=new/obj/HUD/Skill_Display(ypos,initial(S.name),S.icon)
							usr.WriteLine(14,1,ypos,11,"SkillNames","[initial(S.name)]",0)
							ypos-=1
					del src
			SpecialSkillList
				icon='Skills.dmi'
				screen_loc="13,15"
				var/list/ThisList=list()
				New(var/YO,var/list/List,var/IS)
					src.ThisList=List;src.icon_state="[IS]"
					src.screen_loc="13,[17-YO]"
				Click()
					var/ypos=17
					PlayMenuSound(usr,'menu.wav')
					usr.WriteLine(14,1,ypos,11,"SkillNames","",1)
					for(var/obj/HUD/SkillListTypes/D in usr.client.screen)	if(D!=src)	del D
					for(var/obj/Skills/S in src.ThisList)
						if(S.SkillType=="Attack"||S.SkillType=="Active"||S.SkillType=="Support")
							usr.client.screen+=new/obj/HUD/Skill_Display(ypos,initial(S.name),S.icon)
							usr.WriteLine(14,1,ypos,11,"SkillNames","[initial(S.name)]",0)
							ypos-=1
					del src
		Skill_Display
			icon='Skills.dmi'
			New(var/yo,var/IS,var/IC)
				src.name=IS
				src.icon=IC
				src.mouse_drag_pointer=IS
				src.icon_state=IS
				src.screen_loc="13,[yo]"
			Click()
				PlayMenuSound(usr,'menu.wav')
				usr.WriteLine(9,0,17,12,"SkillNames","",1)
				usr.CurSkill=src.icon_state
				for(var/obj/HUD/CoolDown/C in usr.client.screen)	if(C.screen_loc=="13,18")
					C.SkillRef=src.icon_state;C.icon_state=""
				for(var/obj/HUD/Selected_Skill/S in usr.client.screen)
					S.icon_state=src.icon_state;S.icon=src.icon
				for(var/obj/HUD/Skill_Display/D in usr.client.screen)
					if(D!=src)	del D
				del src
		World_Map
			icon='NewHUD.dmi'
			icon_state="WorldMap"
			screen_loc="19,19"
			Click()
				if(usr.InventoryOpen)	usr.ClearInventory()
				usr.ViewMap()
		Mail_System
			icon='NewHUD.dmi'
			icon_state="MailSystem"
			screen_loc="18,19"
			Click()	usr.ShowBL()
		InventoryToggle
			icon='NewHUD.dmi'
			icon_state="InventoryToggle"
			screen_loc="19,18"
			Click()
				PlayMenuSound(usr,'menu.wav')
				if(usr.InventoryOpen)	usr.ClearInventory()
				else	usr.DisplayInventory()
		ExpOrb
			icon='NewExpOrb.dmi'
			icon_state="0"
			screen_loc="5,19"
			layer=19
			Click()
				var/HtmlText="<title>Exp Log</title><body bgcolor=black>"
				HtmlText+="<center><table bgcolor=black bordercolor=yellow border=1>"
				HtmlText+="<tr><td><center><b><font color=green>"
				HtmlText+="[usr.Exp] / [usr.Nexp]<br>"
				HtmlText+="[round(usr.Exp/usr.Nexp*100)]% EXP | [usr.Nexp-usr.Exp] TNL"
				for(var/x in usr.ExpLog)
					HtmlText+="<tr><td><b><font color=green>[x]"
				HtmlText+="</table>"
				usr<<browse(HtmlText,"window=GenericBrowser")
		QuestOrb
			icon='NewHUD.dmi'
			icon_state="QuestOrb"
			screen_loc="16,19"
			Click()
				usr.ShowQuestLog()
		LevelOrb
			icon='NewHUD.dmi'
			icon_state="LvlOrb"
			screen_loc="15,19"
			Click()
				if(usr.Chatting)	return
				if(usr.InventoryOpen)	usr.ClearInventory()
				if(usr.client.eye!=usr)
					usr.invisibility=0
					usr.OnLevelScreen=0
					PlayMenuSound(usr,'OOT_MainMenu_Cancel.wav')
					for(var/obj/HUD/UnLearned_Skill/O in usr.client.screen)	usr.client.screen-=O
					usr.WriteLine(0,0,0,0,"SkillPoints","",1)
					usr.client.eye=usr
					usr.HUD()
					return
				if(usr.RegenWait>=0)	{QuestShow(usr,"Cannot Access During Combat");return}
				if(usr.PVP)	{QuestShow(usr,"Cannot Access During PVP");return}
				if(usr.Arena)	{QuestShow(usr,"Cannot Access Inside Arena");return}
				usr.invisibility=1
				usr.OnLevelScreen=1
				usr<<browse(null,"window=Quests")
				for(var/O in usr.client.screen)
					if(!istype(O,/obj/Items)&&O!=src)	usr.client.screen-=O
					else	usr.client.screen-=src
				PlayMenuSound(usr,'OOT_MainMenu_Select.wav')
				if(usr.Class=="Bount")	usr.client.eye=locate(48,124,2)
				if(usr.Class=="Quincy")	usr.client.eye=locate(10,29,2)
				if(usr.Class=="Soul Reaper")	usr.client.eye=locate(29,29,2)
				usr.LoadSkillTree()
				if(src in usr.client.screen)	usr.client.screen-=src
		UnLearned_Skill
			icon='Skills.dmi'
			icon_state="UnLearned"
			mouse_opacity=0
			New(nx,ny)
				src.screen_loc="[nx],[ny]"
		CharPreview
			icon='School.dmi'
			screen_loc="5,9"
		HairPreview
			screen_loc="5,9:9"
		MainHUD
			name=""
			icon='NewHUD.dmi'
			New(var/xx,var/yy)
				src.icon_state="T"
				if(yy==18)	src.icon_state="B"
				if(xx==6)	src.icon_state="[src.icon_state]L"
				if(xx==14)	src.icon_state="[src.icon_state]R"
				screen_loc="[xx],[yy]"
		HudBar
			icon='NewHUD.dmi'
			New(var/x1=7,var/y1=19,var/x2=13,var/y2=19,var/IS="hudbar")
				src.icon_state=IS
				screen_loc = "[x1],[y1] to [x2],[y2]"
		HudBarEdge
			icon='NewHUD.dmi'
			New(var/xo=14,var/yo=19,var/IS="hudbarR")
				src.icon_state=IS
				screen_loc = "[xo],[yo]"
		BarText
			icon='HudText.dmi'
			name="Stats"
			New(var/hudx,var/hudxpix,var/hudy,var/hudypix,var/IS,var/ID)
				src.name=ID
				src.layer+=2
				src.icon_state=IS
				src.screen_loc = "[hudx]:[hudxpix],[hudy]:[hudypix]"
		ComboSysHud
			icon='ComboSysHud.dmi'
			icon_state="Hit"
			screen_loc="8,18"
			New(var/Numbar)
				if(isnum(Numbar))
					src.icon_state="No"
					src.screen_loc="7,18"
		StmBar
			icon='STM.dmi'
			layer=3
			pixel_y=-19
		ReiBar
			icon='REI.dmi'
			layer=3
			pixel_y=-19
		Supplemental
			icon='HudText.dmi'
			New(hudx,hudxpix,hudy,hudypix,letter)
				src.icon_state=letter
				src.screen_loc="[hudx]:[hudxpix],[hudy]:[hudypix]"

mob/proc/CoolDownSystem(/**/)
	for(var/obj/O in src.Skills+src.Kidous+src.Spells)
		if(O:CoolDown)
			//O:CoolDown=max(0,O:CoolDown-2)
			O:CoolDown-=1
			for(var/obj/HUD/CoolDown/C in src.client.screen)
				if(C.SkillRef==O:name)	C.icon_state="[round(117-(O:CoolDown/O:MaxCoolDown*116),1)]"
	spawn(1)	src.CoolDownSystem()

mob/proc/UpdateFullGambits()
	src.WriteLine(0,0,0,0,"GambitDetails","",1)
	if(!src.CurPet)	return
	for(var/i=1;i<=5;i++)	if(src.CurPet.Gambits[i])
		var/datum/Gambits/GambitHolder/G=src.CurPet.Gambits[i]
		src.WriteLine(3,2,19-3*i,12,"GambitDetails","[copytext("[G.Target]",1,14)]",0)
		src.WriteLine(6,2,19-3*i,12,"GambitDetails","[copytext("[G.Variable]",1,14)]",0)
		src.WriteLine(9,2,19-3*i,12,"GambitDetails","[copytext("[G.Operator]",1,14)]",0)
		var/ValueTag=(G.VariableType ? "[G.VariableType.Value] " : "")
		var/VT2;if(G.VariableType && G.VariableType.name=="Percent")	VT2="%"
		src.WriteLine(12,2,19-3*i,12,"GambitDetails","[copytext("[ValueTag][VT2]",1,14)]",0)
		src.WriteLine(15,2,19-3*i,12,"GambitDetails","[copytext("[G.Action]",1,14)]",0)

mob/proc/UpdateGambitScreen(var/datum/Gambits/GambitHolder/G)
	src.WriteLine(0,0,0,0,"GambitDetails","",1)
	if(!istype(G,/datum/Gambits/GambitHolder))	return
	src.WriteLine(3,2,16,12,"GambitDetails","[copytext("[G.Target]",1,9)]",0)
	src.WriteLine(6,2,16,12,"GambitDetails","[copytext("[G.Variable]",1,9)]",0)
	src.WriteLine(9,2,16,12,"GambitDetails","[copytext("[G.Operator]",1,9)]",0)
	var/ValueTag=(G.VariableType ? "[G.VariableType.Value] " : "")
	var/VT2;if(G.VariableType && G.VariableType.name=="Percent")	VT2="%"
	src.WriteLine(12,2,16,12,"GambitDetails","[copytext("[ValueTag][VT2]",1,9)]",0)
	src.WriteLine(15,2,16,12,"GambitDetails","[copytext("[G.Action]",1,9)]",0)

mob/proc/ClearHUD(/**/)
	if(!src.client || src.Chatting)	return
	if(usr.InventoryOpen)	usr.ClearInventory()
	for(var/x in src.client.screen)	del x
	for(var/datum/LowCpuHudDatum/D in src.LowCpuHuds)	D.Delete()
	src.client.screen=initial(src.client.screen)

mob/proc/HUD(/**/)
	src.ClearHUD()
	src.client.screen+=new/obj/HUD/ExpOrb
	src.client.screen+=new/obj/HUD/LevelOrb
	src.client.screen+=new/obj/HUD/QuestOrb
	src.client.screen+=new/obj/HUD/ReportBug
	src.client.screen+=new/obj/HUD/World_Map
	src.client.screen+=new/obj/HUD/TransBugBG
	src.client.screen+=new/obj/HUD/Mail_System
	src.client.screen+=new/obj/HUD/InventoryToggle
	src.client.screen+=new/obj/HUD/ButtonFlick
	src.WriteLine(15,27,18,12,"ReportBug","Report a Bug",1)
	var/xpos=6;var/ypos=19//MainHUD BG!
	while(xpos<=14)
		src.client.screen+=new/obj/HUD/MainHUD(xpos,ypos)
		xpos+=1
		if(xpos==15&&ypos==19)	{xpos=6;ypos=18}
	//src.client.screen+=new/obj/HUD/HudBarEdge(19,9,"hudbarT")//Equipment
	//src.client.screen+=new/obj/HUD/HudBar(19,8,19,4,"hudbarV")
	//src.client.screen+=new/obj/HUD/HudBarEdge(19,3,"hudbarB")
	src.FullHotKeys()
	src.client.screen+=new/obj/HUD/Selected_Skill
	src.client.screen+=new/obj/HUD/CoolDown("13,18",src.CurSkill)
	src.client.screen+=new/obj/HUD/A
	var/obj/HUD/Class_Display/CD=new(src.Class)
	src.ClassOrb=CD;src.client.screen+=CD
	src.client.screen+=new/obj/HUD/Level_Display
	src.LevelDisplay()

	src.client.screen+=new/obj/HUD/Supplemental(7,0,19,8,"S")
	src.CreateHUDText(8,5,19,8,"STM")
	src.client.screen+=new/obj/HUD/Supplemental(9,8,19,8,"/")
	src.CreateHUDText(9,15,19,8,"MaxSTM")
	src.client.screen+=new/obj/HUD/Supplemental(11,0,19,8,"R")
	src.CreateHUDText(12,5,19,8,"REI")
	src.client.screen+=new/obj/HUD/Supplemental(13,8,19,8,"/")
	src.CreateHUDText(13,15,19,8,"MaxREI")
	src.StmBar()
	src.ReiBar()
	src.MailUpdate()
	for(var/obj/HUD/Selected_Skill/S in src.client.screen)
		S.icon_state=src.CurSkill
		for(var/obj/Skills/X in src.Skills)	if(X.name==S.icon_state)	S.icon=X.icon
		for(var/obj/Kidous/X in src.Kidous)	if(X.name==S.icon_state)	S.icon=X.icon
		for(var/obj/Spells/X in src.Spells)	if(X.name==S.icon_state)	S.icon=X.icon
	for(var/obj/HUD/ExpOrb/O in src.client.screen)
		O.icon_state="[src.GetExpBar()]"
	if(src.StatPoints>=1 || src.SkillPoints>=1 || src.TraitPoints>=1)
		for(var/obj/HUD/LevelOrb/O in src.client.screen)
			O.icon_state="LvlFlash"
	if(src.Class=="Soul Reaper")
		src.client.screen+=new/obj/HUD/ComboSysHud(0)
		src.client.screen+=new/obj/HUD/ComboSysHud
	//setup bount hud - pet display
	if(src.Class=="Quincy")
		src.client.screen+=new/obj/HUD/Quincy/ArrowType
		src.client.screen+=new/obj/HUD/Quincy/ArrowStrength
		src.client.screen+=new/obj/HUD/Quincy/ArrowDistance
		src.CreateHUDText(10,-2,18,8,"ArrowStr")
		src.CreateHUDText(12,-2,18,8,"ArrowDist")
		for(var/obj/HUD/Quincy/ArrowType/S in src.client.screen)
			S.icon_state=src.ArrowType
	src.UpdateStatusEffects()
	src.UpdatePartyHUD()
	src.TrackQuests()
	src.HUDRefresh()
	src.ArrowHUD()

mob/proc/CloseHotKeys()
	for(var/obj/HUD/HudBar/S in src.client.screen)	S.screen_loc="19,16"
	for(var/obj/HUD/HudBarEdge/S in src.client.screen)
		if(S.icon_state=="hudbarB")	S.screen_loc="19,15"
	for(var/obj/HUD/CoolDown/S in src.client.screen)	if(S.screen_loc!="13,18")	del S
	for(var/obj/HUD/Selected_HotKey/S in src.client.screen)	del S

mob/proc/FullHotKeys()
	for(var/obj/HUD/HudBar/S in src.client.screen)	del S
	for(var/obj/HUD/HudBarEdge/S in src.client.screen)	del S
	for(var/obj/HUD/HotKeyDisplay/S in src.client.screen)	del S
	src.client.screen+=new/obj/HUD/HudBarEdge(19,17,"hudbarT")//Hot Keys
	src.client.screen+=new/obj/HUD/HudBar(19,16,19,7,"hudbarV")
	src.client.screen+=new/obj/HUD/HudBarEdge(19,6,"hudbarB")
	src.client.screen+=new/obj/HUD/HotKeyDisplay
	for(var/i=15,i>6,i-=1)
		src.client.screen+=new/obj/HUD/Selected_HotKey(i,16-i,src.HotKeys[16-i])
		src.client.screen+=new/obj/HUD/CoolDown("19,[i]",src.HotKeys[16-i])
	for(var/obj/HUD/Selected_HotKey/S in src.client.screen)
		S.mouse_drag_pointer=S.icon_state
		for(var/obj/Skills/X in src.Skills)	if(X.name==S.icon_state)	S.icon=X.icon
		for(var/obj/Kidous/X in src.Kidous)	if(X.name==S.icon_state)	S.icon=X.icon
		for(var/obj/Spells/X in src.Spells)	if(X.name==S.icon_state)	S.icon=X.icon

mob/proc/LevelDisplay()
	var/offset=28
	if(src.Level>=10)	offset-=4
	if(src.Level>=100)	offset-=4
	if(src.Level>=1000)	offset-=4
	src.WriteLine(4,offset,19,-2,"LevelDisplay","[src.Level]",1)

mob/proc/HUDRefresh()
	src.UpdateHUDText("MaxSTM")
	src.UpdateHUDText("MaxREI")

mob/proc/ArrowHUD()
	if(src.Class=="Quincy")
		src.UpdateHUDText("ArrowStr")
		src.UpdateHUDText("ArrowDist")
mob/proc/StmBar(/**/)
	if(!src.StmBar)	src.StmBar=new/obj/HUD/StmBar
	var/IS="[round(src.STM/src.MaxSTM*32,1)]"
	if(src.StmBar.icon_state!=IS)
		src.overlays-=src.StmBar
		src.StmBar.icon_state=IS
		src.overlays+=src.StmBar
	if(src.client)
		//src.UpdateHUD(7,0,19,8,"S","Stamina")
		src.UpdateHUDText("STM")
mob/proc/ReiBar(/**/)
	if(!src.ReiBar)	src.ReiBar=new/obj/HUD/ReiBar
	var/IS="[round(src.REI/src.MaxREI*32,1)]"
	var/pix_y=-19
	if(!src.StmBar || src.StmBar.icon_state=="32")	pix_y+=4
	if(src.ReiBar.icon_state!=IS || src.ReiBar.pixel_y!=pix_y)
		src.overlays-=src.ReiBar
		src.ReiBar.pixel_y=pix_y
		src.ReiBar.icon_state=IS
		src.overlays+=src.ReiBar
	if(src.client)
		//src.UpdateHUD(11,0,19,8,"R","Reiatsu")
		//src.UpdateHUD(12,5,19,8,"[src.REI]/[src.MaxREI]","REI")
		src.UpdateHUDText("REI")