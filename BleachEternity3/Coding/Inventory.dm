mob/var/tmp/Inventory[45]

obj/HUD/Inventory
	ItemBG
		var/InvSlot=1;layer=19
		var/ScreenX;var/ScreenY
		icon_state="ItemBG"
	EquipmentSlot
		var/EQSlot="Hand"
		icon_state="BlankEQSlot"
		var/obj/EQOver=new/obj/HUD/Inventory/EQOver
	EQOver
		mouse_opacity=0
	GoldIcon
		screen_loc="6:7,13:-10"
		icon='Main.dmi';icon_state="Gold"
	SilverIcon
		screen_loc="7:23,13:-10"
		icon='Main.dmi';icon_state="Silver"
	CopperIcon
		screen_loc="9:7,13:-10"
		icon='Main.dmi';icon_state="Copper"
	InvTL
		screen_loc="6,13"
		icon='HUD.dmi';icon_state="InvTL"
	InvT
		screen_loc="7,13 to 13,13"
		icon='HUD.dmi';icon_state="InvT"
	InvTrash
		screen_loc="13,13"
		icon='HUD.dmi';icon_state="InvTrash"
		Click()
			if(!usr.Chatting)	CustAlert(usr,"Trash Bin > > Drag an Item here to Destroy it",list("OK"),12,9,17,11)
	InvTR
		screen_loc="14,13"
		icon='HUD.dmi';icon_state="InvTR"
		Click()
			PlayMenuSound(usr,'menu.wav');usr.ClearInventory()

obj/Supplemental
	InvNumber
		icon='InvNums.dmi';layer=FLOAT_LAYER
		pixel_x=-4;pixel_y=5

obj/Items/proc/UpdateCount(/**/)
	src.overlays=list();var/counter=1
	if(src.CurStack==1)	return
	while(counter<=length("[src.CurStack]"))
		var/obj/NO=new/obj/Supplemental/InvNumber
		NO.icon_state="[copytext(num2text(src.CurStack),counter,counter+1)]"
		NO.pixel_x-=6*(length("[src.CurStack]")-counter)
		src.overlays+=NO;counter+=1

mob/proc/GetItem(var/obj/Items/O)
	var/Received=0
	for(var/obj/Items/I in src.Inventory)
		if(I.type==O.type)
			if(I.Unique)
				QuestShow(src,"You can only carry 1 of these at a time");return Received
			if(I.CurStack<I.MaxStack)
				var/FullStack=I.MaxStack-I.CurStack
				var/ThisStack=min(FullStack,O.CurStack)
				I.CurStack+=ThisStack;I.UpdateCount()
				src.CollectCheck(O);Received+=ThisStack
				O.CurStack-=ThisStack;O.UpdateCount()
				PlaySoundEffect(src,'Menu.wav')
				QuestShow(src,"[O.name] x[ThisStack] Acquired")
				if(O.CurStack<=0)	{del	O;return Received}
	for(var/i=1;i<=45;i++)
		if(i>25)
			QuestShow(src,"[O.name] x[O.CurStack] Lost; Inventory Full");return Received
		if(!src.Inventory[i])
			Received+=O.CurStack
			src.CollectCheck(O);src.Inventory[i]=O
			PlaySoundEffect(src,'Menu.wav')
			QuestShow(src,"[O.name] x[O.CurStack] Acquired")
			if(src.InventoryOpen)	src.DisplayInventory()
			return Received
	return Received

mob/proc/CollectCheck(var/obj/Items/O)
	for(var/datum/QuestDatum/Q in src.Quests)
		for(var/datum/ObjectiveDatum/OB in Q.Objectives)
			if(OB.Objective=="Collect" && O.name==OB.Stat)
				OB.Current+=O.CurStack
				if(OB.Current<=OB.Goal)	src.TrackQuests()
				if(OB.Current==OB.Goal)	src.QuestRefresh()

mob/proc/RemovalCheck(var/obj/Items/O)
	for(var/datum/QuestDatum/Q in src.Quests)
		for(var/datum/ObjectiveDatum/OB in Q.Objectives)
			if(OB.Objective=="Collect" && O.name==OB.Stat)
				OB.Current-=O.CurStack
				if(OB.Current<OB.Goal)	src.TrackQuests()
				if(OB.Current<OB.Goal)	src.QuestRefresh()

mob/proc/ClearInventory()
	if(!src.client)	return
	src.WriteLine(1,1,1,1,"InventoryMsg","",1)
	for(var/obj/HUD/Inventory/I in src.client.screen)	del I
	for(var/obj/Items/O in src.client.screen)	src.client.screen-=O
	src.InventoryOpen=0
	src.Shopping=null
	src.Selling=null

