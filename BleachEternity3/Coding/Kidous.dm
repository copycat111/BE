obj
	SkillTree
		KidouRank
			icon='ComboSysHud.dmi'
			icon_state="0"
obj
	Kidous
		icon='Kidous.dmi'
		icon_state="Hadou"
		mouse_opacity=2
		var/Level=0
		var/SkillType
		var/MaxLevel=5
		var/LevelDesc
		var/KidouRank=1
		var/Incantation
		var/AttPower=1
		var/ReiCost=25
		var/CoolDown=0
		var/MaxCoolDown=30
		Click()
			var/Learnable=1
			var/SubMax=5
			if(usr.Subscriber)	SubMax=5
			var/obj/Kidous/MS
			for(var/obj/Kidous/O in usr.Kidous)
				if(O.name==src.name)
					Learnable=0;MS=O
					if(O.Level<O.MaxLevel)	Learnable=2
					break
			if(usr.SkillPoints<=0)	Learnable=0
			var/LI="Level: 0/[src.MaxLevel] > "
			var/OverDesc="[src.SkillType] [src.KidouRank], [src.name] > > [src.desc]"
			for(var/obj/Kidous/O in usr.Kidous)
				if(O.name==src.name)	LI="Level: [O.Level]/[src.MaxLevel] > "
			if(Learnable==0)
				ShowAlert(usr,"[OverDesc] > > [LI][src.LevelDesc]",list("Close"))
			if(Learnable==2)
				var/LD="[src.LevelDesc]"
				if(ShowAlert(usr,"[OverDesc] > > [LI][LD]",list("Level","Close"))=="Level")
					if(usr.SkillPoints<=0)	return
					if(MS.Level<SubMax)
						for(var/obj/Kidous/S in usr.Kidous)
							if(S.name==src.name)
								S.Level+=1;break
						usr.SkillPoints-=1;usr.LoadKidouTree();usr.LevelOrbGlow()
					else
						//ShowAlert(usr,"Higher Kidou Levels Available > for Subscribers")
						ShowAlert(usr,"Higher Kidou Levels Not Yet Available")
			if(Learnable==1)
				var/LD="[src.LevelDesc]"
				if(ShowAlert(usr,"[OverDesc] > > [LI][LD]",list("Learn","Close"))=="Learn")
					if(src.name in usr.Kidous)	return
					if((round((src.KidouRank-10)/10)+1)*10>usr.Kidou)
						ShowAlert(usr,"Requires Level [(round((src.KidouRank-10)/10)+1)*10] Kidou Trait");return
					if(usr.SkillPoints>=1)
						usr.SkillPoints-=1
						var/obj/Kidous/NS=new src.type
						NS.Level=1
						usr.Kidous+=NS
						PlayMenuSound(usr,'OOT_MainMenu_Select.wav')
						usr.LoadKidouTree()
						usr.LevelOrbGlow()
		Bakudous//binding
			SkillType="Bakudou"
			Obstruction
				ReiCost=50;AttPower=0.5
				KidouRank=1;Incantation="Sai"
				icon_state="Obstruction";desc="This spell is used to paralyze the target. > Consumes 50 Reiatsu"
				LevelDesc="+0.5 Seconds per Level"
			Conquer
				ReiCost=75;AttPower=1
				KidouRank=9;Incantation="Geki"
				icon_state="Conquer";desc="Surrounds the target in a red light that restricts movement. > Consumes 75 Reiatsu"
				LevelDesc="+1 Seconds per Level"
			Tracing_Sparrow
				KidouRank=58;MaxLevel=1;Incantation="Kakushitsuijaku"
				icon_state="Tracing Sparrow";desc="Traces the location of a target soul."
			Binding_Light
				ReiCost=100;AttPower=2
				KidouRank=61;Incantation="Rikujoukourou"
				icon_state="Binding Light";desc="Movement of the opponent is bound by six bands of light. > Consumes 100 Reiatsu"
				LevelDesc="+2 Seconds per Level"
			Iron_Brace
				ReiCost=150;AttPower=3
				KidouRank=75;Incantation="Gochuutekkan"
				icon_state="Iron Brace";desc="An iron chain is fastened, then five pillars seal the target's whole body. > Consumes 150 Reiatsu"
				LevelDesc="+3 Seconds per Level"
			Silky_Sky
				KidouRank=77;MaxLevel=1;Incantation="Tenteikuura"
				icon_state="Silky Sky";desc="Directly relays a message to any number of target souls."
			Complete_Seal
				ReiCost=250;AttPower=5
				KidouRank=99;Incantation="Bankin"
				icon_state="Complete Seal";desc="Constricts the target with a bandage-like cloth. Pierces the target with timber. Drops an immense boulder over the target. > Deals 1,000 Mystic Damage Consumes 250 Rei"
				LevelDesc="+5 Seconds & +25% Damage per Level"
		Hadous//blast
			SkillType="Hadou"
			White_Lightning
				KidouRank=4;Incantation="Byakurai"
				icon_state="White Lightning";desc="Fires a bolt of lightning from the caster's finger. > Deals 10+Kidou+Mgc Mystic Damage per Hit Consumes 20 Rei per Second"
				LevelDesc="+25% Damage per Level"
			Red_Flame_Cannon
				KidouRank=31;Incantation="Shakkahou"
				icon_state="Red Flame Cannon";desc="Attacks the target with a red blast of fire. > Deals 150+Kidou+Mgc Mystic Damage for 150 Rei"
				LevelDesc="+25% Damage per Level"
			Blue_Fireball
				KidouRank=33;Incantation="Soukatsui"
				icon_state="Blue Fireball";desc="Fires blue fire blasts at the target. > Deals 100+Kidou+Mgc Mystic Damage each for 250 Rei total"
				LevelDesc="+1 Blast & +25% Damage per Level"
			Incinerating_Flame
				KidouRank=54;Incantation="Haien"
				icon_state="Incinerating Flame";desc="Completely detroys a target by burning it to ash. > Deals 300+Kidou+Mgc Mystic Damage for 200 Rei"
				LevelDesc="+25% Damage per Level"
			Roaring_Thunder_Burn
				KidouRank=63;Incantation="Raikouhou"
				icon_state="Roaring Thunder Burn";desc="Calls forth a wave of thunder that seeks the target. > Deals 250+Kidou+Mgc Mystic Damage for 150 Rei.  Chance to Paralyze"
				LevelDesc="+5% Paralysis & +25% Damage per Level"
			Black_Coffin
				KidouRank=90;Incantation="Kurohitsugi"
				icon_state="Black Coffin";desc="Summons a black coffin, which surrounds, then severly damages the target. > Deals 1,500+Kidou+Mgc Mystic Damage Consumes 250 Rei"
				LevelDesc="+25% Damage per Level"