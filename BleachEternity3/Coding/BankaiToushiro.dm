obj/Bankai/IceWings
	layer=FLOAT_LAYER
	pixel_y=-5
	Front
		icon='IceWingsFront.dmi'
	Back
		layer=6
		icon='IceWingsBack.dmi'
	Left
		icon='IceWingsLeft.dmi'
	Right
		icon='IceWingsRight.dmi'

mob/proc/AddIceWings()
	var/xoff=-80
	for(var/i=1;i<=8;i++)	//add front & back
		xoff+=32
		var/obj/Bankai/IceWings/Front/F=new()
		F.pixel_x=xoff;F.icon_state="[i]"
		if(i<=4)	F.pixel_y+=32
		src.overlays+=F
		var/obj/Bankai/IceWings/Back/B=new()
		B.pixel_x=xoff;B.icon_state="[i]"
		if(i<=4)	B.pixel_y+=32
		src.overlays+=B
		if(i==4)	xoff=-80
	xoff=-62
	for(var/i=1;i<=5;i++)	//add left
		xoff+=32
		var/obj/Bankai/IceWings/Left/S=new()
		S.pixel_x=xoff;S.icon_state="[i]"
		if(i<=2)	S.pixel_y+=32
		src.overlays+=S
		if(i==2)	xoff=-96
	xoff=-32
	for(var/i=1;i<=5;i++)	//add right
		xoff+=32
		var/obj/Bankai/IceWings/Right/S=new()
		S.pixel_x=xoff;S.icon_state="[6-i]"
		if(i>3)	S.pixel_y+=32
		src.overlays+=S
		if(i==3)	xoff=-32