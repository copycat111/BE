var/ClientLogCount=0
var/ClientLogLoaded=0
var/ClientLog="<table border=1><tr><td><b>#<td><b>Key<td><b>IP<td><b>ID\n"

mob/GM/verb/Check_Client_Log()
	set category="GM"
	usr<<browse("<title>Client Log</title><center>[ClientLogCount] Clients Logged[ClientLog]</table>","window=ClientLog")

proc/SaveClientLog()
	var/savefile/F=new("ClientLog.sav")
	F["ClientLogCount"]<<ClientLogCount
	if(fexists("ClientLog.txt"))	fdel("ClientLog.txt")
	text2file(ClientLog,"ClientLog.txt")

proc/LoadClientLog()
	if(fexists("ClientLog.sav"))
		var/savefile/F=new("ClientLog.sav")
		F["ClientLogCount"]>>ClientLogCount
	if(fexists("ClientLog.txt"))
		ClientLog=file2text("ClientLog.txt")
	ClientLogLoaded=1

world/New()
	LoadClientLog()
	return ..()

mob/proc/LogClient()
	while(!ClientLogLoaded)	sleep(1)
	if(!src.client)	return
	var/LogMsg="<td>[src.key]<td>[src.client.address]<td>[src.client.computer_id]"
	if(!findtext(ClientLog,LogMsg,1,0))
		ClientLogCount+=1
		ClientLog+="<tr><td>[ClientLogCount][LogMsg]\n"
		SaveClientLog()