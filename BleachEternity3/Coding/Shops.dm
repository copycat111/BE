var/MaxShopStock=25
obj/NPC
	Shops
		var/list/Stock=list()
		var/list/InitStock=list()
		New()
			src.InitStock=src.Stock
			spawn(18000)	while(src)
				for(var/obj/Items/I in src.InitStock)
					for(var/obj/Items/O in src.Stock)
						if(O.type==I.type)
							O.CurStack+=5
							if(O.CurStack>MaxShopStock)	O.CurStack=MaxShopStock
							O.UpdateCount();break
				sleep(18000)
			return ..()
		proc/StockItem(var/obj/Items/O)
			for(var/obj/Items/I in src.Stock)
				if(I.type==O.type)
					I.CurStack+=O.CurStack
					if(I.CurStack>MaxShopStock)	I.CurStack=MaxShopStock
					I.UpdateCount();return
			src.Stock+=O
		DblClick()
			switch(ShowAlert(usr,"[src.name] > > Welcome, [usr.name].  We've got some great deals today!  What can I help you with?",list("Buy","Sell","Leave")))
				if("Buy")
					if(usr && !usr.Shopping)	usr.DisplayShop(src)
				if("Sell")
					if(usr && !usr.Selling)	usr.DisplaySell(src)
		Item_Peddler
		Traveling_Salesman

		Item_Merchant
			Stock=list(new/obj/Items/Potions/Energy_Drink(25),new/obj/Items/Potions/Spirit_Dew(25),\
				new/obj/Items/Other/Hollow_Bait(25),new/obj/Items/Other/Recall_Scroll(25))
		Gear_Vendor
			Stock=list(new/obj/Items/Equipment/Hand/Weapons/Sword(25),new/obj/Items/Equipment/Hand/Weapons/Cane(25),\
				new/obj/Items/Equipment/Hand/Weapons/Rapier(25),new/obj/Items/Equipment/Hand/Weapons/Metal_Cane(25),\
				new/obj/Items/Equipment/Body/Clothes(25),new/obj/Items/Equipment/Head/Toy_Vizard_Mask(25))