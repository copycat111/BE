client
	Del()
		for(var/I in src.images)	del I
		for(var/O in src.screen)
			if(!istype(O,/obj/Items))	del O
		if(src.mob)
			src.mob.Save()
			src.mob.LoggedOn=0
			src.mob.SaveLogonFile()
			src.mob.SavePlayerConfig()
			for(var/mob/Pets/P in src.mob.Pets)	del P
		return ..()

mob/var/LastX
mob/var/LastY
mob/var/LastZ

proc/FileExists(var/FE)
	if(fexists("Players/[copytext(ckey(FE),1,2)]/[FE].sav"))	return 1
	else	return 0
	//return	world.Export("byond://166.82.8.113:4440?FileExists[FE]")

mob/verb/SaveVerb()
	set hidden=1
	if(src.z==2)	return
	if(!usr.CanSave)
		usr<<"You can only save once every 5 Minutes."
		usr<<"The game will automaticaly save when you logout."
		return
	usr.CanSave=0
	usr.Save()
	usr<<"Game Saved"
	spawn(3000)	if(usr)	usr.CanSave=1

mob/proc
	SaveLogonFile()
		if(fexists("Logons/[ckey(src.key)].txt"))
			fdel("Logons/[ckey(src.key)].txt")
		var/savefile/F = new("Logons/[ckey(src.key)].txt")
		F["LoggedOn"]<<src.LoggedOn
	LoadLogonFile()
		if(fexists("Configs/[ckey(src.key)].txt"))
			var/savefile/F = new("Logons/[ckey(src.key)].txt")
			F["LoggedOn"]>>src.LoggedOn
		else
			src.SaveLogonFile()

	SavePlayerConfig()
		if(fexists("Configs/[ckey(src.key)].txt"))
			fdel("Configs/[ckey(src.key)].txt")
		var/savefile/F = new("Configs/[ckey(src.key)].txt")
		F["MusicVol"]<<src.MusicVol
		F["EffectVol"]<<src.EffectVol
		F["VoiceVol"]<<src.VoiceVol
		F["MenuVol"]<<src.MenuVol
		F["PMVol"]<<src.PMVol
		F["ExpDisplay"]<<src.ExpDisplay
		F["FontColor"]<<src.FontColor
		F["FontFace"]<<src.FontFace
		F["LoopMusic"]<<src.LoopMusic
		F["AllowPMs"]<<src.AllowPMs
	LoadPlayerConfig()
		if(fexists("Configs/[ckey(src.key)].txt"))
			var/savefile/F = new("Configs/[ckey(src.key)].txt")
			F["MusicVol"]>>src.MusicVol
			F["EffectVol"]>>src.EffectVol
			F["VoiceVol"]>>src.VoiceVol
			F["MenuVol"]>>src.MenuVol
			F["PMVol"]>>src.PMVol
			F["ExpDisplay"]>>src.ExpDisplay
			F["FontColor"]>>src.FontColor
			F["FontFace"]>>src.FontFace
			F["LoopMusic"]>>src.LoopMusic
			F["AllowPMs"]>>src.AllowPMs
			if(src.AllowPMs==null)	src.AllowPMs=1
			if(src.MenuVol==null)	src.MenuVol=100
			if(src.VoiceVol==null)	src.VoiceVol=100
			if(src.PMVol==null)	src.PMVol=100
			if(!src.FontColor)	src.FontColor=initial(src.FontColor)
			if(!src.FontFace)	src.FontFace=initial(src.FontFace)
		else
			//spawn()	ShowAlert(src,"Welcome, [src.name]! > > We hope you enjoy your experience here on Bleach Eternity 2",list("Click"))
			src.SavePlayerConfig()

	Save()
		if(src.z==2)	return
		if(src.x==0 || src.y==0 || src.z==0)	src.loc=locate(169,32,3)
		for(var/obj/Skills/S in src.Skills)	S.overlays=initial(S.overlays)
		for(var/obj/Kidous/K in src.Kidous)	K.overlays=initial(K.overlays)
		for(var/obj/Spells/S in src.Spells)	S.overlays=initial(S.overlays)
		for(var/obj/I in src.Inventory)	I.overlays=initial(I.overlays)
		//Hack Detection
		/*var/Hacks=0
		if(LHD!=round((src.Level*3+7)/6))	Hacks+=1
		if(src.Nexp<100*src.Level)	Hacks+=1	//bugged with prodigy probably
		if(src.MaxSTM>300+100*src.Level)	Hacks+=1
		if(src.MaxREI>200+100*src.Level)	Hacks+=1
		if(src.STR>10*src.Level)	Hacks+=1
		if(src.STR>10*src.Level)	Hacks+=1
		if(src.STR>10*src.Level)	Hacks+=1
		if(src.STR>10*src.Level)	Hacks+=1
		if(Hacks!=0)
			world.log<<"[src.key]'s Character [src.name] has been Marked for Character Altering"
			src<<"Character Alterations Detected.  Character will not be Saved!";return*/
		if(fexists("Players/[copytext(ckey(src.key),1,2)]/[ckey(src.key)][src.SaveSlot].sav"))
			fdel("Players/[copytext(ckey(src.key),1,2)]/[ckey(src.key)][src.SaveSlot].sav")
		var/savefile/F = new("Players/[copytext(ckey(src.key),1,2)]/[ckey(src.key)][src.SaveSlot].sav")
		F["SaveVersion"]<<GameVersion
		F["LastX"]<<src.x
		F["LastY"]<<src.y
		F["LastZ"]<<src.z
		F["HairR"]<<src.HairR
		F["HairG"]<<src.HairG
		F["HairB"]<<src.HairB
		F["name"]<<src.name
		F["Level"]<<src.Level
		F["REI"]<<src.REI
		F["MaxREI"]<<src.MaxREI
		F["STM"]<<src.STM
		F["MaxSTM"]<<src.MaxSTM
		F["STR"]<<src.STR
		F["VIT"]<<src.VIT
		F["MGC"]<<src.MGC
		F["MGCDEF"]<<src.MGCDEF
		F["AGI"]<<src.AGI
		F["LCK"]<<src.LCK
		F["Gold"]<<src.Gold
		F["Silver"]<<src.Silver
		F["Copper"]<<src.Copper
		F["Exp"]<<src.Exp
		F["Nexp"]<<src.Nexp
		F["Deaths"]<<src.Deaths
		F["Kills"]<<src.Kills
		F["Honor"]<<src.Honor
		F["PvpKills"]<<src.PvpKills
		F["PvpDeaths"]<<src.PvpDeaths
		F["Class"]<<src.Class
		F["ClassLevel"]<<src.ClassLevel
		F["Skills"]<<src.Skills
		F["Kidous"]<<src.Kidous
		F["Spells"]<<src.Spells
		F["ComboList"]<<src.ComboList
		F["StatPoints"]<<src.StatPoints
		F["TraitPoints"]<<src.TraitPoints
		F["SkillPoints"]<<src.SkillPoints
		F["StatusEffects"]<<src.StatusEffects
		F["HairStyle"]<<src.HairStyle
		F["TutLevel"]<<src.TutLevel
		F["DodgeBonus"]<<src.DodgeBonus
		F["CritBonus"]<<src.CritBonus
		F["StmRegenBonus"]<<src.StmRegenBonus
		F["ReiRegenBonus"]<<src.ReiRegenBonus
		F["StmRegenCost"]<<src.StmRegenCost
		F["ImmunityBonus"]<<src.ImmunityBonus
		F["ArrCreateSpd"]<<src.ArrCreateSpd
		F["DistChargeSpd"]<<src.DistChargeSpd
		F["GuardBonus"]<<src.GuardBonus
		F["CounterBonus"]<<src.CounterBonus
		F["DoubleStrikeBonus"]<<src.DoubleStrikeBonus
		F["ShieldBonus"]<<src.ShieldBonus
		F["RespawnX"]<<src.RespawnX
		F["RespawnY"]<<src.RespawnY
		F["RespawnZ"]<<src.RespawnZ
		F["Zanjutsu"]<<src.Zanjutsu
		F["Hakuda"]<<src.Hakuda
		F["Kidou"]<<src.Kidou
		F["Hohou"]<<src.Hohou
		F["Prodigy"]<<src.Prodigy
		F["Training"]<<src.Training
		F["Manual"]<<src.Manual
		F["Income"]<<src.Income
		F["ChestList"]<<src.ChestList
		F["Dir"]<<src.dir
		F["Quests"]<<src.Quests
		F["CompletedQuests"]<<src.CompletedQuests
		F["CurSkill"]<<src.CurSkill
		F["ArrowType"]<<src.ArrowType
		F["SkillDmg"]<<src.SkillDmg
		F["SkillRei"]<<src.SkillRei
		F["HotKeys"]<<src.HotKeys
		F["VoiceSet"]<<src.VoiceSet
		F["Beastiary"]<<src.Beastiary
		F["PlayTime"]<<src.PlayTime
		F["Inventory"]<<src.Inventory
		F["ArenaRound"]<<src.ArenaRound
		F["ArenaBonus"]<<src.ArenaBonus
		F["RespecUses"]<<src.RespecUses
		F["BarberUses"]<<src.BarberUses
		F["Head"]<<src.Head
		F["Body"]<<src.Body
		F["Hand"]<<src.Hand
		F["Back"]<<src.Back
		F["Feet"]<<src.Feet
		F["ClothesR"]<<src.ClothesR
		F["ClothesG"]<<src.ClothesG
		F["ClothesB"]<<src.ClothesB
		F["LevelLog"]<<src.LevelLog
		F["MaxArrowCharges"]<<src.MaxArrowCharges
		F["AutoTargetFace"]<<src.AutoTargetFace
		F["AutoAttackFace"]<<src.AutoAttackFace
		F["AutoSkillFace"]<<src.AutoSkillFace
		for(var/mob/Pets/P in src.Pets)	P.overlays=null
		F["Pets"]<<src.Pets
		for(var/mob/Pets/P in src.Pets)
			P.AddName();P.StmBar();P.ReiBar()
		F["TransLocs"]<<src.TransLocs

		if(src.client.eye!=locate(67,10,2))	F["Zanpakuto"]<<src.Zanpakuto
		F["ZanpakutoOverlays"]<<src.ZanpakutoOverlays
		fcopy(F,"PlayersBackup/[copytext(ckey(src.key),1,2)]/[ckey(src.key)][src.SaveSlot].sav")

		//Used for Global Save
		/*src<<"Saving Game..."
		if(world.Export("byond://166.82.8.113:4440?[ckey(src.key)][src.SaveSlot]",F))	src<<"Game Saved"
		else	src<<"<b><font color=red>Error Contacting Save Server!"
		fdel("Players/[copytext(ckey(src.key),1,2)]/[ckey(src.key)][src.SaveSlot].sav")*/

