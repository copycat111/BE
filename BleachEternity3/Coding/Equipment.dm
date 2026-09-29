obj/Items
	Equipment
		HasUse=0
		var/Slot
		MaxStack=1
		var/list/StatBoosts=list()
		var/LvlReq=1
		var/IsEquipped=0
		var/list/Effects=list()
		proc/OnEquip(var/mob/M)	return
		proc/OnUnEquip(var/mob/M)	return
		proc/OnAttack(var/mob/M)	return
		proc/OnDefend(var/mob/M)	return
		proc/Equip(var/mob/M)
			M.Inventory[src.InvSlot]=null
			M.vars[src.Slot]=src
			PlayMenuSound(M,'Bow2.wav')
			M.EquipmentList+=src
			for(var/Stat in src.StatBoosts)	M.vars["[Stat]"]+=src.StatBoosts[Stat]
			src.OnEquip(M)
		proc/UnEquip(var/mob/M)
			src.OnUnEquip(M)
			M.EquipmentList-=src
			for(var/Stat in src.StatBoosts)	M.vars["[Stat]"]-=src.StatBoosts[Stat]
			M.vars[src.Slot]=null
		Feet
			Slot="Feet"
			icon='Boots.dmi'
		Back
			Slot="Back"
			icon='Capes.dmi'
			Crystal_Threaded_Cape
				LvlReq=50
				StatBoosts=list("VIT"=25)
				GoldValue=5;SilvValue=0;CoprValue=0
				desc="A bright red cape.  Threaded with Flaming Crystal fibers. > Increases VIT by 25"
				icon_state="Crystal Threaded Cape";mouse_drag_pointer="Crystal Threaded Cape"
		Head
			Slot="Head"
			icon='Helmets.dmi'
			Toy_Vizard_Mask
				name="Toy Visored Mask"
				icon='BlankVisoredMask.dmi'
				GoldValue=1;SilvValue=0;CoprValue=0
				desc="A paper mache Visored Mask"
				mouse_drag_pointer=""
				OnEquip(var/mob/M)
					M.overlays+=new/obj/EquipmentOverlays/BlankVisoredMask
				OnUnEquip(var/mob/M)
					for(var/x in M.overlays)	if(x:name=="BlankVisoredMask")	M.overlays-=x
		Body
			Slot="Body"
			icon='Robes.dmi'
			Clothes
				LvlReq=1
				StatBoosts=list("VIT"=1)
				GoldValue=0;SilvValue=0;CoprValue=50
				desc="Some plain clothes. > Increases VIT by 1"
				icon_state="Clothes";mouse_drag_pointer="Clothes"
			Mystic
				Cloth_Tunic
					icon_state="Cloth Tunic";mouse_drag_pointer="Cloth Tunic"
					LvlReq=5
				Linen_Robe
					icon_state="Linen Robe";mouse_drag_pointer="Linen Robe"
					LvlReq=10
				Linen_Jacket
					icon_state="Linen Jacket";mouse_drag_pointer="Linen Jacket"
					LvlReq=15
				Silk_Robe
					icon_state="Silk Robe";mouse_drag_pointer="Silk Robe"
					LvlReq=20
				Fire_Tunic
					icon_state="Fire Tunic";mouse_drag_pointer="Fire Tunic"
					LvlReq=25
				Wizard_Robe
					icon_state="Wizard Robe";mouse_drag_pointer="Wizard Robe"
					LvlReq=30
				Holy_Cloak
					icon_state="Holy Cloak";mouse_drag_pointer="Holy Cloak"
					LvlReq=35
				Chameleon_Robe
					icon_state="Chameleon Robe";mouse_drag_pointer="Chameleon Robe"
					LvlReq=40
				Clerics_Robe
					icon_state="Clerics Robe";mouse_drag_pointer="Clerics Robe"
					LvlReq=45
				White_Robe
					icon_state="White Robe";mouse_drag_pointer="White Robe"
					LvlReq=50
				Ceremonial_Uniform
					icon_state="Ceremonial Uniform";mouse_drag_pointer="Ceremonial Uniform"
					LvlReq=55
				Black_Robe
					icon_state="Black Robe";mouse_drag_pointer="Black Robe"
					LvlReq=60
				Golden_Dressings
					icon_state="Golden Dressings";mouse_drag_pointer="Golden Dressings"
					LvlReq=65
				Light_Robe
					icon_state="Light Robe";mouse_drag_pointer="Light Robe"
					LvlReq=70
				Wizard_Outfit
					icon_state="Wizard Outfit";mouse_drag_pointer="Wizard Outfit"
					LvlReq=70
				Brigandine
					icon_state="Brigandine";mouse_drag_pointer="Brigandine"
					LvlReq=70
				Power_Sleeve
					icon_state="Power Sleeve";mouse_drag_pointer="Power Sleeve"
					LvlReq=70
				Earth_Clothes
					icon_state="Earth Clothes";mouse_drag_pointer="Earth Clothes"
					LvlReq=70
				Secret_Clothes
					icon_state="Secret Clothes";mouse_drag_pointer="Secret Clothes"
					LvlReq=70
				Black_Costume
					icon_state="Black Costume";mouse_drag_pointer="Black Costume"
					LvlReq=70
				Rubber_Costume
					icon_state="Rubber Costume";mouse_drag_pointer="Rubber Costume"
					LvlReq=70
				Grand_Cloak
					icon_state="Grand Cloak";mouse_drag_pointer="Grand Cloak"
					LvlReq=75
				Robe_of_Lords
					icon_state="Robe of Lords";mouse_drag_pointer="Robe of Lords"
					LvlReq=80
				Mystic_Plate_Mail
					icon_state="Mystic Plate Mail";mouse_drag_pointer="Mystic Plate Mail"
					LvlReq=85
			Armor
				icon='Armor.dmi'
				Copper_Breastplate
					icon_state="Copper Breastplate";mouse_drag_pointer="Copper Breastplate"
					LvlReq=5
				Leather_Armor
					icon_state="Leather Armor";mouse_drag_pointer="Leather Armor"
					LvlReq=10
				Onyx_Armor
					icon_state="Onyx Armor";mouse_drag_pointer="Onyx Armor"
					LvlReq=15
				Linen_Cuirass
					icon_state="Linen Cuirass";mouse_drag_pointer="Linen Cuirass"
					LvlReq=20
				Iron_Mail
					icon_state="Iron Mail";mouse_drag_pointer="Iron Mail"
					LvlReq=25
				Bronze_Armor
					icon_state="Bronze Armor";mouse_drag_pointer="Bronze Armor"
					LvlReq=30
				Breaker_Gear
					icon_state="Breaker Gear";mouse_drag_pointer="Breaker Gear"
					LvlReq=35
				Chain_Mail
					icon_state="Chain Mail";mouse_drag_pointer="Chain Mail"
					LvlReq=40
				Jade_Encrusted_Armor
					icon_state="Jade Encrusted Armor";mouse_drag_pointer="Jade Encrusted Armor"
					LvlReq=45
				Mythril_Armor
					icon_state="Mythril Armor";mouse_drag_pointer="Mythril Armor"
					LvlReq=50
				Royal_Plate_Mail
					icon_state="Royal Plate Mail";mouse_drag_pointer="Royal Plate Mail"
					LvlReq=55
				Plate_Mail
					icon_state="Plate Mail";mouse_drag_pointer="Plate Mail"
					LvlReq=60
				Guardians_Uniform
					icon_state="Guardians Uniform";mouse_drag_pointer="Guardians Uniform"
					LvlReq=65
				Gold_Armor
					icon_state="Gold Armor";mouse_drag_pointer="Gold Armor"
					LvlReq=70
				Blackened_Breastplate
					icon_state="Blackened Breastplate";mouse_drag_pointer="Blackened Breastplate"
					LvlReq=75
				Diamond_Armor
					icon_state="Diamond Armor";mouse_drag_pointer="Diamond Armor"
					LvlReq=80
				Oblivions_Darkest
					icon_state="Oblivions Darkest";mouse_drag_pointer="Oblivions Darkest"
					LvlReq=85
				Platinum_Armor
					icon_state="Platinum Armor";mouse_drag_pointer="Platinum Armor"
					LvlReq=90
				Leather_Outfit
					icon_state="Leather Outfit";mouse_drag_pointer="Leather Outfit"
					LvlReq=90
				Leather_Vest
					icon_state="Leather Vest";mouse_drag_pointer="Leather Vest"
					LvlReq=90
				Chain_Vest
					icon_state="Chain Vest";mouse_drag_pointer="Chain Vest"
					LvlReq=90
				Mythril_Vest
					icon_state="Mythril Vest";mouse_drag_pointer="Mythril Vest"
					LvlReq=90
				Adamant_Vest
					icon_state="Adamant Vest";mouse_drag_pointer="Adamant Vest"
					LvlReq=90
				Judo_Outfit
					icon_state="Judo Outfit";mouse_drag_pointer="Judo Outfit"
					LvlReq=90
				Carbani_Armor
					icon_state="Carbani Armor";mouse_drag_pointer="Carbani Armor"
					LvlReq=100

				Crystal_Mail
					icon_state="Crystal Mail";mouse_drag_pointer="Crystal Mail"
					LvlReq=110

				Genji_Armor
					icon_state="Genji Armor";mouse_drag_pointer="Genji Armor"
					LvlReq=120

				Reflect_Armor
					icon_state="Reflect Armor";mouse_drag_pointer="Reflect Armor"
					LvlReq=130

				Maximillian
					icon_state="Maximillian";mouse_drag_pointer="Maximillian"
					LvlReq=140
		Hand
			Slot="Hand"
			Weapons
				icon='Weapons.dmi'
				Sword
					StatBoosts=list("STR"=1)
					GoldValue=0;SilvValue=1;CoprValue=50
					desc="A basic sword. > Increases STR by 1"
					icon_state="Sword";mouse_drag_pointer="Sword"
				Rapier
					StatBoosts=list("STR"=2)
					GoldValue=0;SilvValue=3;CoprValue=0
					desc="A sharp sword, designed for stabbing. > Increases STR by 2"
					icon_state="Rapier";mouse_drag_pointer="Rapier"
				Golden_Blade
					icon_state="Golden Blade";mouse_drag_pointer="Golden Blade"
				Save_the_Queen
					icon_state="Save the Queen";mouse_drag_pointer="Save the Queen"
				Falchion
					icon_state="Falchion";mouse_drag_pointer="Falchion"
				Schimitar
					icon_state="Schimitar";mouse_drag_pointer="Schimitar"
				Cross_Sword
					icon_state="Cross Sword";mouse_drag_pointer="Cross Sword"
				Brightest_Night
					icon_state="Brightest Night";mouse_drag_pointer="Brightest Night"
				Excalibur
					icon_state="Excalibur";mouse_drag_pointer="Excalibur"
				Fairy_Club
					icon_state="Fairy Club";mouse_drag_pointer="Fairy Club"
				Dirk_of_Despair
					icon_state="Dirk of Despair";mouse_drag_pointer="Dirk of Despair"
				Black_Hearted_Dagger
					icon_state="Black Hearted Dagger";mouse_drag_pointer="Black Hearted Dagger"
				Glove_of_Despair
					icon_state="Glove of Despair";mouse_drag_pointer="Glove of Despair"
				Padded_Claws
					icon_state="Padded Claws";mouse_drag_pointer="Padded Claws"
				Golden_Knuckles
					icon_state="Golden Knuckles";mouse_drag_pointer="Golden Knuckles"
				Diamond_Knuckles
					icon_state="Diamond Knuckles";mouse_drag_pointer="Diamond Knuckles"
				Dark_Scepter
					icon_state="Dark Scepter";mouse_drag_pointer="Dark Scepter"
				Iron_Thorn_Whip
					icon_state="Iron Thorn Whip";mouse_drag_pointer="Iron Thorn Whip"
				Chain_Whip
					icon_state="Chain Whip";mouse_drag_pointer="Chain Whip"
				Silver_Tipped_Whip
					icon_state="Silver Tipped Whip";mouse_drag_pointer="Silver Tipped Whip"
				Whip_Tail
					icon_state="Whip Tail";mouse_drag_pointer="Whip Tail"
				Metalic_Whip
					icon_state="Metalic Whip";mouse_drag_pointer="Metalic Whip"
				Leviathans_Tail
					icon_state="Leviathans Tail";mouse_drag_pointer="Leviathans Tail"
				Serpents_Tongue
					icon_state="Serpents Tongue";mouse_drag_pointer="Serpents Tongue"
				Boomerang
					icon_state="Boomerang";mouse_drag_pointer="Boomerang"
				Seeker
					icon_state="Seeker";mouse_drag_pointer="Seeker"
				Mystic_Boomerang
					icon_state="Mystic Boomerang";mouse_drag_pointer="Mystic Boomerang"
				White_Whale
					icon_state="White Whale";mouse_drag_pointer="White Whale"
				Wooden_Boomerang
					icon_state="Wooden Boomerang";mouse_drag_pointer="Wooden Boomerang"
				Ax
					icon_state="Ax";mouse_drag_pointer="Ax"
				Ice_Ax
					icon_state="Ice Ax";mouse_drag_pointer="Ice Ax"
				Ax_of_Despair
					icon_state="Ax of Despair";mouse_drag_pointer="Ax of Despair"
				Axe
					icon_state="Axe";mouse_drag_pointer="Axe"
				Silver_Axe
					icon_state="Silver Axe";mouse_drag_pointer="Silver Axe"
				Club
					icon_state="Club";mouse_drag_pointer="Club"
				Spiked_Club
					icon_state="Spiked Club";mouse_drag_pointer="Spiked Club"
				Ice_Club
					icon_state="Ice Club";mouse_drag_pointer="Ice Club"
				Shuriken
					icon_state="Shuriken";mouse_drag_pointer="Shuriken"
				Emperors_Mallet
					icon_state="Emperors Mallet";mouse_drag_pointer="Emperors Mallet"
				Wand_of_Despair
					icon_state="Wand of Despair";mouse_drag_pointer="Wand of Despair"
				Cane
					StatBoosts=list("MGC"=1)
					GoldValue=0;SilvValue=1;CoprValue=50
					desc="A basic cane. > Increases MGC by 1"
					icon_state="Cane";mouse_drag_pointer="Cane"
				Metal_Cane
					StatBoosts=list("MGC"=2)
					GoldValue=0;SilvValue=3;CoprValue=0
					desc="A shiney metal cane. > Increases MGC by 2"
					icon_state="Metal Cane";mouse_drag_pointer="Metal Cane"
				Hunters_Spear
					icon_state="Hunters Spear";mouse_drag_pointer="Hunters Spear"
				Harpoon
					icon_state="Harpoon";mouse_drag_pointer="Harpoon"
				Deepest_Dawn
					icon_state="Deepest Dawn";mouse_drag_pointer="Deepest Dawn"