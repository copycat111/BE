client
	Del()
		for(var/I in src.images)	del I
		for(var/O in src.screen)
			if(!istype(O,/obj/Items))	del O
		if(src.mob)
			src.mob.Save(1,1)
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
		var/savefile/F = new("Logons/[ckey(src.key)].txt")
		F["LoggedOn"]<<src.LoggedOn
	LoadLogonFile()
		if(fexists("Logons/[ckey(src.key)].txt"))
			var/savefile/F = new("Logons/[ckey(src.key)].txt")
			F["LoggedOn"]>>src.LoggedOn
		else
			src.SaveLogonFile()

	SavePlayerConfig()
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

	Save(var/ForceBackup=0,var/ForceFull=0)
		if(src.z==2 && !ForceFull)	return
		if(src.z==2 && ForceFull)
			if(!src.SaveSlot || !src.Class || !src.icon)	return
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

		if(src.client && src.client.eye!=locate(67,10,2))	F["Zanpakuto"]<<src.Zanpakuto
		F["ZanpakutoOverlays"]<<src.ZanpakutoOverlays
		if(EnableSaveChunkExtensions)
			if(!src.SaveDirtyFlags)	src.SaveDirtyFlags=list()
			var/list/CoreChunk=src.BuildCoreChunk()
			var/list/InventoryChunk=src.BuildInventoryChunk()
			var/list/ProgressionChunk=src.BuildProgressionChunk()
			var/list/CosmeticChunk=src.BuildCosmeticChunk()
			var/CoreHash=md5("[CoreChunk]")
			var/InventoryHash=md5("[InventoryChunk]")
			var/ProgressionHash=md5("[ProgressionChunk]")
			var/CosmeticHash=md5("[CosmeticChunk]")
			var/CoreDirty=(ForceFull || src.SaveDirtyFlags["core"] || src.LastCoreChunkHash!=CoreHash)
			var/InventoryDirty=(ForceFull || src.SaveDirtyFlags["inventory"] || src.LastInventoryChunkHash!=InventoryHash)
			var/ProgressionDirty=(ForceFull || src.SaveDirtyFlags["progression"] || src.LastProgressionChunkHash!=ProgressionHash)
			var/CosmeticDirty=(ForceFull || src.SaveDirtyFlags["cosmetic"] || src.LastCosmeticChunkHash!=CosmeticHash)
			if(CoreDirty)
				F["CoreChunk"]<<CoreChunk
				src.LastCoreChunkHash=CoreHash
			if(InventoryDirty)
				F["InventoryChunk"]<<InventoryChunk
				src.LastInventoryChunkHash=InventoryHash
			if(ProgressionDirty)
				F["ProgressionChunk"]<<ProgressionChunk
				src.LastProgressionChunkHash=ProgressionHash
			if(CosmeticDirty)
				F["CosmeticChunk"]<<CosmeticChunk
				src.LastCosmeticChunkHash=CosmeticHash
			F["SaveFormatVersion"]<<2
			var/list/ChunkMeta=list()
			ChunkMeta["SavedAt"]=NowStamp()
			ChunkMeta["CoreHash"]=src.LastCoreChunkHash
			ChunkMeta["InventoryHash"]=src.LastInventoryChunkHash
			ChunkMeta["ProgressionHash"]=src.LastProgressionChunkHash
			ChunkMeta["CosmeticHash"]=src.LastCosmeticChunkHash
			F["ChunkMeta"]<<ChunkMeta
			src.SaveDirtyFlags["core"]=0
			src.SaveDirtyFlags["inventory"]=0
			src.SaveDirtyFlags["progression"]=0
			src.SaveDirtyFlags["cosmetic"]=0
		var/DoBackup=(ForceBackup || ForceFull)
		if(!DoBackup)
			if(!src.LastBackupTick || world.time-src.LastBackupTick>=18000)	DoBackup=1
		if(DoBackup)
			fcopy(F,"PlayersBackup/[copytext(ckey(src.key),1,2)]/[ckey(src.key)][src.SaveSlot].sav")
			src.LastBackupTick=world.time

		//Used for Global Save
		/*src<<"Saving Game..."
		if(world.Export("byond://166.82.8.113:4440?[ckey(src.key)][src.SaveSlot]",F))	src<<"Game Saved"
		else	src<<"<b><font color=red>Error Contacting Save Server!"
		fdel("Players/[copytext(ckey(src.key),1,2)]/[ckey(src.key)][src.SaveSlot].sav")*/