mob/proc
	Load(var/savefile/F)
		//Used for Global Save
		/*if(!F)
			src<<"Loading Game..."
			F=world.Export("byond://166.82.8.113:4440?Load[ckey(src.key)][src.SaveSlot]")
			return*/

		F = new("Players/[copytext(ckey(src.key),1,2)]/[ckey(src.key)][src.SaveSlot].sav")
		F["SaveVersion"]>>src.SaveVersion
		if(src.SaveVersion<1.2)
			src<<"Your Save file is Too Far out of Date. Please Create a new Character"
			return

		F["LastX"]>>src.LastX
		F["LastY"]>>src.LastY
		F["LastZ"]>>src.LastZ
		F["HairR"]>>src.HairR
		F["HairG"]>>src.HairG
		F["HairB"]>>src.HairB
		F["name"]>>src.name
		F["Level"]>>src.Level
		F["REI"]>>src.REI
		F["MaxREI"]>>src.MaxREI
		F["STM"]>>src.STM
		F["MaxSTM"]>>src.MaxSTM
		F["STR"]>>src.STR
		F["VIT"]>>src.VIT
		F["MGC"]>>src.MGC
		F["MGCDEF"]>>src.MGCDEF
		F["AGI"]>>src.AGI
		F["LCK"]>>src.LCK
		F["Gold"]>>src.Gold
		F["Silver"]>>src.Silver
		F["Copper"]>>src.Copper
		F["Exp"]>>src.Exp
		F["Nexp"]>>src.Nexp
		F["Deaths"]>>src.Deaths
		F["Kills"]>>src.Kills
		F["Honor"]>>src.Honor
		F["PvpKills"]>>src.PvpKills
		F["PvpDeaths"]>>src.PvpDeaths
		F["Class"]>>src.Class
		F["ClassLevel"]>>src.ClassLevel
		F["Skills"]>>src.Skills
		F["Kidous"]>>src.Kidous
		F["Spells"]>>src.Spells
		F["ComboList"]>>src.ComboList
		F["StatPoints"]>>src.StatPoints
		F["TraitPoints"]>>src.TraitPoints
		F["SkillPoints"]>>src.SkillPoints
		F["StatusEffects"]>>src.StatusEffects
		F["HairStyle"]>>src.HairStyle
		F["TutLevel"]>>src.TutLevel
		F["DodgeBonus"]>>src.DodgeBonus
		F["Dir"]>>src.dir
		F["Quests"]>>src.Quests
		F["DodgeBonus"]>>src.DodgeBonus
		F["CritBonus"]>>src.CritBonus
		F["StmRegenBonus"]>>src.StmRegenBonus
		F["ReiRegenBonus"]>>src.ReiRegenBonus
		F["StmRegenCost"]>>src.StmRegenCost
		F["ImmunityBonus"]>>src.ImmunityBonus
		F["ArrCreateSpd"]>>src.ArrCreateSpd
		F["DistChargeSpd"]>>src.DistChargeSpd
		F["GuardBonus"]>>src.GuardBonus
		F["CounterBonus"]>>src.CounterBonus
		F["DoubleStrikeBonus"]>>src.DoubleStrikeBonus
		F["ShieldBonus"]>>src.ShieldBonus
		F["RespawnX"]>>src.RespawnX
		F["RespawnY"]>>src.RespawnY
		F["RespawnZ"]>>src.RespawnZ
		F["Zanjutsu"]>>src.Zanjutsu
		F["Hakuda"]>>src.Hakuda
		F["Hohou"]>>src.Hohou
		F["Kidou"]>>src.Kidou
		F["Prodigy"]>>src.Prodigy
		F["Training"]>>src.Training
		F["Manual"]>>src.Manual
		F["Income"]>>src.Income
		F["ChestList"]>>src.ChestList
		F["CompletedQuests"]>>src.CompletedQuests
		F["ZanpakutoOverlays"]>>src.ZanpakutoOverlays
		F["CurSkill"]>>src.CurSkill
		F["ArrowType"]>>src.ArrowType
		F["SkillDmg"]>>src.SkillDmg
		F["SkillRei"]>>src.SkillRei
		F["Zanpakuto"]>>src.Zanpakuto
		F["HotKeys"]>>src.HotKeys
		F["VoiceSet"]>>src.VoiceSet
		F["Beastiary"]>>src.Beastiary
		F["PlayTime"]>>src.PlayTime
		F["Inventory"]>>src.Inventory
		F["ArenaBonus"]>>src.ArenaBonus
		F["ArenaRound"]>>src.ArenaRound
		F["RespecUses"]>>src.RespecUses
		F["BarberUses"]>>src.BarberUses
		F["Head"]>>src.Head
		F["Body"]>>src.Body
		F["Hand"]>>src.Hand
		F["Back"]>>src.Back
		F["Feet"]>>src.Feet
		src.EquipmentList+=Head
		src.EquipmentList+=Body;src.EquipmentList+=Hand
		src.EquipmentList+=Back;src.EquipmentList+=Feet
		F["ClothesR"]>>src.ClothesR
		F["ClothesG"]>>src.ClothesG
		F["ClothesB"]>>src.ClothesB
		F["LevelLog"]>>src.LevelLog
		F["MaxArrowCharges"]>>src.MaxArrowCharges
		F["Pets"]>>src.Pets
		F["TransLocs"]>>src.TransLocs
		F["AutoTargetFace"]>>src.AutoTargetFace
		F["AutoAttackFace"]>>src.AutoAttackFace
		F["AutoSkillFace"]>>src.AutoSkillFace
		src.SubExpirationCheck()

		src.icon='school.dmi'
		if(src.gender==FEMALE)	src.icon='SchoolFemale.dmi'
		src.LHD=round((src.Level*3+7)/6)
		//src.DamageIcon=src.icon+rgb(255,0,0)
		//src.GuardIcon=src.icon+rgb(155,155,155)
		src.AddName()
		src.LoadVoiceSet()
		src.AddHair(src.HairStyle)
		for(var/obj/Items/Equipment/E in src.EquipmentList)	E.OnEquip(src)
		for(var/datum/StatusEffects/RadialEffects/E in src.StatusEffects)	E.AddOverlays(src)
		src.HUD()
		src.QuestRefresh()
		src.RefreshClothes()
		src.loc=locate(src.LastX,src.LastY,src.LastZ)
		src.invisibility=0
		//src.EnemyStart(EnemyHuntRange,src.loc)
		for(var/obj/Skills/Universal/Flash_Step/S in src.Skills)	src.CanShunpo=1
		for(var/obj/Skills/SoulReaper/Shikai/S in src.Skills)
			if(!src.Zanpakuto)	src.ZanCreation()
		for(var/obj/Skills/Shikais/S in src.Skills)	src.ShikaiSkills+=S
		for(var/obj/Skills/Bankais/S in src.Skills)	src.BankaiSkills+=S
		for(var/obj/Skills/FinalForm/S in src.Skills)	src.FinalFormSkills+=S
		for(var/obj/Items/I in src.Inventory)	I.UpdateCount()
		for(var/mob/Pets/P in src.Pets)
			P.Owner=src;P.AddName()
		src.CreatePlayerIcon()
		src<<"Load Complete"
		src.SaveFixes()
		if(src.SaveVersion<4.9)	return
		while(src && src.invisibility)	sleep(1)
		if(src.ArenaRound)
			src.ArenaRound-=1
			src.ArenaBonus-=1*src.ArenaRound
			spawn()	src.StartArena()
			src<<"Resuming Arena Match..."

