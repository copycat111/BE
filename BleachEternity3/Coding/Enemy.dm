datum/DamageKeeper
	var/mob/Dealer
	var/TotalDamage=0

mob/proc
	TrackDamage(var/mob/M,var/Damage)
		for(var/datum/DamageKeeper/K in src.Damagers)
			if(K.Dealer==M)
				K.TotalDamage+=Damage;return
		var/datum/DamageKeeper/K=new()
		K.Dealer=M;K.TotalDamage=Damage
		src.Damagers+=K
	FindMaxDamager()
		var/MaxDamage=0
		var/mob/MaxDamager
		for(var/datum/DamageKeeper/K in src.Damagers)
			if(K.TotalDamage>=MaxDamage && K.Dealer)
				MaxDamager=K.Dealer;MaxDamage=K.TotalDamage
		return MaxDamager

datum/EnemySpoils
	var/ItemPath="/obj/Items/Potions/Energy_Drink"
	var/DropRate=10
	var/Quest
	New(var/NewPath,var/NewDropRate,var/NewQuest)
		if(NewPath)	src.ItemPath=NewPath
		if(NewDropRate) src.DropRate=NewDropRate
		if(NewQuest) src.Quest=NewQuest

mob/proc/LevelShiftEnemy(var/mob/Enemy/E)
	//E.LevelShift(round((initial(E.Level)+src.Level)/2))
	if(src.Level>75 && E.Level>=70)	E.LevelShift(src.Level)
	else	E.LevelShift()

