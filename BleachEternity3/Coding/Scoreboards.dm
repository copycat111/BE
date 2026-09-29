datum
	ArenaScore
		var/Name
		var/Round

var/list/ArenaScores=list()

proc/UpdateArenaScores(var/Name,var/Round)
	var/list/TempList=list()
	if(!ArenaScores)	ArenaScores=list()
	for(var/datum/ArenaScore/S in ArenaScores)
		if(S.Name==Name)	S.Round=Round
	for(var/datum/ArenaScore/S in ArenaScores)
		if(S.Round<Round)	{ArenaScores-=S;TempList+=S}
	if(ArenaScores.len<10)
		var/datum/ArenaScore/NS=new()
		NS.Name=Name;NS.Round=Round
		ArenaScores+=NS
		if(ArenaScores.len==1)
			world<<"<b><font size=1><font color=blue>[Name] has set a new Arena High Score: Round [Round]!"
		ArenaScores+=TempList
		if(ArenaScores.len>10)	ArenaScores=ArenaScores.Copy(1,11)
		SaveConfig()

mob/verb/ViewArenaScores()
	set hidden=1
	var/TextList="<html><body bgcolor=black><b><font color=gray>"
	TextList+="<title>Arena Scoreboard</title>"
	TextList+="<center><table border=1 bgcolor=black bordercolor=gray width=100%>"
	TextList+="<tr><td colspan=2><b><font color=gray><center>Arena Scoreboard"
	TextList+="<tr><td><b><font color=gray>Player<td align=right><b><font color=gray>Round"
	for(var/datum/ArenaScore/S in ArenaScores)
		TextList+="<tr><td><b><font color=gray>[S.Name]<td align=right><b><font color=gray>[S.Round]"
	usr<<browse("[TextList]","window=ASBBrowser")



datum
	OverallScore
		var/Name;var/Class
		var/Level;var/PlayTime

var/list/OverallScores=list()

proc/UpdateOverallScores(var/Name,var/Class,var/Level,var/PlayTime)
	var/list/TempList=list()
	if(!OverallScores)	OverallScores=list()
	for(var/datum/OverallScore/S in OverallScores)
		if(S.Level<Level)
			OverallScores-=S;TempList+=S
		if(S.Name==Name)
			OverallScores-=S;TempList-=S
	if(OverallScores.len<10)
		var/datum/OverallScore/NS=new()
		NS.Name=Name;NS.Class=Class;NS.Level=Level;NS.PlayTime=PlayTime
		OverallScores+=NS
		OverallScores+=TempList
		if(OverallScores.len>10)	OverallScores=OverallScores.Copy(1,11)
		SaveConfig()

mob/verb/ViewOverallScores()
	set hidden=1
	var/TextList="<html><body bgcolor=black><b><font color=gray>"
	TextList+="<title>Overall Scoreboard</title>"
	TextList+="<center><table border=1 bgcolor=black bordercolor=gray width=100%>"
	TextList+="<tr><td colspan=5><b><font color=gray><center>Overall Scoreboard"
	TextList+="<tr><td><b><font color=gray>Player<td><b><font color=gray><center>Class"
	TextList+="<td align=right><b><font color=gray>Level<td align=right colspan=2><b><font color=gray>Play Time"
	for(var/datum/OverallScore/S in OverallScores)
		var/Phours=round(S.PlayTime/60/60)
		var/Pminutes=round(S.PlayTime/60-(60*Phours))
		TextList+="<tr><td><b><font color=gray>[S.Name]<td><b><font color=gray><center>[S.Class]"
		TextList+="<td align=right><b><font color=gray>[S.Level]"
		TextList+="<td align=right><b><font color=gray>[Phours]h<td align=right><b><font color=gray>[Pminutes]m"
	usr<<browse("[TextList]","window=ASBBrowser")