client
	MouseDrop(obj/src_object,obj/over_object,src_location,over_location)
		if(istype(src_object,/obj/Items/Equipment)&&istype(over_object,/obj/HUD/Inventory/EquipmentSlot))
			if(!(src_object in usr.Inventory))	return
			if(src_object:Slot==over_object:EQSlot)	//Empty Equip
				if(usr.Level<src_object:LvlReq)
					QuestShow(usr,"[src_object] requires level [src_object:LvlReq]");return
				src_object.screen_loc=over_object.screen_loc
				src_object:Equip(usr)
				usr.DisplayInventory()
				return
			else	{QuestShow(usr,"[src_object] must be equipped to the [src_object:Slot] slot");return}
		if(istype(src_object,/obj/Items/Equipment)&&istype(over_object,/obj/HUD/Inventory/ItemBG))
			if(src_object in usr.EquipmentList)
				if(usr.vars[src_object:Slot]==src_object)
					PlayMenuSound(usr,'Bow2.wav')	//Empty UnEquip
					src_object:UnEquip(usr)
					src_object.screen_loc=over_object.screen_loc
					usr.Inventory[over_object:InvSlot]=src_object
					src_object:InvSlot=over_object:InvSlot
					src_object:ScreenX=over_object:ScreenX;src_object:ScreenY=over_object:ScreenY
					usr.DisplayInventory()
					return
		if(istype(src_object,/obj/Items/Equipment)&&istype(over_object,/obj/Items/Equipment))
			if(usr.vars[src_object:Slot]==src_object||usr.vars[over_object:Slot]==over_object)
				if(src_object==over_object)	return	//Equipment Swapping
				if(usr.EquipVsItemCheck(src_object,over_object))	return
				var/obj/Items/Equipment/CurEQ
				var/obj/Items/Equipment/NewEQ
				if(usr.vars[src_object:Slot]==src_object)	{CurEQ=src_object;NewEQ=over_object}
				else	{CurEQ=over_object;NewEQ=src_object}
				if(!(NewEQ in usr.Inventory))	return
				if(usr.Level<NewEQ.LvlReq)
					QuestShow(usr,"[NewEQ] requires level [NewEQ:LvlReq]");return
				CurEQ.UnEquip(usr)
				NewEQ.Equip(usr)
				CurEQ:InvSlot=NewEQ:InvSlot
				usr.Inventory[NewEQ:InvSlot]=CurEQ
				NewEQ.screen_loc=CurEQ.screen_loc
				CurEQ.screen_loc="[NewEQ:ScreenX],[NewEQ:ScreenY]"
				CurEQ:ScreenX=NewEQ:ScreenX;CurEQ:ScreenY=NewEQ:ScreenY
				return
		if(istype(src_object,/obj/Items))	//inventory management
			if(istype(over_object,/obj/HUD/Inventory/InvTrash))
				if(usr.Chatting)	return
				if(!(src_object in usr.Inventory))	return
				if(CustAlert(usr,"Destroy [src_object]?",list("Yes","No"),12,9,17,11)=="Yes")
					usr.RemovalCheck(src_object);usr.GiveGold(0,0,src_object:CurStack);del src_object
				return
			if(istype(over_object,/obj/HUD/Inventory/ItemBG) || istype(over_object,/obj/Items))
				if(src_object==over_object)	return
				if(!(src_object in usr.Inventory))	return
				if(over_object.icon_state=="LockedItemBG")	return
				if(usr.EquipVsItemCheck(src_object,over_object))	return
				PlayMenuSound(usr,'menu.wav')
				var/StartSlot=over_object:InvSlot;var/StartLoc=over_object.screen_loc
				var/StartSX=over_object:ScreenX;var/StartSY=over_object:ScreenY
				usr.Inventory[src_object:InvSlot]=null
				if(usr.Inventory[over_object:InvSlot])
					var/obj/Items/O=usr.Inventory[over_object:InvSlot]
					if(!(O in usr.Inventory))	return
					usr.Inventory[src_object:InvSlot]=O
					O:ScreenX=src_object:ScreenX;O:ScreenY=src_object:ScreenY
					O.InvSlot=src_object:InvSlot;O.screen_loc=src_object.screen_loc
				usr.Inventory[StartSlot]=src_object
				src_object:ScreenX=StartSX;src_object:ScreenY=StartSY
				src_object:InvSlot=StartSlot;src_object.screen_loc=StartLoc
		if(istype(over_object,/obj/HUD/Selected_HotKey))	//hot skill selection
			if(istype(src_object,/obj/HUD/Skill_Display))
				over_object.icon=src_object.icon
				over_object.icon_state=src_object.icon_state
				over_object.mouse_drag_pointer=src_object.icon_state
				usr.HotKeys[over_object:KeyID]=src_object.icon_state
				for(var/obj/HUD/CoolDown/C in src.screen)	if(C.screen_loc==over_object.screen_loc)
					C.SkillRef=over_object.icon_state;C.icon_state=""
		if(istype(over_object,/obj/HUD/Selected_HotKey))	//hot skill swapping
			if(istype(src_object,/obj/HUD/Selected_HotKey))
				var/ThisIcon=over_object.icon
				var/ThisIconState=over_object.icon_state
				over_object.icon=src_object.icon
				over_object.icon_state=src_object.icon_state
				over_object.mouse_drag_pointer=src_object.icon_state
				usr.HotKeys[over_object:KeyID]=src_object.icon_state
				src_object.icon=ThisIcon
				src_object.icon_state=ThisIconState
				src_object.mouse_drag_pointer=ThisIconState
				usr.HotKeys[src_object:KeyID]=ThisIconState
				PlayMenuSound(usr,'menu.wav')
				for(var/obj/HUD/CoolDown/C in src.screen)
					if(C.screen_loc==src_object.screen_loc)
						C.SkillRef=src_object.icon_state;C.icon_state=""
					if(C.screen_loc==over_object.screen_loc)
						C.SkillRef=over_object.icon_state;C.icon_state=""

mob/proc/EquipVsItemCheck(var/obj/src_object,var/obj/over_object)
	if(istype(over_object,/obj/HUD/Inventory/EquipmentSlot))
		if(!istype(src_object,/obj/Items/Equipment))
			QuestShow(src,"[src_object] cannot be equipped.");return 1
		else	if(src_object:Slot!=over_object:EQSlot)
			QuestShow(src,"[src_object] must be equipped to the [src_object:Slot] slot");return 1
	if(istype(over_object,/obj/Items/Equipment)&&src.vars[over_object:Slot]==over_object)
		if(!istype(src_object,/obj/Items/Equipment))
			QuestShow(src,"[src_object] cannot be equipped.");return 1
		else	if(src_object:Slot!=over_object:Slot)
			QuestShow(src,"[src_object] must be equipped to the [src_object:Slot] slot");return 1
	if(istype(src_object,/obj/Items/Equipment)&&src.vars[src_object:Slot]==src_object)
		if(!istype(over_object,/obj/Items/Equipment)&&!istype(over_object,/obj/HUD/Inventory/ItemBG))
			QuestShow(src,"[over_object] cannot be equipped.");return 1
		else	if(src_object:Slot!=over_object:Slot)
			QuestShow(src,"[src_object] must be equipped to the [src_object:Slot] slot");return 1