// alteration, conjuration, destruction, illusion, mysticism, restoration
obj
	Spells
		icon='Spells.dmi'
		icon_state="Blank Skill"
		mouse_opacity=2
		var/ReiCost=0
		var/AttPower=0
		var/Level=1
		var/MaxLevel=5
		var/LevelDesc
		var/SkillType
		var/CoolDown=0
		var/MaxCoolDown=30
		Click()
			var/Learnable=0
			var/ArrowCount=0
			for(var/obj/SkillTree/Arrow/A in oview(1,src))
				if(A.dir==get_dir(A,src))
					ArrowCount+=1
					var/turf/S=get_step(A,get_dir(src,A))
					for(var/obj/Spells/X in S)
						for(var/obj/Spells/Y in usr.Spells)
							if(X.name==Y.name)	{Learnable=1;break}
			if(!ArrowCount)	Learnable=1
			for(var/obj/Spells/O in usr.Spells)
				if(O.name==src.name)
					Learnable=0
					if(O.Level<O.MaxLevel)	Learnable=2
					break
			if(usr.SkillPoints<=0)	Learnable=0
			var/LI="Level: 0/[src.MaxLevel] > "
			for(var/obj/Spells/O in usr.Spells)
				if(O.name==src.name)	LI="Level: [O.Level]/[O.MaxLevel] > "
			if(Learnable==0)
				ShowAlert(usr,"[src.name] - [src.SkillType] > > [src.desc] > > [LI][src.LevelDesc]",list("Close"))
			if(Learnable==2)
				var/LD="[src.LevelDesc]"
				if(ShowAlert(usr,"[src.name] - [src.SkillType] > > [src.desc] > > [LI][LD]",list("Level","Close"))=="Level")
					if(usr.SkillPoints<=0)	return
					for(var/obj/Spells/S in usr.Spells)
						if(S.name==src.name)
							S.Level+=1;break
					usr.SkillPoints-=1;usr.LoadSpellTree();usr.LevelOrbGlow()
			if(Learnable==1)
				var/LD="[src.LevelDesc]"
				if(ShowAlert(usr,"[src.name] - [src.SkillType] > > [src.desc] > > [LI][LD]",list("Learn","Close"))=="Learn")
					if(usr.SkillPoints>=1)
						usr.SkillPoints-=1
						var/obj/Spells/NS=new src.type
						NS.Level=1;NS.MaxLevel=src.MaxLevel
						usr.Spells+=NS
						PlayMenuSound(usr,'OOT_MainMenu_Select.wav')
						usr.LoadSpellTree()
						usr.LevelOrbGlow()
		Healing
			SkillType="Restoration"
			Restoration
				icon_state="Restoration";SkillType="Knowledge"
				MaxLevel=1;desc="Grants you the Knowledge to cast Restoration type Spells"
			Soul_Glow
				ReiCost=50;AttPower=-50;icon_state="Soul Glow"
				desc="Heals current Target or Self > Restores 50+MGC STM > Consumes 50 Reiatsu"
				LevelDesc="+25% STM Restoration per Level"
			Cleanse
				MaxLevel=1
				ReiCost=75;icon_state="Cleanse"
				desc="Removes abnormal Status Effects from Current Target or Self > Consumes 75 Reiatsu"
			Regen
				ReiCost=100;icon_state="Regen"
				desc="Stamina will Recover even during combat > Applicable Targets: Self, Allies > Duration: 5 minutes > Consumes 100 Reiatsu"
				LevelDesc="+30 Second Duration per Level"
			Brightest_Light
				ReiCost=100;AttPower=-50;icon_state="Brightest Light"
				desc="Heals all nearby Allies > Restores 50+MGC STM > Consumes 100 Reiatsu"
				LevelDesc="+25% STM Restoration per Level"
		Augmentation
			SkillType="Augmentation"
			icon='AugmentationSpells.dmi'
			Augmentation
				icon_state="Augmentation";SkillType="Knowledge"
				MaxLevel=1;desc="Grants you the Knowledge to cast Augmentation type Spells"
			Jog
				icon_state="Jog"
				desc="Increases a Friendly Target's Movement Speed by 1 > Applicable Targets: Self, Allies > Duration: 5 Minutes > Consumes 50 Reiatsu"
				LevelDesc="+30 Second Duration per Level"
			Run
				icon_state="Run"
				desc="Increases a Friendly Target's Movement Speed by Additional 1 > Applicable Targets: Self, Allies > Duration: 5 Minutes > Consumes 50 Reiatsu"
				LevelDesc="+30 Second Duration per Level"
		Teleportation
			SkillType="Teleportation"
			icon='Teleportation.dmi'
			Teleportation
				icon_state="Teleportation";SkillType="Knowledge"
				MaxLevel=1;desc="Grants you the Knowledge to cast Teleportation type Spells"
			Recall
				MaxLevel=1;icon='Teleportation.dmi'
				icon_state="Recall";desc="Instantly teleports you to your current Respawn Point. > Cannot be used during combat"
			Travel
				icon_state="Travel"
				MaxLevel=1;desc="Instantly teleport yourself to a previously visited location. > Cannot be used during combat. > Consumes 200 Reiatsu"
			Teleport
				icon_state="Teleport"
				MaxLevel=1;desc="Instantly teleport yourself to a friendly player. > Cannot be used during combat. > Consumes 200 Reiatsu"
			Portal
				icon_state="Portal"
				MaxLevel=1;desc="Open a Portal to a previously visited location. > Only one Portal can be open at a time. > Portals will close once you enter them or logout. > Cannot be used during combat. > Consumes 200 Reiatsu"
			Summon
				icon_state="Summon"
				MaxLevel=1;desc="Instantly teleport a friendly player to your location. > Cannot be used during combat. > Consumes 200 Reiatsu"
		Mysticism
			SkillType="Mysticism"
			Mysticism
				icon_state="Mysticism";SkillType="Knowledge"
				MaxLevel=1;desc="Grants you the Knowledge to cast Mysticism type Spells"
			White_Prostration
				//Incantation="Hakufuku"
				ReiCost=75;AttPower=0.75
				icon_state="White Prostration";desc="Causes a target to lose consciousness for 0.75 Seconds. > Consumes 75 Reiatsu"
				LevelDesc="+0.75 Seconds per Level"
			Mirror_Gate
				//Incantation="Kyoumon"
				MaxLevel=1
				icon_state="Mirror Gate";desc="A high class barrier that reflects attacks from the outside. However, it is easy to break from the inside. > Consumes 150 Reiatsu"
		Other
			//Fake Skills to Prevent Load Runtimes - Should Auto Clear on Respec
			SkillType="BugFixes"
			Recall
			Mirror_Gate
			White_Prostration