mob/proc/SaveFixes()
	if(!src.TransLocs)	src.TransLocs=list()
	if(src.SaveVersion<=9.7 && src.Pets)	while(src.Pets.len>=2)
		for(var/mob/Pets/P in src.Pets)
			src.Pets-=P;del P;break
	if(src.SaveVersion<8.4 && src.RespawnZ!=1)
		src.RespawnX=169
		src.RespawnY=32
		src.RespawnZ=3
		src<<"<b><font color=red>Your Respawn Location has been Reset due to a Recent Update"
	if(src.SaveVersion<9.6)
		for(var/mob/Pets/P in src.Pets)	P.ApplyStats()
	if(src.SaveVersion<11.0)	//Respec
		src.Respec();src.OnLevelScreen=1
		src.ClearHUD()
		if(src.Class=="Quincy")	src.client.eye=locate(10,29,2)
		if(src.Class=="Bount")	src.client.eye=locate(48,124,2)
		if(src.Class=="Soul Reaper")	src.client.eye=locate(29,29,2)
		src.invisibility=1;src.LoadSkillTree()
		ShowAlert(src,"Your Character has been Respecced due to a Recent Update. > Use this time to ReAllocate your Points. \
			> > Note: If you hold Shift when distributing Stat and/or Trait points you can use up to 10 points at once.")
	if(src.AutoTargetFace==null)
		src.AutoTargetFace=1
		src.AutoAttackFace=1
		src.AutoSkillFace=1
	if(src.SaveVersion<0)
		src.PvpKills=0;src.PvpDeaths=0;src.Honor=0
		src<<"<b><font color=red>Your PVP Stats have been Reset due to a Recent Update"
	if(src.Gold<0||src.Silver<0||src.Copper<0)
		world.log<<"Gold Fix / [src.key] / [src.Gold]g [src.Silver]s [src.Copper]c"
		if(src.Gold<0)	src.Gold=0
		if(src.Silver<0)	src.Silver=0
		if(src.Copper<0)	src.Copper=0
	if(src.RespawnZ!=1)	src.TutLevel=5
	if(!src.MaxArrowCharges)	src.MaxArrowCharges=1

mob/proc/CreatePlayerIcon()
	var/icon/I='SoulReaper.dmi'
	if(src.Class=="Quincy")	I='Quincy.dmi'
	if(src.Class=="Bount")
		if(src.gender!="female")	I='School.dmi'
		else	I='SchoolFemale.dmi'
	src.PlayerIcon=new(I,icon_state="",dir=SOUTH);src.PlayerIcon.Shift(SOUTH,9,0)
	var/icon/I2
	if(src.HairOver)	I2=new(src.HairOver.icon,icon_state="",dir=SOUTH)
	src.PlayerIcon.Blend(I2,ICON_OVERLAY)