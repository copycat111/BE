mob/verb
	HotKeyDown(var/HKD as text)
		set hidden=1
		var/Secondary="[copytext(HKD,2,0)]"
		HKD="[copytext(HKD,1,2)]"
		if(usr.MusicMode)	usr.PlayNote(HKD,Secondary)
		else
			if(!Secondary)
				var/Skill2Use=src.HotKeys[text2num(HKD)]
				usr.UseSkillProc(Skill2Use)

obj
	SkillTree
		icon='Skills.dmi'
		density=1
		layer=4
		SkillTypeOverlay
			mouse_opacity=0
			New(var/IS)
				src.icon_state="[IS]"
obj
	Skills
		icon='Skills.dmi'
		icon_state="Blank Skill"
		mouse_opacity=2
		var/SkillType="Passive"
		var/Stat2Boost
		var/BoostAmount
		var/Level=1
		var/MaxLevel=5
		var/LevelDesc
		var/CoolDown=0
		var/MaxCoolDown=30
		New()
			spawn(1)
				src.icon_state=src.name
				src.overlays+=new/obj/SkillTree/SkillTypeOverlay(src.SkillType)
		Click()
			if(src.name=="Shikai")
				for(var/obj/Skills/SoulReaper/Shikai/S in usr.Skills)
					PlayMenuSound(usr,'OOT_MainMenu_Select.wav')
					if(usr.Zanpakuto)
						var/obj/Zanpakuto/Z=usr.Zanpakuto
						if(Z.SpiritType=="Petals")	usr.client.eye=locate(48,86,2)
						if(Z.SpiritType=="Dragon")	usr.client.eye=locate(10,86,2)
						if(Z.SpiritType=="Ghost")	usr.client.eye=locate(29,86,2)
						if(Z.SpiritType=="Beast")	usr.client.eye=locate(67,86,2)
						usr.LoadSkillTree()
					return
			if(src.name=="Bankai")
				for(var/obj/Skills/SoulReaper/Bankai/B in usr.Skills)
					PlayMenuSound(usr,'OOT_MainMenu_Select.wav')
					if(usr.Zanpakuto)
						var/obj/Zanpakuto/Z=usr.Zanpakuto
						if(Z.SpiritType=="Petals")	usr.client.eye=locate(48,105,2)
						if(Z.SpiritType=="Dragon")	usr.client.eye=locate(10,105,2)
						if(Z.SpiritType=="Ghost")	usr.client.eye=locate(29,105,2)
						if(Z.SpiritType=="Beast")	usr.client.eye=locate(67,105,2)
						usr.LoadSkillTree()
					return
			if(src.name=="Final Form")
				for(var/obj/Skills/Quincy/Final_Form/S in usr.Skills)
					PlayMenuSound(usr,'OOT_MainMenu_Select.wav')
					usr.client.eye=locate(67,67,2)
					usr.LoadSkillTree()
					return
			var/Learnable=0
			var/SubMax=5
			if(usr.Subscriber)	SubMax=5
			for(var/obj/SkillTree/Arrow/A in oview(1,src))
				if(A.dir==get_dir(A,src))
					var/turf/S=get_step(A,get_dir(src,A))
					for(var/obj/Skills/X in S)
						for(var/obj/Skills/Y in usr.Skills)
							if(X.name==Y.name)	{Learnable=1;break}
			var/obj/Skills/MS
			for(var/obj/Skills/O in usr.Skills)
				if(O.name==src.name)
					Learnable=0;MS=O
					if(O.Level<O.MaxLevel)	Learnable=2
					break
			if(usr.SkillPoints<=0)	Learnable=0
			var/LI="Level: 0/[src.MaxLevel] > "
			for(var/obj/Skills/O in usr.Skills)
				if(O.name==src.name)	LI="Level: [O.Level]/[O.MaxLevel] > "
			if(Learnable==0)
				ShowAlert(usr,"[src.name] - [src.SkillType] > > [src.desc] > > [LI][src.LevelDesc]",list("Close"))
			if(Learnable==2)
				var/LD="[src.LevelDesc]"
				if(ShowAlert(usr,"[src.name] - [src.SkillType] > > [src.desc] > > [LI][LD]",list("Level","Close"))=="Level")
					if(usr.SkillPoints<=0)	return
					if(MS.Level<SubMax)
						for(var/obj/Skills/S in usr.Skills)
							if(S.name==src.name)
								S.Level+=1
								if(S.Stat2Boost)
									usr.vars["[S.Stat2Boost]"]+=S.BoostAmount
									usr.HUDRefresh()
								break
						usr.SkillPoints-=1;usr.LoadSkillTree();usr.LevelOrbGlow()
					else
						//ShowAlert(usr,"Higher Skill Levels Available > for Subscribers")
						ShowAlert(usr,"Higher Skill Levels Not Yet Available")
			if(Learnable==1)
				var/LD="[src.LevelDesc]"
				if(ShowAlert(usr,"[src.name] - [src.SkillType] > > [src.desc] > > [LI][LD]",list("Learn","Close"))=="Learn")
					if(src.name in usr.Skills)	return
					if(usr.SkillPoints>=1)
						usr.SkillPoints-=1
						var/obj/Skills/NS=new src.type
						NS.Level=1;NS.MaxLevel=src.MaxLevel
						usr.Skills+=NS
						if(istype(src,/obj/Skills/Shikais))	usr.ShikaiSkills+=NS
						if(istype(src,/obj/Skills/Bankais))	usr.BankaiSkills+=NS
						if(istype(src,/obj/Skills/FinalForm))	usr.FinalFormSkills+=NS
						if(src.name=="Flash Step")	usr.CanShunpo=1
						if(src.Stat2Boost)
							usr.vars["[src.Stat2Boost]"]+=src.BoostAmount
							usr.HUDRefresh()
						PlayMenuSound(usr,'OOT_MainMenu_Select.wav')
						usr.LoadSkillTree()
						usr.LevelOrbGlow()
		Universal
			icon='UniversalSkills.dmi'
			Dodge
				SkillType="Stat Booster"
				Stat2Boost="DodgeBonus"
				BoostAmount=3
				icon_state="Dodge";desc="Additional Chance to Dodge Incoming Attacks"
				LevelDesc="+3% Chance per Level"
			Flash_Step
				MaxLevel=1
				icon_state="Flash Step";desc="Double Click Map to Teleport"
				SkillType="Active"
			Rei_Rage
				icon_state="Rei Rage";desc="Converts a % of all Damage Taken into Reiatsu"
				LevelDesc="+10% Damage Converted per Level"
				SkillType="Passive"
			Spirit_Regen
				SkillType="Stat Booster"
				Stat2Boost="ReiRegenBonus"
				BoostAmount=1
				icon_state="Spirit Regen";desc="Increase the Amount of Passively Restored Reiatsu"
				LevelDesc="+10 Regen per Second per Level"
			Spirit_Charge
				icon_state="Spirit Charge";desc="Quickly Gather Spirit Energy to Restore Reiatsu > Hold to Charge"
				SkillType="Active"
				LevelDesc="+1 REI Recovery Rate per Level"
			Body_Regen
				SkillType="Stat Booster"
				Stat2Boost="StmRegenBonus"
				BoostAmount=1
				icon_state="Body Regen";desc="Increase the Amount of Passively Restored Stamina"
				LevelDesc="+10 Regen per Second per Level"
			ExoShell
				SkillType="Stat Booster"
				Stat2Boost="MaxSTM";BoostAmount=20
				icon_state="ExoShell";desc="Permanently Increases Max Stamina"
				LevelDesc="+20 Stamina per Skill Level"
			Spirit_Shine
				SkillType="Stat Booster"
				Stat2Boost="MaxREI";BoostAmount=10
				icon_state="Spirit Shine";desc="Permanently Increases Max Reiatsu"
				LevelDesc="+10 Reiatsu per Skill Level"
			Brute
				SkillType="Stat Booster"
				Stat2Boost="STR";BoostAmount=2
				icon_state="Brute";desc="Permanently Increases Strength"
				LevelDesc="+2 Strength per Skill Level"
			Stone_Skin
				SkillType="Stat Booster"
				Stat2Boost="VIT";BoostAmount=2
				icon_state="Stone Skin";desc="Permanently Increases Vitality"
				LevelDesc="+2 Vitality per Skill Level"
			Mystic_Glow
				SkillType="Stat Booster"
				Stat2Boost="MGC";BoostAmount=2
				icon_state="Mystic Glow";desc="Permanently Increases Magic"
				LevelDesc="+2 Magic per Skill Level"
			Mystic_Aura
				SkillType="Stat Booster"
				Stat2Boost="MGCDEF";BoostAmount=2
				icon_state="Mystic Aura";desc="Permanently Increases Magic Defense"
				LevelDesc="+2 Magic Defense per Skill Level"
			Blur
				SkillType="Stat Booster"
				Stat2Boost="AGI";BoostAmount=2
				icon_state="Blur";desc="Permanently Increases Agility"
				LevelDesc="+2 Agility per Skill Level"
			Lucky_Stars
				SkillType="Stat Booster"
				Stat2Boost="LCK";BoostAmount=2
				icon_state="Lucky Stars";desc="Permanently Increases Luck"
				LevelDesc="+2 Luck per Skill Level"
		Bount
			icon='BountSkills.dmi'
			Pet_Skills
				MaxLevel=1;SkillType="Passive"
				icon_state="Pet Skills";desc="This Skill will be used to Acess your Pet's Skill Tree.  However, that hasn't been implemented yet."
			Doll_Fusion
				MaxLevel=1;SkillType="Active"
				icon_state="Doll Fusion";desc="Become One with your Pet"
				LevelDesc="Requires Special Training available at Level 50"
			Summon_Pet
				MaxLevel=1;SkillType="Active"
				icon_state="Summon Pet";desc="Summons your Bount pet(s) to the field"
			Dismiss_Pet
				MaxLevel=1;SkillType="Active"
				icon_state="Dismiss Pet";desc="Dismisses your Bount pet(s) from the field"
			Heal_Pet
				SkillType="Support"
				icon_state="Heal Pet";desc="Heals all pets under your control for 25+10*MGC > Consumes 50 Reiatsu"
				LevelDesc="+10% to Heal per Level"
			Syphon_Health
				SkillType="Support"
				icon_state="Syphon Health";desc="Drains Reiatsu to Heal a Friendly Target > \
					Drains Reiatsu equal to your level each second > Heals eqaul to 10+5*MGC > Skill can be Held"
				LevelDesc="+10% to Heal per Level"
			Flash_Heal
				SkillType="Active"
				icon_state="Flash Heal";desc="Instantly Recover 10% of your Maximum Stamina.  Consumes 10% Maximum Reiatsu"
				LevelDesc="+3% to Heal per Level"
			Recovery_Cost
				SkillType="Stat Booster"
				Stat2Boost="StmRegenCost"
				BoostAmount=-1
				icon_state="Recovery Cost";desc="Lowers the Reiatsu Cost of Passively Recovering Stamina"
				LevelDesc="-1 Reiatsu lost per Second per Level while Recovering Stamina"
			Battlefield_Layout
				SkillType="Active"
				icon_state="Battlefield Layout";desc="Increases the Movement Speed of Nearby Allies by 1 > This skill can be Toggled.  Drains 5 Reiatsu Per Second while Active."
				LevelDesc="+1 Distance to Area of Effect per Level > Base Distance of 5"
			Offensive_Tactics
				SkillType="Active"
				icon_state="Offensive Tactics";desc="Increases the Damage Dealt by all Nearby Allies by 10% > This skill can be Toggled.  Drains 5 Reiatsu Per Second while Active."
				LevelDesc="+1 Distance to Area of Effect per Level > Base Distance of 5"
			Defensive_Strategy
				SkillType="Active"
				icon_state="Defensive Strategy";desc="Reduces the Damage Taken by all Nearby Allies by 10% > This skill can be Toggled.  Drains 5 Reiatsu Per Second while Active."
				LevelDesc="+1 Distance to Area of Effect per Level > Base Distance of 5"
		SoulReaper
			icon='SoulReaperSkills.dmi'
			Basic_Combat
				MaxLevel=1
				icon_state="Basic Combat";desc="Allows for Basic Combat and Combos"
			Power_Strike
				SkillType="Attack"
				icon_state="Power Strike";desc="Instant Attack, Deal 100+STR Melee Damage, 25 REI"
				LevelDesc="+25% Damage per Level"
			Spirit_Shell
				SkillType="Stat Booster"
				Stat2Boost="ShieldBonus"
				BoostAmount=5
				icon_state="Spirit Shell";desc="Decrease All Damage Taken"
				LevelDesc="+5% Decrease in Damage per Level"
			Immunity
				SkillType="Stat Booster"
				Stat2Boost="ImmunityBonus"
				BoostAmount=15
				icon_state="Immunity";desc="Immunity to Status Effects"
				LevelDesc="+15% Immunity per Level"
			Guard_Breaker
				MaxLevel=1
				icon_state="Guard Breaker";desc="Break Through Enemy Guard with Combo Attacks"
			Combat_Mastery
				icon_state="Combat Mastery";desc="Each Attack in a Combo Deals more then the Last"
				LevelDesc="+10% Damage per Attack per Level"
			Restore_Point
				SkillType="Active"
				icon_state="Restore Point";desc="Drain all REI to Restore all STM, REI must be at 100%"
				LevelDesc="10% Less Required REI per Level"
			Combat_Reflexes
				SkillType="Stat Booster"
				Stat2Boost="GuardBonus"
				BoostAmount=5
				icon_state="Combat Reflexes";desc="Chance to Automaticaly Guard against Incoming Attacks"
				LevelDesc="+5% Chance per Level"
			Double_Strike
				SkillType="Stat Booster"
				Stat2Boost="DoubleStrikeBonus"
				BoostAmount=3
				icon_state="Double Strike";desc="Chance to Hit Twice with All Attacks"
				LevelDesc="+3% Chance per Level"
			Counter_Attack
				SkillType="Stat Booster"
				Stat2Boost="CounterBonus"
				BoostAmount=5
				icon_state="Counter Attack";desc="Chance to Automaticaly Counter Attack when Guarding"
				LevelDesc="+5% Chance per Level"
			Shikai
				SkillType="Active"
				Level=1;MaxLevel=1
				icon_state="Shikai";desc="The First Release of your Zanpakuto"
				LevelDesc="Requires Special Training available at Level 20"
			Guard
				MaxLevel=1
				SkillType="Active"
				icon_state="Guard";desc="Guard Incoming Attacks to Avoid Damage"
			Combo
				icon_state="Combo";desc="Unlocks new Combos"
				LevelDesc="Each Level Unlocks new > Combos in the Combo Tab. > Level 4 Unlocks Finishers. > Level 5 Unlocks Burst Strike."
			Bankai
				SkillType="Active"
				Level=1;MaxLevel=1
				icon_state="Bankai";desc="The Final Release of your Zanpakuto"
				LevelDesc="Requires Special Training available at Level 50"
			Visored
				SkillType="Active"
				Level=1;MaxLevel=1
				icon_state="Visored";desc="Unite with your Inner Hollow"
				LevelDesc="Requires Special Training available at Level 125"
			ShockWave
				SkillType="Attack"
				icon_state="ShockWave";desc="100+STR Damage to all Surrounding Enemies, 75 REI"
				LevelDesc="+25% Damage per Level"
			Spirit_Blast
				SkillType="Attack"
				icon_state="Spirit Blast";desc="Stun All Surrounding Enemies, 50 REI";
				LevelDesc="Increase Stun Radius and Time each Level"
			Last_Gasp
				MaxLevel=1
				icon_state="Last Gasp";desc="Cannot be Killed Unless already at 1 STM > When this skill activates you will become Invincible for 1 Second"
			Backlash
				MaxLevel=1
				icon_state="Backlash";desc="Deal up to 50% of Melee Damage back to Attacking Enemies when Guarding"
			Second_Life
				icon_state="Second Life";desc="Before Dying, Automaticaly Drain All REI to Replenish Equal Amount of STM"
				LevelDesc="+10% Boost to Restored STM per Level"
			Flash_Assault
				SkillType="Passive"
				icon_state="Flash Assault";desc="Quickly Close in on your Target and Attack from Behind.  Stuns Target for 1 Second on Activation.  Must be at least 2 Tiles from Target."
				LevelDesc="Leveling Increases Range from which you will Flash Assault"
			Battle_Focus
				SkillType="Stat Booster"
				Stat2Boost="CritBonus"
				BoostAmount=3
				icon_state="Battle Focus";desc="Additional Chance to Land a Critical Hit"
				LevelDesc="+3% Chance per Level"
			Brave_Shout
				SkillType="Active"
				icon_state="Brave Shout";desc="Taunt all nearby Enemies into Attacking you > Base Range of 5"
				LevelDesc="+1 Range per Level"
			Berserk
				SkillType="Active"
				icon_state="Berserk";desc="Increase Melee Damage Dealt by 20% and Melee Damage taken by 10% > Lasts 10 Seconds Consumes 25 Reiatsu"
				LevelDesc="+1% Damage Dealt per Level > +1 Second Duration per Level"
		Quincy
			icon='QuincySkills.dmi'
			Pride_of_the_Quincy
				MaxLevel=1
				icon_state="Pride of the Quincy";desc="Cannot be Killed Unless already at 1 STM > When this skill activates you will become Invincible for 1 Second"
			Spirit_Arrow
				MaxLevel=1
				icon_state="Spirit Arrow";desc="Create Basic Arrows with your Spirit Energy"
				SkillType="Passive Attack"
			Power_Shot
				SkillType="Attack"
				icon_state="Power Shot";desc="Instant Arrow Attack, Deals 100+MGC Mystic Damage, 50 Reiatsu"
				LevelDesc="+25% Damage per Level"
			Barrage
				SkillType="Attack"
				icon_state="Barrage";desc="Instant Arrow Attack, Multiple Arrows at 100+MGC Damage each, 150 Reiatsu"
				LevelDesc="+1 Arrow per Level, +25% Damage per Arrow per Level"
			Burst_Arrow
				icon_state="Burst Arrow";desc="Arrows Explode when they Reach Max Distance"
				SkillType="Passive Attack"
				LevelDesc="Increase Burst Radius each Level"
			Paralysis_Arrow
				icon_state="Paralysis Arrow";desc="Gives Arrows a Chance to Paralyze Targets"
				SkillType="Passive Attack"
				LevelDesc="+20% Chance to Paralyze per Level"
			Rapid_Fire
				icon_state="Rapid Fire";desc="Fire Multiple Arrows with 50% Damage each"
				SkillType="Passive Attack"
				LevelDesc="+1 Arrow per Level"
			Spread_Shot
				icon_state="Spread Shot";desc="Fire Arrows in 3 Directions at Once"
				SkillType="Passive Attack"
				LevelDesc="More Arrows Fired per Level"
			Homing_Arrow
				MaxLevel=1
				icon_state="Homing Arrow";desc="Arrows will Home in on Targets"
				SkillType="Passive Attack"
			Energy_Expert
				SkillType="Stat Booster"
				Stat2Boost="ArrCreateSpd"
				BoostAmount=1
				icon_state="Energy Expert";desc="Increase Arrow Creation Speed"
				LevelDesc="+1 Creation Speed Boost per Level"
			Pierce
				icon_state="Pierce";desc="Arrows will Peirce Targets"
				LevelDesc="+1 Target Peirced per Level"
			Power_Arrow
				icon_state="Power Arrow";desc="Increase Damage done by all Arrow Attacks"
				LevelDesc="+10% Damage Boost per Level"
			Marksman
				SkillType="Stat Booster"
				Stat2Boost="DistChargeSpd"
				BoostAmount=1
				icon_state="Marksman";desc="Arrow Distance Meter Charges Faster"
				LevelDesc="+1 Charge Speed Boost per Level"
			Body_Puppet
				SkillType="Stat Booster"
				Stat2Boost="ImmunityBonus"
				BoostAmount=15
				icon_state="Body Puppet";desc="Immunity to Status Effects"
				LevelDesc="+15% Immunity per Level"
			Final_Form
				SkillType="Active"
				MaxLevel=1
				icon_state="Final Form";desc="The Release of your Sanrei Glove"
				LevelDesc="Requires Special Training available at Level 25"
			Selfless_Distraction
				SkillType="Active"
				icon_state="Selfless Distraction";desc="Taunt all nearby Enemies into Attacking you > Base Range of 5"
				LevelDesc="+1 Range per Level"
			Group_Morale
				SkillType="Active"
				icon_state="Group Morale";desc="Increases the Reiatsu Recovery Rate of Nearby Allies by 10 per Second > This skill can be Toggled.  Drains 5 Reiatsu Per Second while Active."
				LevelDesc="+1 Distance to Area of Effect per Level > Base Distance of 5"
		Shikais
			Shared
				icon='SharedShikais.dmi'
				Blind_Strength
					SkillType="Passive"
					icon_state="Blind Strength";desc="Increases Melee damage done by 1% > Only Active during Shikai"
					LevelDesc="+1% Increase to Damage each Level"
				Enrage
					SkillType="Active"
					icon_state="Enrage";desc="Increase Melee Damage Dealt by 30% > Lasts 10 Seconds > Consumes 25 Reiatsu"
					LevelDesc="+1% Damage Dealt per Level > +1 Second Duration per Level"
			Dark_Ghost
				icon='ShikaiDarkGhost.dmi'
				Getsuga_Tenshou
					SkillType="Attack"
					icon_state="Getsuga Tenshou";desc="Fire a Concentrated Blast of Reiatsu > Deals STR*3+Charged Rei Mystic Damage > Hold to Charge"
					LevelDesc="+10% Base Damage per Level > +1 Charge Speed per Level"
			Light_Dragon
				icon='ShikaiLightDragon.dmi'
				Scatter
					SkillType="Active"
					icon_state="Scatter";desc="Scatter your Zanpakuto into 1,000 Blade Petals > Creates a Shield which causes Mystic Damage to all nearby Enemies > Guards against Frontal Assaults > Restricts all Melee Actions > This Skill is Toggleable"
					LevelDesc="Damage = 25 + MGC. > Plus 1 Base Damage per Level > Plus 25% Damage per Level"
				Petal_Stream
					SkillType="Attack"
					icon_state="Petal Stream";desc="Fire a Concentrated Stream of Blade Petals > Hold to Fire > Consumes 15 Rei per second"
					LevelDesc="Damage = 25 + MGC. > Plus 1 Base Damage per Level > +25% Damage per Level"
			Ice_Dragon
				icon='ShikaiIceDragon.dmi'
				Freeze_Ring
					SkillType="Attack"
					icon_state="Freeze Ring";desc="Freeze the ground surrounding the player for 3 seconds. > Anyone inside the area during activation will be Frozen > Consumes 350 Rei"
					LevelDesc="Leveling Increases Freeze Radius and Duration"
				Ice_Dragon_Assault
					SkillType="Attack"
					icon_state="Ice Dragon Assault";desc="Launch an Elemental Dragon from your Sword. Freezes Opponents. > Damage = 250+MGC > Consumes 200 Rei"
					LevelDesc="+10% Damage per Level"
				Freeze_Blade
					SkillType="Passive"
					icon_state="Freeze Blade";desc="Attacks have a chance of Freezing the Target. > Only Active during Shikai"
					LevelDesc="+10% Chance to Freeze per Level"
			Earth_Beast
				icon='ShikaiEarthBeast.dmi'
				Blade_Break
					SkillType="Attack"
					icon_state="Blade Break";desc="Thrust your blade forward, Knocking back and Damaging opponents > Consumes 50 Rei"
					LevelDesc="Leveling Increases Damage and Attack Distance"
				Wound
					SkillType="Passive"
					icon_state="Wound";desc="Attacks will cause the Target to suffer 10% STR Bleed Damage for 7 Seconds. > Only Active during Shikai"
					LevelDesc="+2 Seconds Duration per Level"
		Bankais
			Dark_Ghost
				icon='BankaiDarkGhost.dmi'
				Black_Getsuga_Tenshou
					SkillType="Attack"
					icon_state="Black Getsuga Tenshou";desc="Fire a Concentrated Blast of Reiatsu > Deals STR*5+Charged Rei Mystic Damage > Hold to Charge"
					LevelDesc="+10% Base Damage per Level > +1 Charge Speed per Level"
				Flash_Combo
					SkillType="Passive"
					icon_state="Flash Combo";desc="35% Chance to Passively Flash Step around your Opponent when Executing Combos. > Only Active during Bankai"
					LevelDesc="+10% Chance to Flash Step when Attacking"
				A_Little_Faster
					SkillType="Passive"
					icon_state="A Little Faster";desc="\"What's the matter?  Am I moving too slow for you?  Just say so, and I can move a little faster if you'd like!\" > Only Active during Bankai > Requires Flash Combo"
					LevelDesc="+5% Chance to Flash Step when Attacking"
		FinalForm
			icon='FinalFormSkills.dmi'
			Hold_Charge
				SkillType="Stat Booster"
				Stat2Boost="MaxArrowCharges";BoostAmount=1
				icon_state="Hold Charge";desc="Increases the amount of Arrows you can Fire each Charge > Only active during Final Form"
				LevelDesc="+1 Arrow per Charge per Level"