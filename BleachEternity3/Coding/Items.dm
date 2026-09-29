proc/GetBuyPrices(var/obj/Items/O,var/Amt)
	var/StackPercnt=O.CurStack
	var/FullCost="[O.CoprValue]";while(length(FullCost)<2)	FullCost="0[FullCost]"
	FullCost="[O.SilvValue][FullCost]";while(length(FullCost)<4)	FullCost="0[FullCost]"
	FullCost="[O.GoldValue][FullCost]";while(length(FullCost)<6)	FullCost="0[FullCost]"
	FullCost=text2num(FullCost);FullCost-=FullCost*StackPercnt/100
	if(FullCost<5)	FullCost=5
	var/SaleGold=0;var/SaleSilv=0
	while(FullCost>=10000)	{FullCost-=10000;SaleGold+=1}
	while(FullCost>=100)	{FullCost-=100;SaleSilv+=1}
	SaleGold*=Amt;SaleSilv*=Amt;FullCost=round(FullCost*Amt,1)
	while(FullCost>=100)	{FullCost-=100;SaleSilv+=1}
	while(SaleSilv>=100)	{SaleSilv-=100;SaleGold+=1}
	return list(SaleGold,SaleSilv,FullCost)

proc/GetSalePrices(var/obj/Items/O,var/obj/NPC/Shops/ShopKeep)
	if(!O || !ShopKeep)	return
	var/StackPercnt=0;var/Amt=O.CurStack
	for(var/obj/Items/I in ShopKeep.Stock)	if(I.type==O.type)	StackPercnt=I.CurStack
	var/FullCost="[O.CoprValue]";while(length(FullCost)<2)	FullCost="0[FullCost]"
	FullCost="[O.SilvValue][FullCost]";while(length(FullCost)<4)	FullCost="0[FullCost]"
	FullCost="[O.GoldValue][FullCost]";while(length(FullCost)<6)	FullCost="0[FullCost]"
	FullCost=text2num(FullCost);FullCost/=4
	FullCost-=FullCost*StackPercnt/100
	if(FullCost<1)	FullCost=1
	var/SaleGold=0;var/SaleSilv=0
	while(FullCost>=10000)	{FullCost-=10000;SaleGold+=1}
	while(FullCost>=100)	{FullCost-=100;SaleSilv+=1}
	SaleGold*=Amt;SaleSilv*=Amt;FullCost=round(FullCost*Amt,1)
	while(FullCost>=100)	{FullCost-=100;SaleSilv+=1}
	while(SaleSilv>=100)	{SaleSilv-=100;SaleGold+=1}
	return list(SaleGold,SaleSilv,FullCost)