mob/Enemy
	MaxSTM=200
	MaxREI=200
	SpiritForm=1
	SightRange=9
	mouse_opacity=2
	ImmunityBonus=10
	var/mob/StartedBy
	var/mob/TauntedBy
	var/Pulling=0
	var/list/Spoils=list()
	var/list/EnemySkills=list("Attack")
	AttVoices=list('HollowVoice1.wav','HollowVoice2.wav','HollowVoice3.wav')
	HurtVoices=list('HollowVoice1.wav','HollowVoice2.wav','HollowVoice3.wav')
	New()
		src.dir=pick(1,2,4,8)
		src.LevelShift(initial(src.Level))
		//src.DamageIcon=src.icon+rgb(255,0,0)
		//src.GuardIcon=src.icon+rgb(155,155,155)
		src.Spoils+=new/datum/EnemySpoils("/obj/Items/Potions/Energy_Drink",10)
		src.Spoils+=new/datum/EnemySpoils("/obj/Items/Potions/Spirit_Dew",10)
		src.Kidous=AllSpecials
		src.Skills=AllSpecials
		src.Spells=AllSpecials
		src.RespawnX=src.x
		src.RespawnY=src.y
		src.RespawnZ=src.z
		src.x+=rand(-1,1)
		src.y+=rand(-1,1)
		src.StmBar()
		src.AddName()
		src.AddLevel(" ([src.Level])")
		return ..()
	proc
		LevelShift(var/NewLevel)
			//if(src.MultiCore)	src=src.MultiCore
			/*if(NewLevel>initial(src.Level))	src.Level=min(initial(src.Level)+1,NewLevel)	//was +3
			else	src.Level=max(initial(src.Level)-1,NewLevel)*/
			if(NewLevel)	src.Level=NewLevel
			if(src.z==8)	src.Level=NewLevel
			src.ApplyStats()
			src.Damagers=list()
			src.AddLevel(" ([src.Level])")
		EnemyCheck()
			//if(src.MultiCore)	src=src.MultiCore
			for(var/mob/Player/M in oview(EnemyHuntRange,src))
				if(M.client)
					src.TargetMob(M)
					src.StartedBy=M
					M.LevelShiftEnemy(src)
					spawn()	src.EnemyAI()
					return
		EnemyAI()
			//if(src.MultiCore)	src=src.MultiCore
			while(src.StartedBy)
				while(src.Stunned||!src.CanMove)	sleep(5)
				if(!src.Target)
					src.TauntedBy=null;src.StartedBy=null
				else
					if(src.Target.STM<=0)	src.TargetMob(null)
					if(src.Target && src.Target.invisibility)	src.TargetMob(null)
				if(src.TauntedBy && MyGetDist(src,src.TauntedBy)<=15)	src.Target=src.TauntedBy
				var/CurDistance=MyGetDist(src,src.Target)
				if(CurDistance && CurDistance<=src.SightRange)
					if(CurDistance==1)
						src.dir=get_dir(src,src.Target)
						MyFlick("PullBack",src)
						src.Pulling=1
						var/image/I=image('Effects.dmi',src,"CounterStep",src.layer-1,SOUTH)
						if(src.Target.client)	src.Target.client<<I
						sleep(5)
						if(I)	del I
						src.Pulling=0
						MyFlick("Attack",src)
						var/Action2Take="Attack"
						if(rand(1,3)==2)	Action2Take=pick(src.EnemySkills)
						if(Action2Take=="Attack")	src.Attack(rand(1,3))
						else	call(src,"[Action2Take]")()
						spawn(3)	src.dir=get_dir(src,src.Target)
					else
						if(!step_to(src,src.Target,1) && src.z!=8)	src.TargetMob(null)
				else	src.TargetMob(null)
				sleep(5)
			if(src.z==8)	{del src;return}
			src.TargetMob(null)
			if(src.z==src.RespawnZ)
				src.LevelShift(initial(src.Level))
				src.loc=locate(src.RespawnX+rand(-1,1),src.RespawnY+rand(-1,1),src.RespawnZ)
				//src.EnemyCheck()	//aggro after losing target
	Soul_Reapers
		New()
			src.Spoils+=new/datum/EnemySpoils("/obj/Items/Other/Hollow_Bait",10)
			src.Spoils+=new/datum/EnemySpoils("/obj/Items/EnemySpoils/Onyx",90)
			var/obj/HO=new/obj/HairOver
			HO.icon=pick('ichigo.dmi','toshiro.dmi','urahara.dmi','uryu.dmi','renji.dmi','Byakuya.dmi','Kenpachi.dmi','Izuru.dmi','Maki.dmi','Yoruichi.dmi')
			HO.icon=MyRGB(HO.icon,rgb(rand(0,100),rand(0,100),rand(0,55)))
			src.overlays+=HO
			return ..()
		Students
			icon='SoulReaperEnemy.dmi'
			First_Year_Student
				Level=3
	Hollows
		New()
			src.Spoils+=new/datum/EnemySpoils("/obj/Items/EnemySpoils/Hollow_Mask",10)
			src.Spoils+=new/datum/EnemySpoils("/obj/Items/EnemySpoils/Cracked_Hollow_Mask",10)
			src.Spoils+=new/datum/EnemySpoils("/obj/Items/EnemySpoils/Shattered_Hollow_Mask",10)
			return ..()
		Flyte
			Level=1
			icon='FlyingHollow.dmi'
		Pounder
			Level=1
			icon='GroundHollow.dmi'
		Flying_Hollow
			Level=2
			icon='FlyingAntiHollow.dmi'
			EnemySkills=list("Woosh")
		Ground_Hollow
			Level=2
			icon='GroundAntiHollow.dmi'
			EnemySkills=list("Slam")
		//arial outpost
		Spyder
			Level=4
			icon='SpiderHollow.dmi'
			New()
				src.Spoils+=new/datum/EnemySpoils("/obj/Items/EnemySpoils/Spider_Legs",90)
				return ..()
		Mantaur
			Level=5
			icon='MantisHollow.dmi'
		Treezer
			Level=6
			icon='Treezer.dmi'
		Slithar
			Level=7
			icon='SerpentHollow.dmi'
		Sea_Spine
			Level=8
			icon='SeaSpine.dmi'
		Spire_Gull
			Level=9
			icon='SpireGull.dmi'
			EnemySkills=list("Woosh")
		Tadite
			Level=10
			icon='TadPoleHollow.dmi'
			EnemySkills=list("Cry for Help")
		Frogling
			Level=11
			icon='FrogHollow.dmi'
		Wulf
			Level=12
			icon='WolfHollow.dmi'
		Howler
			Level=13
			icon='HowlerHollow.dmi'
		Growler
			Level=14
			icon='GrowlerHollow.dmi'
		Squishy
			Level=15
			icon='SquishyHollow.dmi'
			EnemySkills=list("Cry for Help")
		//sewers
		Gator
			Level=16
			icon='Gator.dmi'
			Element="Water";ElemStrength=list("Water");ElemWeakness=list("Lightning")
		Ratt
			Level=17
			icon='Ratt.dmi'
			EnemySkills=list("Cry for Help")
		Sewer_Bat
			Level=18
			icon='SewerBat.dmi'
			EnemySkills=list("Woosh")
			Element="Wind";ElemStrength=list("Wind");ElemWeakness=list("Earth")
			New()
				src.Spoils+=new/datum/EnemySpoils("/obj/Items/EnemySpoils/Bat_Guano",90)
				return ..()
		Sewer_Spider
			Level=19
			icon='SewerSpider.dmi'
		Gekko
			Level=20
			icon='Gekko.dmi'
		Giant_Lizard
			Level=21
			icon='PlaceHolderEnemy.dmi'
		Lost_Hobo
			Level=22
			icon='PlaceHolderEnemy.dmi'
			New()
				src.Spoils+=new/datum/EnemySpoils("/obj/Items/EnemySpoils/Ham_Sandwich",90)
				return ..()
		Walking_Corpse
			Level=23
			icon='PlaceHolderEnemy.dmi'
		Skeleton_Brute
			Level=24
			icon='SkeletonBrute.dmi'
		Skeletal_Knight
			Level=25
			icon='PlaceHolderEnemy.dmi'
		Goblin
			Level=26
			icon='PlaceHolderEnemy.dmi'
			EnemySkills=list("Cry for Help")
		Goblin_Raider
			Level=27
			icon='PlaceHolderEnemy.dmi'
			EnemySkills=list("Cry for Help")
		Slime
			Level=28
			icon='PlaceHolderEnemy.dmi'
		Sludge
			Level=29
			icon='PlaceHolderEnemy.dmi'
		Roach_Coach
			Level=30
			icon='PlaceHolderEnemy.dmi'
		//karkura
		Deady_Teddy
			Level=31
			icon='BearHollow.dmi'
			Element="Earth";ElemStrength=list("Earth");ElemWeakness=list("Wind")
		Skorepeon
			Level=32
			icon='ScorpionHollow.dmi'
			Element="Earth";ElemStrength=list("Earth");ElemWeakness=list("Wind")
		//ice cavern
		Freezer
			Level=33
			icon='Freezer.dmi'
			Element="Ice";ElemStrength=list("Ice");ElemWeakness=list("Fire")
		Arctic_Wulf
			Level=34
			icon='ArcticWulf.dmi'
			Element="Ice";ElemStrength=list("Ice");ElemWeakness=list("Fire")
		Shivering_Flame
			Level=35
			icon='ShiveringFlame.dmi'
			Element="Ice";ElemStrength=list("Ice");ElemWeakness=list("Fire")
		Icicle_Knight
			Level=36
			icon='IcicleKnight.dmi'
			Element="Ice";ElemStrength=list("Ice");ElemWeakness=list("Fire")
		//ever forest
		Treen
			icon='Treen.dmi'
			Element="Earth";ElemStrength=list("Earth");ElemWeakness=list("Wind")
			Level=37
			New()
				src.Spoils+=new/datum/EnemySpoils("/obj/Items/EnemySpoils/Treen_Arms",90)
				return ..()
		Fly_Snap
			Level=38
			icon='FlyTrap.dmi'
			Element="Wind";ElemStrength=list("Wind");ElemWeakness=list("Earth")
		Lost_Vines
			Level=39
			icon='VineBall.dmi'
			Element="Wind";ElemStrength=list("Wind");ElemWeakness=list("Earth")
			New()
				src.Spoils+=new/datum/EnemySpoils("/obj/Items/EnemySpoils/Tangled_Vine",90)
				return ..()
		Scruffy
			Level=40
			icon='Scruffy.dmi'
		Beast
			Level=41
			icon='Beast.dmi'
		Shroom
			Level=42
			icon='Mushroom.dmi'
			EnemySkills=list("Poison Cloud","Cry for Help")
			Element="Earth";ElemStrength=list("Earth","Water");ElemWeakness=list("Fire")
		Turtle_Spider
			Level=43
			icon='TurtleSpider.dmi'
			Element="Water";ElemStrength=list("Water");ElemWeakness=list("Lightning")
		Forest_Snail
			Level=44
			icon='TreeSnail.dmi'
			Element="Earth";ElemStrength=list("Earth");ElemWeakness=list("Wind","Ice")
		Forest_Bat
			Level=45
			icon='BrownBat.dmi'
			EnemySkills=list("Woosh")
			Element="Wind";ElemStrength=list("Wind");ElemWeakness=list("Earth")
		Gorilla
			Level=46
			icon='PlaceHolderEnemy.dmi'
			Element="Earth";ElemStrength=list("Earth");ElemWeakness=list("Wind")
		Crocogator
			Level=47
			icon='PlaceHolderEnemy.dmi'
			Element="Water";ElemStrength=list("Water");ElemWeakness=list("Lightning")
		Giant_Croc
			Level=48
			icon='PlaceHolderEnemy.dmi'
			Element="Water";ElemStrength=list("Water");ElemWeakness=list("Lightning")
		Grand_Wasp
			Level=49
			icon='PlaceHolderEnemy.dmi'
			EnemySkills=list("Woosh","Sting")
			Element="Wind";ElemStrength=list("Wind");ElemWeakness=list("Earth")
		Emerald_Beetle
			Level=50
			icon='PlaceHolderEnemy.dmi'
			Element="Earth";ElemStrength=list("Earth");ElemWeakness=list("Wind","Lightning")
		Forest_Critter
			Level=51
			icon='PlaceHolderEnemy.dmi'
		Wild_Mongoose
			Level=52
			icon='PlaceHolderEnemy.dmi'
		Tree_Frog
			Level=53
			icon='PlaceHolderEnemy.dmi'
			Element="Earth";ElemStrength=list("Earth");ElemWeakness=list("Wind","Water","Fire")
		//volcanic enclave
		Lava_Ball
			Level=54
			icon='LavaBall.dmi'
			Element="Fire";ElemStrength=list("Fire");ElemWeakness=list("Ice")
			New()
				src.Spoils+=new/datum/EnemySpoils("/obj/Items/EnemySpoils/Flaming_Crystal",90)
				return ..()
		Fire_Walker
			Level=55
			icon='FireWalker.dmi'
			Element="Fire";ElemStrength=list("Fire");ElemWeakness=list("Ice")
			New()
				src.Spoils+=new/datum/EnemySpoils("/obj/Items/EnemySpoils/Flaming_Crystal",90)
				return ..()
		Burning_Blob
			Level=56
			icon='BurningBlob.dmi'
			Element="Fire";ElemStrength=list("Fire");ElemWeakness=list("Ice")
			New()
				src.Spoils+=new/datum/EnemySpoils("/obj/Items/EnemySpoils/Flaming_Crystal",90)
				return ..()
		Fire_Bat
			Level=57
			icon='FireBat.dmi'
			EnemySkills=list("Woosh")
			Element="Wind";ElemStrength=list("Wind","Fire");ElemWeakness=list("Earth","Ice")
			New()
				src.Spoils+=new/datum/EnemySpoils("/obj/Items/EnemySpoils/Flaming_Crystal",90)
				return ..()
		Heated_Stinger
			Level=58
			icon='HeatedStinger.dmi'
			EnemySkills=list("Sting")
			Element="Earth";ElemStrength=list("Earth","Fire");ElemWeakness=list("Wind","Ice")
			New()
				src.Spoils+=new/datum/EnemySpoils("/obj/Items/EnemySpoils/Flaming_Crystal",90)
				return ..()
		Rock_Lava
			Level=59
			icon='RockLava.dmi'
			EnemySkills=list("Slam")
			Element="Earth";ElemStrength=list("Fire","Earth");ElemWeakness=list("Ice","Wind")
			New()
				src.Spoils+=new/datum/EnemySpoils("/obj/Items/EnemySpoils/Flaming_Crystal",90)
				return ..()
		Salamander
			Level=60
			icon='PlaceHolderEnemy.dmi'
			Element="Earth";ElemStrength=list("Earth");ElemWeakness=list("Wind")
		Ember_Dragon
			Level=61
			icon='PlaceHolderEnemy.dmi'
			EnemySkills=list("Woosh")
			Element="Fire";ElemStrength=list("Fire");ElemWeakness=list("Ice")
			New()
				src.Spoils+=new/datum/EnemySpoils("/obj/Items/EnemySpoils/Flaming_Crystal",90)
				return ..()
		Crested_Turtle
			Level=62
			icon='PlaceHolderEnemy.dmi'
			Element="Earth";ElemStrength=list("Earth");ElemWeakness=list("Wind")
		Porcupine
			Level=63
			icon='PlaceHolderEnemy.dmi'
			EnemySkills=list("Cry for Help")
			Element="Earth";ElemStrength=list("Earth");ElemWeakness=list("Wind")
		Volcanite
			Level=64
			icon='PlaceHolderEnemy.dmi'
			Element="Fire";ElemStrength=list("Earth","Fire");ElemWeakness=list("Wind","Ice")
			New()
				src.Spoils+=new/datum/EnemySpoils("/obj/Items/EnemySpoils/Flaming_Crystal",90)
				return ..()
		Crimson_Crystal
			Level=65
			icon='PlaceHolderEnemy.dmi'
			Element="Fire";ElemStrength=list("Fire");ElemWeakness=list("Ice")
			New()
				src.Spoils+=new/datum/EnemySpoils("/obj/Items/EnemySpoils/Flaming_Crystal",90)
				return ..()
		Flaming_Boar
			Level=66
			icon='PlaceHolderEnemy.dmi'
			Element="Fire";ElemStrength=list("Fire");ElemWeakness=list("Ice")
			New()
				src.Spoils+=new/datum/EnemySpoils("/obj/Items/EnemySpoils/Flaming_Crystal",90)
				return ..()
		Hellz_Hopper
			Level=67
			icon='PlaceHolderEnemy.dmi'
			EnemySkills=list("Cry for Help")
			Element="Fire";ElemStrength=list("Fire");ElemWeakness=list("Ice")
			New()
				src.Spoils+=new/datum/EnemySpoils("/obj/Items/EnemySpoils/Flaming_Crystal",90)
				return ..()
		Lava_Bubble
			Level=68
			icon='PlaceHolderEnemy.dmi'
			Element="Fire";ElemStrength=list("Fire");ElemWeakness=list("Ice")
			New()
				src.Spoils+=new/datum/EnemySpoils("/obj/Items/EnemySpoils/Flaming_Crystal",90)
				return ..()
		Molten_Man
			Level=69
			icon='PlaceHolderEnemy.dmi'
			Element="Fire";ElemStrength=list("Fire");ElemWeakness=list("Ice")
			New()
				src.Spoils+=new/datum/EnemySpoils("/obj/Items/EnemySpoils/Flaming_Crystal",90)
				return ..()
		Molten_Slug
			Level=70
			icon='PlaceHolderEnemy.dmi'
			Element="Fire";ElemStrength=list("Fire");ElemWeakness=list("Ice")
			New()
				src.Spoils+=new/datum/EnemySpoils("/obj/Items/EnemySpoils/Flaming_Crystal",90)
				return ..()
		Lava_Puddle
			Level=71
			icon='PlaceHolderEnemy.dmi'
			Element="Fire";ElemStrength=list("Fire");ElemWeakness=list("Ice")
			New()
				src.Spoils+=new/datum/EnemySpoils("/obj/Items/EnemySpoils/Flaming_Crystal",90)
				return ..()
		Hellion_Harpy
			Level=72
			icon='PlaceHolderEnemy.dmi'
			EnemySkills=list("Woosh")
			Element="Wind";ElemStrength=list("Wind","Fire");ElemWeakness=list("Ice","Earth")
		Eruptor
			Level=73
			icon='PlaceHolderEnemy.dmi'
			Element="Fire";ElemStrength=list("Fire");ElemWeakness=list("Ice")
			New()
				src.Spoils+=new/datum/EnemySpoils("/obj/Items/EnemySpoils/Flaming_Crystal",90)
				return ..()
		Solidified_Golem
			Level=74
			icon='PlaceHolderEnemy.dmi'
			Element="Earth";ElemStrength=list("Earth","Fire");ElemWeakness=list("Wind","Ice")
		//un-used
		Cyclops
			Level=75
			EnemySkills=list("Slam")
			icon='PlaceHolderEnemy.dmi'
		Cyclops_Eye
			Level=76
			icon='PlaceHolderEnemy.dmi'
			Element="Earth";ElemStrength=list("Earth");ElemWeakness=list("Wind")

	Bosses
		ImmunityBonus=100
		EnemySkills=list("Spirit Blast")
		Frawg
			EnemySkills=list("Attack")
			icon='Frawg.dmi'
			Level=15
		Urahara
			icon='NPCUrahara.dmi'
			Level=20
		Roach_Lord
			icon='PlaceHolderEnemy.dmi'
			Level=30
		Ice_Golem
			Element="Ice";ElemStrength=list("Ice");ElemWeakness=list("Fire")
			EnemySkills=list("Freeze Ring")
			icon='IceGolem.dmi'
			Level=35
		Zanpakuto_Spirit
			icon='ZanSpirit.dmi'
			Level=50
		Kenyan_Mangrove_Crab
			icon='KenyanMangroveCrab.dmi'
			Level=55
		Phoenix
			Level=75
			icon='PlaceHolderEnemy.dmi'
			Element="Fire";ElemStrength=list("Fire");ElemWeakness=list("Ice")

	Epics
		ImmunityBonus=100
