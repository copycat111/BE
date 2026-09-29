mob/var
	FontColor="#96CDFF"
	FontFace="Frostys Winterland"
	ClothesR=0
	ClothesG=0
	ClothesB=0
	var/obj/Supplemental/ClothesOverlay/ClothesOverlay

obj/Supplemental
	ClothesOverlay
		icon='SoulReaperClothes.dmi'
		layer=FLOAT_LAYER

mob/Subscriber/verb
	Subscribe()
		set category="Sub"
		if(!SubKeyCheck(usr.key))	usr<<link("http://www.angelfire.com/hero/straygames/Subscribe.html")
		else	usr.SubCheck()
	Font_Color()
		set category="Sub"
		usr.FontColor=input("Select your Font Color:","Font Color",usr.FontColor)as color
	Font_Face()
		set category="Sub"
		//Bookman Old Style - breaks icon size
		usr.FontFace=input("Set the font face for your messages","Font Face",usr.FontFace)as text
		usr.FontFace=AsciiCheck(RemoveHTML(usr.FontFace))
		if(findtext(usr.FontFace,"Bookman Old Style"))	usr.FontFace=null
		if(!usr.FontFace)	usr.FontFace=initial(usr.FontFace)
	Dye_Clothes()
		set category="Sub"
		usr.ClothesR=max(0,min(200,input("Input Red Dye","Clothes Dye",usr.ClothesR) as num))
		usr.ClothesG=max(0,min(200,input("Input Green Dye","Clothes Dye",usr.ClothesG) as num))
		usr.ClothesB=max(0,min(200,input("Input Blue Dye","Clothes Dye",usr.ClothesB) as num))
		usr.RefreshClothes()

mob/proc/RefreshClothes()
	src.overlays-=src.ClothesOverlay
	if(src.ClothesOverlay)	del src.ClothesOverlay
	if(src.icon=='FinalForm.dmi'||src.icon=='Bankai.dmi')	return
	if(src.ClothesR||src.ClothesG||src.ClothesB)
		src.ClothesOverlay=new/obj/Supplemental/ClothesOverlay
		if(src.icon=='School.dmi')	src.ClothesOverlay.icon='SchoolClothesM.dmi'
		if(src.icon=='SchoolFemale.dmi')	src.ClothesOverlay.icon='SchoolClothesF.dmi'
		if(src.icon=='Quincy.dmi')	src.ClothesOverlay.icon='QuincyClothes.dmi'
		src.ClothesOverlay.icon=MyRGB(src.ClothesOverlay.icon,rgb(src.ClothesR,src.ClothesG,src.ClothesB))
		src.overlays+=src.ClothesOverlay

proc/RemoveHTML(var/T)
	var/Pos1=findtext(T,"<",1,0)
	var/Pos2=findtext(T,">",max(1,Pos1),0)
	while(Pos1 && Pos2)
		T="[copytext(T,1,Pos1) + copytext(T,Pos1+1,Pos2) + copytext(T,Pos2+1,0)]"
		Pos1=findtext(T,"<",1,0);Pos2=findtext(T,">",max(1,Pos1),0)
	return T