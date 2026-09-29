turf
	AlwaysFlashStep
		layer=20;mouse_opacity=2
		DblClick()
			if(usr.Stunned || usr.TurnMode==2 || usr.SkillBeingCharged)	return
			if(!usr.SpiritForm || MyGetDist(usr,src)<=1)	return
			MyFlick("Warp",usr);usr.dir=get_dir(usr,src);usr.loc=src
	var/Phase=0
	var/DensityChecked=0
	proc/CheckHalfDensity()	//Sets density for partial edges over dense objects
		if(src.DensityChecked)	return
		src.DensityChecked=1
		for(var/x in src.underlays)	if(x:name!=src.name)
			for(var/turf/T in world)	if(T.name==x:name)
				src.density=T.density;return
	DblClick()
		if(!usr.SpiritForm)	return
		if(usr.Stunned)	return
		if(MyGetDist(src,usr)<=1)	return
		if(usr.TurnMode==2)	return
		if(usr.SkillBeingCharged)	return
		if(usr.CanShunpo)
			if(src in oview(9,usr))
				if(src.Enter(usr))
					//var/LastDir=0;if(usr.Target)	LastDir=usr.Target.dir
					var/LastDir=usr.dir
					var/atom/Stepy=usr
					if(usr.TurnMode==1)	Stepy=new/mob(usr.loc)
					if(step_to(Stepy,src,0))
						MyFlick("Warp",usr)
						usr.dir=get_dir(usr,src)
						usr.loc=src;usr.EnemyStart(EnemyHuntRange,usr.loc)
						if(usr.Target)
							//usr.Target.dir=LastDir
							//if(usr.Target.AGI>=usr.AGI)	usr.Target.dir=get_dir(usr.Target,usr)
							if(!MyGetDist(usr,usr.Target)||MyGetDist(usr,usr.Target)>usr.SightRange)	usr.TargetMob(null)
							else	usr.dir=get_dir(usr,usr.Target)
					else	usr.dir=LastDir
					if(Stepy!=usr)	del Stepy

turf
	Doors
		var/newx=50
		var/newy=50
		var/newz=1
		var/newdir=0
		Door
			Entered(mob/M)
				if(ismob(M) && M.client)
					sleep(8);if(!M)	return
					if(M.loc==src)
						M.loc=locate(src.newx,src.newy,src.newz)
						if(src.newdir)	M.dir=src.newdir
		Tutorial_Exit
			Entered(mob/M)
				sleep(8)
				ShowEffect(src,'Effects.dmi',"PortalFlash","",4)
				sleep(3)
				if(!M)	return
				if(M.loc==locate(src.x,src.y,src.z))
					M.loc=locate(src.newx,src.newy,src.newz)
					if(src.newdir)	M.dir=src.newdir
					M.SetRespawn();M.TutLevel=5
area
	DenseOpacity
		icon='turfs.dmi'
		icon_state="Black"
		density=1
		opacity=1
		layer=3
	Supplemental
		White
			icon='turfs.dmi'
			icon_state="White"
	Density
		density=1
		layer=10
	RedGlow
		mouse_opacity=0
		icon='Lava.dmi';icon_state="RedGlow"
		New()
			src.layer=9.1;return ..()

obj/Decoration
	icon='Decoration.dmi'
	density=1
	Shadow_Edges
		icon='Karakura.dmi'
		icon_state="ShadowEdges"
		layer=9
		mouse_opacity=0
		density=0
	Uraharas_Shop
		icon='Uraharas.dmi'
		icon_state="Sign1"
		pixel_y=6
		layer=8
	Bush
		icon='karakura.dmi'
		icon_state="Bush"
		pixel_y=4
	Shadow
		icon='Shadow.dmi'
		mouse_opacity=0
		density=0
		layer=7
	Railing
		icon='SSTurfs.dmi'
		icon_state="RedRailing"
		density=0
		layer=8
	TableShadow
		icon_state="TableShadow"
		mouse_opacity=0
		density=0
		layer=2
		pixel_y=8
	Interior_Decoration
		density=1;icon_state="GraplingHook"
		icon='Interior.dmi'
		GraplingHook
		Table
			icon_state="Table"
		BigTable
			icon_state="TableTL"
		Chair
			density=0;icon_state="ChairT"
		Crate
			icon_state="Crate"
		CrateLoop
			icon_state="CrateLoopB"
		Barrel
			icon_state="Barrel"
		Spears
			icon_state="SpearsB"
		MooseHead
			icon_state="MooseHead"
		Shield
			icon_state="Shield"
		Mirror
			icon_state="Mirror"
		Document
			icon_state="Document"
		Salt
			icon_state="Salt"
		Turkey
			icon_state="Turkey"
		Cake
			icon_state="Cake"
		TheCakeIsALie
			icon_state="TheCakeIsALie"
		Wine
			icon_state="Wine"
		Dresser
			icon_state="Dresser"
		Cabinet
			icon_state="Cabinet"
		EndTable
			icon_state="EndTable"
		Bed
			density=0
			icon_state="BedT"
		Flowers
			icon_state="Flowers"
		HangingPlant
			icon_state="HangingPlant"
		PottedPlant
			icon_state="PottedPlant"
		Coffee
			icon_state="Coffee"
		Lanterns
			icon_state="Lanterns"
		Urn
			icon_state="Urn"
		Vase
			icon_state="Vase"
		Picture
			icon_state="Picture1"
		Axes
			icon_state="Axes"
		Spices
			icon_state="Spices"
		Basket
			icon_state="Basket1"
		Vase
			icon_state="Vase"
		JunkPile
			icon_state="JunkPile"
		Pot
			icon_state="Pot"