mob/proc/BuildCoreChunk()
	var/list/L=list()
	L["LastX"]=src.x
	L["LastY"]=src.y
	L["LastZ"]=src.z
	L["name"]=src.name
	L["Class"]=src.Class
	L["ClassLevel"]=src.ClassLevel
	L["Level"]=src.Level
	L["REI"]=src.REI
	L["MaxREI"]=src.MaxREI
	L["STM"]=src.STM
	L["MaxSTM"]=src.MaxSTM
	L["STR"]=src.STR
	L["VIT"]=src.VIT
	L["MGC"]=src.MGC
	L["MGCDEF"]=src.MGCDEF
	L["AGI"]=src.AGI
	L["LCK"]=src.LCK
	L["Gold"]=src.Gold
	L["Silver"]=src.Silver
	L["Copper"]=src.Copper
	L["Exp"]=src.Exp
	L["Nexp"]=src.Nexp
	L["Kills"]=src.Kills
	L["Deaths"]=src.Deaths
	L["Honor"]=src.Honor
	L["PvpKills"]=src.PvpKills
	L["PvpDeaths"]=src.PvpDeaths
	L["StatPoints"]=src.StatPoints
	L["TraitPoints"]=src.TraitPoints
	L["SkillPoints"]=src.SkillPoints
	L["RespawnX"]=src.RespawnX
	L["RespawnY"]=src.RespawnY
	L["RespawnZ"]=src.RespawnZ
	L["ArenaRound"]=src.ArenaRound
	L["ArenaBonus"]=src.ArenaBonus
	return L

mob/proc/BuildInventoryChunk()
	var/list/L=list()
	L["Inventory"]=src.Inventory
	L["Pets"]=src.Pets
	L["Head"]=src.Head
	L["Body"]=src.Body
	L["Hand"]=src.Hand
	L["Back"]=src.Back
	L["Feet"]=src.Feet
	L["TransLocs"]=src.TransLocs
	return L

mob/proc/BuildProgressionChunk()
	var/list/L=list()
	L["Skills"]=src.Skills
	L["Kidous"]=src.Kidous
	L["Spells"]=src.Spells
	L["StatusEffects"]=src.StatusEffects
	L["ComboList"]=src.ComboList
	L["Quests"]=src.Quests
	L["CompletedQuests"]=src.CompletedQuests
	L["ChestList"]=src.ChestList
	L["TutLevel"]=src.TutLevel
	L["PlayTime"]=src.PlayTime
	L["LevelLog"]=src.LevelLog
	L["CurSkill"]=src.CurSkill
	L["ArrowType"]=src.ArrowType
	L["SkillDmg"]=src.SkillDmg
	L["SkillRei"]=src.SkillRei
	L["Beastiary"]=src.Beastiary
	return L

mob/proc/BuildCosmeticChunk()
	var/list/L=list()
	L["HairR"]=src.HairR
	L["HairG"]=src.HairG
	L["HairB"]=src.HairB
	L["HairStyle"]=src.HairStyle
	L["ClothesR"]=src.ClothesR
	L["ClothesG"]=src.ClothesG
	L["ClothesB"]=src.ClothesB
	L["VoiceSet"]=src.VoiceSet
	L["HotKeys"]=src.HotKeys
	L["ZanpakutoOverlays"]=src.ZanpakutoOverlays
	return L

