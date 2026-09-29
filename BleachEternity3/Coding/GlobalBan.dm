var/list/GlobalBanList=list()
var/ServerTag="<b><font color=green>Server Info:</font>"

mob/proc/CheckGlobalBan()
	if(src.client.address in GlobalBanList)
		src<<"<b>Ban Reason:</b> [GlobalBanList[src.client.address]]"
		src<<"You are Globaly Banned from Stray Games";return 1
	if(src.key in GlobalBanList)
		src<<"<b>Ban Reason:</b> [GlobalBanList[src.key]]"
		src<<"You are Globaly Banned from Stray Games";return 2
	if(src.client.computer_id in GlobalBanList)
		src<<"<b>Ban Reason:</b> [GlobalBanList[src.client.computer_id]]"
		src<<"You are Globaly Banned from Stray Games";return 3
	var/list/PlayerOctets=Split(src.client.address,".")
	for(var/x in GlobalBanList)
		if(findtext(x,"*",1,0))
			var/list/OctetList=Split(x,".")
			if(OctetList.len>=2 && PlayerOctets.len>=2)
				if(PlayerOctets[1]==OctetList[1] && PlayerOctets[2]==OctetList[2])
					src<<"This IP Range is Globaly Banned from Stray Games";return 4
	return 0

proc/LoadGlobalBans(var/RepeatLoad=1)
	var/http[]=world.Export("http://www.angelfire.com/hero/straygames/GlobalBans.txt")
	if(!http)
		if(RepeatLoad)	spawn(600)	LoadGlobalBans()
		return
	var/FullText=file2text(http["CONTENT"])
	GlobalBanList=list()
	var/CurPos=1
	var/BanReason
	while(findtext(FullText,"\n",CurPos,0))
		var/NextPos=findtext(FullText,"\n",CurPos,0)
		var/ThisBanLine=copytext(FullText,CurPos,NextPos)
		if(copytext(ThisBanLine,1,3)=="//")	BanReason=copytext(ThisBanLine,3)
		GlobalBanList+=ThisBanLine
		GlobalBanList[ThisBanLine]=BanReason
		CurPos=NextPos+1
	if(RepeatLoad)	spawn(36000)	LoadGlobalBans()
	world<<"[ServerTag] Global Ban List Successfully Loaded"
	for(var/mob/M in world)	if(M.client)
		if(M.CheckGlobalBan())	del M.client