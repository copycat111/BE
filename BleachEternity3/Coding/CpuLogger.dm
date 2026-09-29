var/TotalCPU=0
var/TotalTicks=0
var/HighestCPU=0
var/TotalPlayers=0
var/HighestPlayers=0
var/TicksOver100=0
proc/LogCPU()
	while(world)
		TotalPlayers+=PlayerCount
		TotalCPU+=world.cpu
		TotalTicks+=1
		if(PlayerCount>HighestPlayers)	HighestPlayers=PlayerCount
		if(world.cpu>HighestCPU)	HighestCPU=world.cpu
		if(world.cpu>=100)	TicksOver100+=1
		sleep(1)

mob/Test/verb/CheckCPU()
	set category="Test"
	if(usr.key!="Falacy")	return
	usr<<"Highest CPU: [HighestCPU]% | Highest Players: [HighestPlayers]"
	usr<<"100% Usage Ticks: [TicksOver100] | Total Ticks: [TotalTicks]"
	usr<<"<b>Average CPU:</b> [round(TotalCPU/TotalTicks)]% | <b>Average Players:</b> [round(TotalPlayers/TotalTicks)]"
	usr<<"<b>Average % per Player:</b> [round(round(TotalCPU/TotalTicks)/round(TotalPlayers/TotalTicks),0.1)]%"
	usr<<"<b>Average 100% Ticks:</b> [round(TicksOver100/TotalTicks,0.1)]%"