mob/proc
	Load(var/savefile/F)
		//Used for Global Save
		/*if(!F)
			src<<"Loading Game..."
			F=world.Export("byond://166.82.8.113:4440?Load[ckey(src.key)][src.SaveSlot]")
			return*/

		if(!F)
			F = new("Players/[copytext(ckey(src.key),1,2)]/[ckey(src.key)][src.SaveSlot].sav")
		F["SaveVersion"]>>src.SaveVersion
		if(src.SaveVersion<1.2)
			src<<"Your Save file is Too Far out of Date. Please Create a new Character"
			return
		src.LoadCoreState(F)
		spawn(1)	if(src)	src.LoadDeferredState()

	LoadCoreState(var/savefile/F)
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
		src.EquipmentList=list()
		src.EquipmentList+=Head
		src.EquipmentList+=Body
		src.EquipmentList+=Hand
		src.EquipmentList+=Back
		src.EquipmentList+=Feet
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
		src.AddName()
		src.LoadVoiceSet()
		src.AddHair(src.HairStyle)
		src.loc=locate(src.LastX,src.LastY,src.LastZ)
		src.RebuildSpecialSkillCaches()
		src.HUD(0)
		src.invisibility=0
		if(!src.SaveDirtyFlags)	src.SaveDirtyFlags=list()
		src.SaveDirtyFlags["core"]=1
		src.SaveDirtyFlags["inventory"]=1
		src.SaveDirtyFlags["progression"]=1
		src.SaveDirtyFlags["cosmetic"]=1

	LoadDeferredState()
		if(!src || !src.client)	return
		var/Counter=0
		for(var/obj/Items/Equipment/E in src.EquipmentList)
			if(!src || !src.client)	return
			E.OnEquip(src)
			Counter+=1
			if(Counter%20==0)	sleep(1)
		Counter=0
		for(var/datum/StatusEffects/RadialEffects/E in src.StatusEffects)
			if(!src || !src.client)	return
			E.AddOverlays(src)
			Counter+=1
			if(Counter%20==0)	sleep(1)
		if(!src || !src.client)	return
		src.HUD()
		src.QuestRefresh()
		src.RefreshClothes()
		Counter=0
		for(var/obj/Items/I in src.Inventory)
			if(!src || !src.client)	return
			I.UpdateCount()
			Counter+=1
			if(Counter%25==0)	sleep(1)
		Counter=0
		for(var/mob/Pets/P in src.Pets)
			if(!src || !src.client)	return
			P.Owner=src
			P.AddName()
			P.StmBar()
			P.ReiBar()
			Counter+=1
			if(Counter%10==0)	sleep(1)
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

	RebuildSpecialSkillCaches()
		src.CanShunpo=0
		src.ShikaiSkills=list()
		src.BankaiSkills=list()
		src.FinalFormSkills=list()
		for(var/obj/Skills/S in src.Skills)
			if(istype(S,/obj/Skills/Universal/Flash_Step))
				src.CanShunpo=1
			if(istype(S,/obj/Skills/SoulReaper/Shikai) && !src.Zanpakuto)
				src.ZanCreation()
			if(istype(S,/obj/Skills/Shikais))
				src.ShikaiSkills+=S
			if(istype(S,/obj/Skills/Bankais))
				src.BankaiSkills+=S
			if(istype(S,/obj/Skills/FinalForm))
				src.FinalFormSkills+=S

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
		if(src.gender!=FEMALE)	I='School.dmi'
		else	I='SchoolFemale.dmi'
	src.PlayerIcon=new(I,icon_state="",dir=SOUTH);src.PlayerIcon.Shift(SOUTH,9,0)
	var/icon/I2
	if(src.HairOver)	I2=new(src.HairOver.icon,icon_state="",dir=SOUTH)
	src.PlayerIcon.Blend(I2,ICON_OVERLAY)