turf
	icon='Turfs.dmi'
	Roofs
		icon='Turfs.dmi'
		SS_Roof
			icon_state="Top"
			density=0
			layer=15
			Phase=1
	Decoration
		icon='Decoration.dmi'
		density=1
		Table
			icon_state="Table"
			layer=4
		Chair
			icon_state="Chair"
			density=0
			layer=3
		Bed
			icon_state="BedT"
		Tree
			icon='Tree.dmi'
			icon_state="1"
			density=0
			layer=8
		Carpet1
			icon='Carpet1.dmi';icon_state="TL"
			density=0
		Carpet2
			icon='Carpet2.dmi';icon_state="TL"
			density=0
	Volcanic_Enclave
		icon='Lava.dmi'
		Lava
			density=1
			icon_state="Lava"
		Ground
			icon_state="Ground"
		Lava_Cliffs
			density=1
			icon='LavaCliffs.dmi';icon_state="Cliff"
		CliffTops
			layer=9
			icon='LavaCliffs.dmi';icon_state="T"
		CliffTopsDense
			layer=9;density=1
			icon='LavaCliffs.dmi';icon_state="T"
	Jungle
		icon='Jungle.dmi'
		Grass
			icon_state="Grass"
			Enter()
				src.CheckHalfDensity();return ..()
		Dirt
			icon_state="Dirt"
		Bridge
			icon='Bridge.dmi'
			icon_state="M"
		WaterCliff
			density=1
			icon='WaterCliffs.dmi'
			icon_state="Cliff"
		Fence
			icon_state="FenceB"
			density=1
			New()
				if(src.icon_state=="FenceT")	src.icon_state=pick("FenceT","FenceTR")
				if(src.icon_state=="FenceM")	src.icon_state=pick("FenceM","FenceMR")
				if(src.icon_state=="FenceB")	src.icon_state=pick("FenceB","FenceBR")
				return ..()
		Hut
			icon='Hut.dmi'
			icon_state="1"
			density=0;layer=9
		TreeCanopy
			icon_state="CanopyM"
			density=1;layer=9
		TreeTrunk
			icon_state="TreeL"
			density=1
		LargeTree
			icon='JungleTreeL.dmi'
			icon_state="1"
			density=0
			layer=10
		Tree
			icon='JungleTree.dmi'
			icon_state="1"
			density=0
			layer=9
	Arena
		icon='Arena.dmi'
		Wall
			icon_state="Wall"
			density=1
		Counter
			icon_state="Counter"
			density=1
		Floor
			icon_state="Floor"
		Ground
			icon_state="Ground"
		Rope
			icon_state="RopeL"
			density=1
	Sewers
		icon='Sewers.dmi'
		Small_Tiles
			icon_state="SmallTiles"
		Large_Tiles
			icon_state="LargeTiles"
		Bricks
			icon_state="Bricks"
			density=1
		Water_Over
			icon_state="WaterOver"
			density=1
	Caves
		icon='Cave.dmi'
		CaveWall
			density=1
			icon_state="CaveWall"
		Ground
			icon_state="Ground"
		Decoration
			density=1
			Spike
				icon_state="Spike"
			Shard
				icon_state="Shard"
			Crystal
				icon_state="Crystal"
	IceArea
		icon='IceTurfs.dmi'
		Ice
			icon_state="Ice"
		IceWall
			density=1
			icon_state="IceWall"
		Decoration
			density=1
			Spike
				icon_state="Spike"
			Shard
				icon_state="Shard"
			Crystal
				icon_state="Crystal"
	TutorialBlock
		icon='turfs.dmi'
		icon_state="TutorialBlock"
		var/TutLevel=1
		layer=7
		density=1
		LevelOne
			TutLevel=1
			Enter(var/mob/M)
				if(ismob(M))
					if(M.TutLevel>=src.TutLevel)	return 1
					else
						spawn()
							if(ShowAlert(M,"You Must Learn some Game Basics Before Moving Forward",list("Help","Close"))=="Help")
								ShowAlert(M,"Press the F key while Facing an NPC to Interact with them")
		LevelTwo
			TutLevel=2
			Enter(var/mob/M)
				if(ismob(M))
					if(M.TutLevel>=src.TutLevel)	return 1
					else
						spawn()
							if(ShowAlert(M,"You Must Learn Combat Basics Before Moving Forward",list("Help","Close"))=="Help")
								ShowAlert(M,"Press Space Bar to enter Spirit Form, then speak with the Combat Trainer.")
		LevelThree
			TutLevel=3
			Enter(var/mob/M)
				if(ismob(M))
					if(M.TutLevel<3)
						spawn()	ShowAlert(M,"Take the Path to the Right");return
					if(M.TutLevel>=src.TutLevel && usr.StatPoints<=0)	return 1
					else
						spawn()
							if(ShowAlert(M,"You Must Use Stat Points Before Moving Forward",list("Help","Close"))=="Help")
								ShowAlert(M,"Click the Blue LVL Orb at the Top Right of your HUD to Enter the Point Distribution Screen. > > Then Click the STATS Button at the Bottom of the screen. > > Clicking any of the Buttons on the STATS Screen will Add Points to that Stat. > > Choose 'Edit - Small' from the top menu bar if you cannot see the Category Buttons at the bottom of your screen")
		LevelThree2
			TutLevel=3
			Enter(var/mob/M)
				if(ismob(M))
					if(M.TutLevel>=src.TutLevel && usr.CurSkill!="Selected Skill")	return 1
					else
						spawn()
							if(ShowAlert(M,"You Must Select a Skill Before Moving Forward",list("Help","Close"))=="Help")
								ShowAlert(M,"Click the Active Skill HUD Icon (The 'A' Box Under your REI Display) > > Then Click a Skill from the Drop Down to Select it > > Press the A key to Use This Skill > > Drag Skills from the Drop Down to HotKey Them")
		LevelFour
			TutLevel=4
			Enter(var/mob/M)
				if(ismob(M))
					if(M.TutLevel>=src.TutLevel)	return 1
					else
						spawn()
							ShowText(M,"You Must Complete the Tutorial Before Moving Forward!");return
		Entered(var/mob/M)
			if(ismob(M))
				ShowEffect(src,'Effects.dmi',"BodyRing",src,5,0)
	MonsterBlock
		layer=7
		density=1
		icon_state="MonsterBlock"
		Entered(var/mob/M)
			if(ismob(M))
				ShowEffect(src,'Effects.dmi',"BodyRing",src,5,0)
		Enter(var/mob/M)
			if(ismob(M))
				if(M in oview(1,src))
					if(M.client)
						if(!M.SpiritForm)	M.SpiritForm()
						if(M.SpiritForm)	return 1
	Supplemental
		NoDensity
			density=0
			layer=10
		AllPass
			Enter()
				return 1
		Density
			density=1
			layer=10
		Black
			icon_state="Black"
			density=1
		Portal
			icon='Effects.dmi'
			icon_state="MyPortal"
	Uraharas
		icon='Uraharas.dmi'
		density=1
		Door
			icon_state="Door"
			density=0
		Wall
			icon_state="Wall"
		Roof
			icon_state="Roof"
		Window
			icon_state="Window"
		Gutter
			icon_state="Gutter"
			layer=8
	Karakura
		icon='karakura.dmi'
		density=1
		Door
			icon_state="Door"
		Bricks
			icon_state="Bricks"
		Siding
			icon_state="Siding"
		Gate
			icon_state="Gate"
		Fence
			icon_state="Fence"
		Wall
			icon_state="InteriorB"
		Window
			icon_state="WindowDoor"
		Sign
			icon_state="Sign2"
	SS
		icon='SSTurfs.dmi'
		density=1
		Fuzzy_Grass
			icon_state="FuzzyGrass"
		Cliff
			icon_state="Cliff"
		Sky
			icon_state="Sky"
		OrangeRoof
			icon_state="OrangeRoofL"
		Floor
			icon_state="HallwayFloor"
			density=0
		Wall
			icon_state="Wall"
		Red
			icon_state="Red"
		Edging
			icon_state="BrownRailingR"
			layer=5
		Red_Railing
			icon_state="RedRailing"
			density=0
			layer=9
	Soul_Society
		Road
			icon_state="Road"
		Yellow_Line
			icon_state="LineVert"
		Stairs
			icon_state="StairsUp"
		Grass
			icon_state="Grass"
		Dirt
			icon_state="Dirt"
		Street
			icon_state="asphalt"
		LineH
			icon_state="horiz.line"
		LineV
			icon_state="vert.line"
		SideWalk
			icon_state="SideWalk"
		WoodenFloor
			icon_state="woodfloor"
		Building
			icon_state="Building"
			density=1
		Top
			icon_state="Top"
			density=1
		Water
			icon='Water.dmi'
			icon_state="Water"
			density=1
			New()
				if(src.icon_state=="WaterFall")	src.icon_state=pick("WaterFall","WaterFallF","WaterFallF","WaterFallF")
				return ..()
		Fence
			icon_state="Fence"
			density=1
			New()
				if(rand(1,5)==5)	new/obj/Decoration/Interior_Decoration/HangingPlant(src)
				return ..()
		Sand
			icon_state="Sand"
	Diagnostic
		Building_Phase
			icon='Phase.png'
		Shadows
			icon='Shadows.png'
		BackButton
			icon='HUD.dmi'
			icon_state="BackL"
			Click()
				PlayMenuSound(usr,'OOT_MainMenu_Cancel.wav')
				for(var/obj/HUD/UnLearned_Skill/O in usr.client.screen)	del O
				usr.client.eye=usr
		Random_Buttons