mob/proc/BasicInventory()
	src.client.screen+=new/obj/HUD/Inventory/InvTL
	src.client.screen+=new/obj/HUD/Inventory/InvT
	src.client.screen+=new/obj/HUD/Inventory/InvTR
	src.client.screen+=new/obj/HUD/Inventory/GoldIcon
	src.client.screen+=new/obj/HUD/Inventory/SilverIcon
	src.client.screen+=new/obj/HUD/Inventory/CopperIcon
	src.WriteLine(6,17,13,2,"InventoryMsg","[src.Gold]",0)
	src.WriteLine(8,1,13,2,"InventoryMsg","[src.Silver]",0)
	src.WriteLine(9,17,13,2,"InventoryMsg","[src.Copper]",0)

mob/proc/DisplayShop(var/obj/NPC/Shops/ShopKeep)
	if(src.client.eye!=src)	return
	src.ClearInventory()
	src.InventoryOpen=1
	src.Shopping=ShopKeep
	var/counter=0
	src.BasicInventory()
	src.WriteLine(6,7,13,17,"InventoryMsg","[ShopKeep.name]",0)
	for(var/nx=6,nx<=14,nx++)
		for(var/ny=12,ny>=8,ny--)
			var/obj/HUD/Inventory/ItemBG/I=new()
			counter+=1;I.InvSlot=counter
			I.ScreenX=nx;I.ScreenY=ny
			I.screen_loc="[nx],[ny]";src.client.screen+=I
			if(I.InvSlot<=ShopKeep.Stock.len && ShopKeep.Stock[I.InvSlot])
				var/obj/Items/O=ShopKeep.Stock[I.InvSlot];O.InvSlot=I.InvSlot
				O.screen_loc="[nx],[ny]";src.client.screen+=O
				O.ScreenX=nx;O.ScreenY=ny

mob/proc/DisplaySell(var/obj/NPC/Shops/ShopKeep)
	if(src.client.eye!=src)	return
	src.ClearInventory()
	src.InventoryOpen=1
	src.Selling=ShopKeep
	var/counter=0
	src.BasicInventory()
	src.WriteLine(6,7,13,17,"InventoryMsg","Sell Items",0)
	for(var/nx=6,nx<=14,nx++)
		for(var/ny=12,ny>=8,ny--)
			var/obj/HUD/Inventory/ItemBG/I=new()
			counter+=1;I.InvSlot=counter
			if(I.InvSlot>25)	I.icon_state="LockedItemBG"
			I.ScreenX=nx;I.ScreenY=ny
			I.screen_loc="[nx],[ny]";src.client.screen+=I
			if(usr.Inventory[I.InvSlot])
				var/obj/Items/O=src.Inventory[I.InvSlot];O.InvSlot=I.InvSlot
				O.screen_loc="[nx],[ny]";src.client.screen+=O
				O.ScreenX=nx;O.ScreenY=ny

mob/proc/DisplayInventory(/**/)
	if(src.client.eye!=src || src.Chatting)	return
	if(src.Selling)	{src.DisplaySell(src.Selling);return}
	if(src.Shopping)	{src.DisplayShop(src.Shopping);return}
	src.ClearInventory()
	src.InventoryOpen=1
	var/counter=0
	src.BasicInventory()
	src.client.screen+=new/obj/HUD/Inventory/InvTrash
	src.WriteLine(6,7,13,17,"InventoryMsg","Inventory",0)
	for(var/i=1;i<=5;i++)
		var/obj/HUD/Inventory/EquipmentSlot/I=new()
		if(i==2)	I.EQSlot="Body"
		if(i==3)	I.EQSlot="Head"
		if(i==4)	I.EQSlot="Back"
		if(i==5)	I.EQSlot="Feet"
		I.screen_loc="[i+7],7";src.client.screen+=I
		var/obj/Equipped=src.vars[I.EQSlot]
		if(Equipped)
			Equipped.screen_loc=I.screen_loc;src.client.screen+=Equipped
		else
			I.EQOver.icon_state=I.EQSlot
			I.EQOver.screen_loc=I.screen_loc;src.client.screen+=I.EQOver
	for(var/nx=6,nx<=14,nx++)
		for(var/ny=12,ny>=8,ny--)
			var/obj/HUD/Inventory/ItemBG/I=new()
			counter+=1;I.InvSlot=counter
			if(I.InvSlot>25)	I.icon_state="LockedItemBG"
			I.ScreenX=nx;I.ScreenY=ny
			I.screen_loc="[nx],[ny]";src.client.screen+=I
			if(src.Inventory[I.InvSlot])
				var/obj/Items/O=src.Inventory[I.InvSlot];O.InvSlot=I.InvSlot
				O.screen_loc="[nx],[ny]";src.client.screen+=O
				O.ScreenX=nx;O.ScreenY=ny