obj/Items
	mouse_opacity=2
	mouse_over_pointer="MouseHand"
	var/ScreenX;var/ScreenY
	var/InvSlot;layer=20
	var/CurStack=1
	var/MaxStack=9
	var/Unique=0
	var/GoldValue=0
	var/SilvValue=0
	var/CoprValue=0
	var/HasUse=1
	New(var/Amt=1)
		src.CurStack=Amt
		if(src.CurStack!=1)	src.UpdateCount()
		return ..()
	proc/Use(var/mob/M)
		QuestShow(M,"[src.name] Used!  No Effect...")
		return "Failed"
	proc/Buy(var/mob/M,var/Amt=1)
		Amt=min(25,Amt,src.CurStack)
		if(Amt<=0)	{QuestShow(M,"Currently Sold Out!");return}
		if(!src.GoldValue && !src.SilvValue && !src.CoprValue)
			QuestShow(M,"They wont sell that Item!");return
		var/list/BuyPrices=GetBuyPrices(src,Amt)
		if(!CheckGold(TrueValue(M),TrueValue(BuyPrices[1],BuyPrices[2],BuyPrices[3])))
			QuestShow(M,"You can't afford that");return//check to see if they can afford what they want
		var/obj/Items/NewItem=new src.type(Amt)
		Amt=M.GetItem(NewItem)
		BuyPrices=GetBuyPrices(src,Amt)	//reCalculate on how many they actualy got
		src.CurStack-=Amt;src.UpdateCount()
		M.TakeGold(BuyPrices[1],BuyPrices[2],BuyPrices[3])
	proc/Sell(var/mob/M)
		if(!src.GoldValue && !src.SilvValue && !src.CoprValue)
			QuestShow(M,"They wont buy that Item!");return
		var/list/SalePrices=GetSalePrices(src,M.Selling)
		if(!SalePrices)	return
		M.GiveGold(SalePrices[1],SalePrices[2],SalePrices[3])
		M.Selling.StockItem(src)
		del src
	proc/Discard(var/Amt=1)
		src.CurStack-=Amt
		if(src.CurStack<=0)	del src
		else	src.UpdateCount()
	Click()
		if(usr.Chatting)	return
		if(usr.Shopping)
			var/list/SalePrices=GetBuyPrices(src,1)
			var/SalePriceTag="> Sale Price: "
			if(!src.GoldValue && !src.SilvValue && !src.CoprValue)	SalePriceTag="> No Sale Price"
			else
				if(SalePrices[1])	SalePriceTag+="[SalePrices[1]]ô  "
				if(SalePrices[2])	SalePriceTag+="[SalePrices[2]]ö  "
				if(SalePrices[3])	SalePriceTag+="[SalePrices[3]]ò"
			if(CustAlert(usr,"[src.name] > > [src.desc] > [SalePriceTag]",list("Buy","Close"),ScreenX,ScreenY-6,ScreenX+5,ScreenY-2)=="Buy")
				src.Buy(usr,1)
			return
		if(usr.Selling)
			var/list/SalePrices=GetSalePrices(src,usr.Selling)
			if(!SalePrices)	return
			var/SalePriceTag="> Sale Price: "
			if(!src.GoldValue && !src.SilvValue && !src.CoprValue)	SalePriceTag="> No Sale Price"
			else
				if(SalePrices[1])	SalePriceTag+="[SalePrices[1]]ô  "
				if(SalePrices[2])	SalePriceTag+="[SalePrices[2]]ö  "
				if(SalePrices[3])	SalePriceTag+="[SalePrices[3]]ò"
			if(CustAlert(usr,"[src.name] > > [src.desc] > [SalePriceTag]",list("Sell","Close"),ScreenX,ScreenY-6,ScreenX+5,ScreenY-2)=="Sell")
				src.Sell(usr)
			return
		var/list/ChoiceList=list("Use","Close")
		if(!src.HasUse)	ChoiceList-="Use"
		if(CustAlert(usr,"[src.name] > > [src.desc]",ChoiceList,ScreenX,ScreenY-6,ScreenX+5,ScreenY-2)=="Use")
			src.Use(usr)
	Other
		icon='OtherItems.dmi'
		MaxStack=25
		Hollow_Bait
			GoldValue=0;SilvValue=4;CoprValue=0
			icon_state="Hollow Bait";mouse_drag_pointer="Hollow Bait"
			desc="Taunts all nearby enemies into attacking you"
			Use(var/mob/M)
				M.ClearInventory()
				M.Taunt(M.SightRange);src.Discard(1)
		Beastiary
			MaxStack=1
			GoldValue=10;SilvValue=0;CoprValue=0
			icon_state="Beastiary";mouse_drag_pointer="Beastiary"
			desc="Stores data on the enemies you have defeated"
			Use(var/mob/M)
				M.SearchBeastProc()
				winset(M,"BeastiaryWindow","is-visible=true;pos=100,100")
		Recall_Scroll
			GoldValue=0;SilvValue=1;CoprValue=0
			icon_state="Recall Scroll";mouse_drag_pointer="Recall Scroll"
			desc="Can be used at any time to return to your current Respawn Point"
			Use(var/mob/M)
				if(M.z==8)	{QuestShow(M,"Cannot be Used inside the Arena");return "Failed"}
				M.loc=locate(M.RespawnX,M.RespawnY,M.RespawnZ);src.Discard(1)
		Respec_Cupon
			icon_state="Respec Cupon";mouse_drag_pointer="Respec Cupon"
			desc="Can be used at any time for 1 free respec on your character."
			Use(var/mob/M)
				QuestShow(M,"Your Character has been Respecced")
				M.Respec();src.Discard(1)
		Barber_Cupon
			icon_state="Barber Cupon";mouse_drag_pointer="Barber Cupon"
			desc="Can be used at any time for 1 free hair cut on your character."
			Use(var/mob/M)
				M.HairColor();src.Discard(1)
		Progress_Cupon
			HasUse=0
			icon_state="Progress Cupon";mouse_drag_pointer="Progress Cupon"
			desc="Can be traded in for a Respec or Barber Cupon at your local Spirit Master"
	StatBoosters
		icon='StatBoosters.dmi'
		MaxStack=25
		var/Stat2Boost="MaxSTM"
		var/Amt2Boost=100
		var/Duration=1800//30 min
		Use(var/mob/M)
			M.AddEffect(new/datum/StatusEffects/ItemStatBooster(src,usr.name))
			src.Discard(1)
		Adrenaline_Shot
			GoldValue=0;SilvValue=4;CoprValue=0
			Stat2Boost="MaxSTM";Amt2Boost=100;Duration=1800
			icon_state="Adrenaline Shot";mouse_drag_pointer="Adrenaline Shot"
			desc="Increases Maxmimum Stamina by 100 for 30 minutes"
		Reiatsu_Injection
			GoldValue=0;SilvValue=4;CoprValue=0
			Stat2Boost="MaxREI";Amt2Boost=50;Duration=1800
			icon_state="Reiatsu Injection";mouse_drag_pointer="Reiatsu Injection"
			desc="Increases Maxmimum Reiatsu by 50 for 30 minutes"
	Potions
		icon='Potions.dmi'
		MaxStack=25
		proc/HealStm(var/mob/M,var/Heal)
			M.STM=min(M.MaxSTM,M.STM+Heal)
			M.StmBar();DamageShow(M,Heal,'HealNums.dmi')
			if(M.STM>=M.MaxSTM)	QuestShow(M,"STM Fully Restored")
			else	QuestShow(M,"[Heal] STM Restored")
		proc/HealRei(var/mob/M,var/Heal)
			M.REI=min(M.MaxREI,M.REI+Heal)
			M.ReiBar();DamageShow(M,Heal,'HealNums.dmi')
			if(M.REI>=M.MaxREI)	QuestShow(M,"REI Fully Restored")
			else	QuestShow(M,"[Heal] REI Restored")
		Energy_Drink
			GoldValue=0;SilvValue=2;CoprValue=0
			icon_state="Energy Drink";mouse_drag_pointer="Energy Drink"
			desc="A Popular Sports Drink. > Restores 50 Stamina"
			Use(var/mob/M)
				src.HealStm(M,50)
				src.Discard(1)
		Spirit_Dew
			GoldValue=0;SilvValue=2;CoprValue=0
			icon_state="Spirit Dew";mouse_drag_pointer="Spirit Dew"
			desc="Condensed Spirit Energy. > Restores 25 Reiatsu"
			Use(var/mob/M)
				src.HealRei(M,25)
				src.Discard(1)
		Phoenix_Feather
			icon_state="Phoenix Feather";mouse_drag_pointer="Phoenix Feather"
			desc="A Feather from a Phoenix. > Automaticaly recovers full Stamina, preventing death."
	EnemySpoils
		GoldValue=0;SilvValue=0;CoprValue=50
		icon='Spoils.dmi'
		MaxStack=25
		HasUse=0
		Onyx
			icon_state="Onyx";mouse_drag_pointer="Onyx"
			desc="A shiney black stone"
		Treen_Arms
			GoldValue=0;SilvValue=1;CoprValue=0
			icon_state="Treen Arms";mouse_drag_pointer="Treen Arms"
			desc="Arms ripped from a Treen Hollow after it was defeated"
		Tangled_Vine
			GoldValue=0;SilvValue=1;CoprValue=50
			icon_state="Tangled Vine";mouse_drag_pointer="Tangled Vine"
			desc="Vines that are tangled together."
		Spider_Legs
			icon_state="Spider Legs";mouse_drag_pointer="Spider Legs"
			desc="Sticky legs from a spider-like hollow."
		Hollow_Mask
			icon_state="Hollow Mask";mouse_drag_pointer="Hollow Mask"
			desc="Graft to Create Equipment Shards.  Effects Vary by Hollow Type."
		Cracked_Hollow_Mask
			icon_state="Cracked Hollow Mask";mouse_drag_pointer="Cracked Hollow Mask"
			desc="A hollow mask that was damaged during battle."
		Shattered_Hollow_Mask
			icon_state="Shattered Hollow Mask";mouse_drag_pointer="Shattered Hollow Mask"
			desc="A hollow mask that was destroyed during battle."
		Flaming_Crystal
			icon_state="Flaming Crystal";mouse_drag_pointer="Flaming Crystal"
			desc="A ruby red crystal embued with the power of fire."
		Ham_Sandwich
			icon_state="Ham Sandwich";mouse_drag_pointer="Ham Sandwich"
			desc="A delicious looking ham and cheese sandwich."
		Bat_Guano
			icon_state="Bat Guano";mouse_drag_pointer="Bat Guano"
			desc="This is bat poop.  Why the heck did you pick this up?"
	QuestItems
		icon='QuestItems.dmi'
		MaxStack=25
		HasUse=0
		Diary
			Unique=1
			icon_state="Diary";mouse_drag_pointer="Diary"
			desc="A pink diary found at the beach."
		Lost_Purse
			Unique=1
			icon_state="Lost Purse";mouse_drag_pointer="Lost Purse"
			desc="You should probably find the owner of this purse."
		Sour_Flower
			icon_state="Sour Flowers";mouse_drag_pointer="Sour Flowers"
			desc="A slightly poisonous flower.  Used to create various potions."
		Tin_Flower
			icon_state="Tin Flowers";mouse_drag_pointer="Tin Flowers"
			desc="A metallic flower.  Can be used to create various potions."
		Sturdy_Rock
			density=1
			icon_state="Sturdy Rock";mouse_drag_pointer="Sturdy Rock"
			desc="It would take a lot to break this rock!"