mob/var/list/LowCpuHuds=list()

obj/HUD/LowCpuHud
	icon='Alphabet.dmi'
	New(hudx,hudxpix,hudy,hudypix,letter)
		src.icon_state=letter
		src.screen_loc="[hudx]:[hudxpix],[hudy]:[hudypix]"

mob/proc/CreateHUDText(hudx,hudxpix,hudy,hudypix,VarID,WritAbt,NameTag,Text2Write)
	if(src.client.eye!=src)	return
	if(!NameTag)	NameTag=VarID
	if(!WritAbt)	WritAbt=src
	new/datum/LowCpuHudDatum(src,VarID,hudx,hudxpix,hudy,hudypix,WritAbt,NameTag,Text2Write)

mob/proc/UpdateHUDText(var/ThisName,var/Text2Write)
	for(var/datum/LowCpuHudDatum/D in src.LowCpuHuds)	if(D.name==ThisName)	{D.Refresh(Text2Write);return 1}

datum/LowCpuHudDatum
	var/name;var/VarID
	var/mob/WriteFor;var/mob/WriteAbout
	var/x;var/xo;var/y;var/yo
	var/list/ThisHud=list()
	New(mob/Write4,NewVarID,hudx,hudxpix,hudy,hudypix,mob/WritAbt,NameTag,Text2Write)
		src.WriteFor=Write4;src.VarID=NewVarID;src.name=NameTag
		src.WriteAbout=WritAbt;WriteFor.LowCpuHuds+=src
		src.x=hudx;src.y=hudy
		src.xo=hudxpix;src.yo=hudypix
		src.Refresh(Text2Write)
	proc/Delete()
		if(!WriteAbout || !WriteFor || !WriteFor.client)	return
		for(var/obj/HUD/LowCpuHud/O in src.ThisHud)	WriteFor.client.screen-=O
		del src
	proc/Hide()
		if(!WriteAbout || !WriteFor || !WriteFor.client)	return
		for(var/obj/HUD/LowCpuHud/O in src.ThisHud)	O.icon_state="invis"
	proc/Refresh(var/Text2Write)
		if(!WriteAbout || !WriteFor || !WriteFor.client)	return
		if(WriteFor.client.eye!=WriteFor)	return
		if(!Text2Write)	Text2Write=WriteAbout.vars["[VarID]"]
		Text2Write="[Text2Write]"
		//for(var/x in src.ThisHud)	if(!x)	src.ThisHud-=x	//removes nulls o.O
		if(src.ThisHud.len<length(Text2Write))	src.Create(Text2Write)
		for(var/obj/HUD/LowCpuHud/O in src.ThisHud)	O.icon_state="invis"
		var/firstpos=0
		while(WriteFor)
			firstpos+=1
			if(firstpos>src.ThisHud.len)	return
			var/letter=copytext(Text2Write,firstpos,firstpos+1)
			if(!letter)	return
			var/obj/O=src.ThisHud[firstpos]
			if(O)
				if(!(O in WriteFor.client.screen))	WriteFor.client.screen+=O
				O.icon_state=letter
	proc/Create(var/Text2Write)
		if(!WriteAbout || !WriteFor || !WriteFor.client)	return
		var/firstpos=0;var/Icon2Use
		for(var/obj/HUD/LowCpuHud/O in src.ThisHud)
			src.ThisHud-=O;del O
		var/hudx=x;var/hudxpix=xo;var/hudy=y;var/hudypix=yo
		if(!Text2Write)	Text2Write=WriteAbout.vars["[VarID]"]
		if(src.name=="STM"||src.name=="REI")	Icon2Use='HudText.dmi'
		if(src.name=="MaxSTM"||src.name=="MaxREI")	Icon2Use='HudText.dmi'
		if(src.VarID=="Quest")	Icon2Use='AlphabetYellow.dmi'
		Text2Write="[Text2Write]"
		while(WriteFor)
			firstpos+=1
			var/letter=copytext(Text2Write,firstpos,firstpos+1)
			if(!letter)	return
			var/LowerOffset=0	//offsets y,p,q,etc below baseline
			if(Icon2Use!='HudText.dmi')	if(LowLetter(letter))	LowerOffset=2
			var/obj/HUD/LowCpuHud/O=new (hudx,hudxpix,hudy,hudypix-LowerOffset,letter)
			if(Icon2Use!='HudText.dmi')	if(SlimLetter(letter))	hudxpix-=4
			if(Icon2Use)	O.icon=Icon2Use
			WriteFor.client.screen+=O;src.ThisHud+=O
			var/hudxoff=7
			if(Icon2Use=='HudText.dmi')	{hudxoff=9;O.layer+=1}
			hudxpix+=hudxoff
			if(hudxpix>=32)
				hudx+=1;hudxpix-=32