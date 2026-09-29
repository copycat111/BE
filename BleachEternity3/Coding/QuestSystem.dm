//Generic Quest Types: Kill, Speak With, Reach, Collect
datum/QuestDatum
	var/name=""
	var/desc=""
	var/LevelReq=0
	var/QuestReq
	var/TimeLimit=0
	var/ExpReward=0
	var/GoldReward=0
	var/SilverReward=0
	var/CopperReward=0
	var/ItemReward=""
	var/QuestX=1
	var/QuestY=1
	var/QuestZ=1
	var/list/Objectives=list()
datum/ObjectiveDatum
	var/Objective="Current Objective"
	var/Stat="Level"
	var/Current=0
	var/Goal=1

mob/proc/QuestDuration()
	var/TimedCheck=0
	var/ClearCheck=0
	for(var/datum/QuestDatum/Q in src.Quests)
		if(!Q.TimeLimit)	continue
		Q.TimeLimit-=1;TimedCheck=1
		if(Q.TimeLimit<=0)
			var/TQ=Q.name;ClearCheck=1
			src.Quests-=Q;del Q;QuestShow(src,"[TQ] Failed")
			src.QuestRefresh()
	if(ClearCheck)	src.ClearQuests()
	if(TimedCheck)	src.TrackQuests()

mob/verb/ShowQuestLog()
	set hidden=1
	//usr<<"<b><font color=yellow>Currently Undertaking [usr.Quests.len] Quests"
	//usr<<"<b><font color=yellow>[usr.CompletedQuests.len] Quests Completed Overall"
	var/TextList="<html><body bgcolor=black link=yellow alink=yellow vlink=yellow><b><font color=yellow>"
	TextList+="<center><table border=1 bgcolor=black bordercolor=yellow width=100%>"
	TextList+="<tr><td colspan=3><center><b><font color=yellow>[usr.Quests.len] Quests Underway"
	TextList+="<tr><td><b><font color=yellow>Quest Name<td><b><font color=yellow>Objectives"
	TextList+="<td><b><font color=yellow>Status"
	for(var/datum/QuestDatum/D in usr.Quests)
		var/Status="X"
		var/Tag=""
		var/counter=0
		for(var/datum/ObjectiveDatum/O in D.Objectives)
			if(O.Objective=="Reach")
				Tag+="[O.Objective] [O.Stat] [O.Goal]<br>{[usr.vars[O.Stat]] of [O.Goal] [O.Objective]ed}<br>"
			else	if(O.Objective=="Kill")
				Tag+="[O.Objective] [O.Goal] [O.Stat]s<br>{[O.Current] of [O.Goal] [O.Objective]ed}<br>"
			else	if(O.Objective=="Speak With")
				Tag+="[O.Objective] [O.Stat]"
			else if(O.Objective=="Collect")
				Tag+="Collect [O.Goal] [O.Stat]s<br>{[O.Current] of [O.Goal] Collected}<br>"
			else	Tag+="[O.Objective] [O.Current]/[O.Goal] [O.Stat]"
			if(O.Objective=="Reach")	if(usr.vars["[O.Stat]"]>=O.Goal)	counter+=1
			else	if(O.Current>=O.Goal)	counter+=1
		if(counter>=D.Objectives.len)	Status="Complete"
		else	Status="[counter] of [D.Objectives.len] Objectives Completed"
		TextList+="<tr><td><b><font color=yellow>"
		TextList+="<a href='?src=\ref[usr];action=ViewQuest;Quest=[D.name]'>[D.name]</a>"
		TextList+="<td><b><font color=yellow>[Tag]"
		TextList+="<td><b><font color=yellow>[Status]"
	TextList+="</Table><p><Table border=1 bordercolor=yellow width=100%>"
	TextList+="<tr><td><center><font color=yellow><b>[usr.CompletedQuests.len] Quests Completed"
	for(var/T in usr.CompletedQuests)
		TextList+="<tr><td><center><a href='?src=\ref[usr];action=ViewQuest;Quest=[T]'>[T]</a>"
	usr<<browse("[TextList]","window=Quests,size=500x500")

mob/proc/QuestRefresh(/**/)
	for(var/image/I in src.client.images)
		if(I.name != "TargetUnder")
			src.client.images-=I
			del I
	for(var/obj/NPC/N in world)
		for(var/datum/QuestDatum/Q in N.Quests)
			if(Q.name in src.CompletedQuests)	continue
			for(var/datum/QuestDatum/CQ in src.Quests)
				if(CQ.name==Q.name)
					if(src.CompleteCheck(CQ.name))
						var/image/I=image('Effects.dmi',N.loc,"?",8,SOUTH)
						I.name=Q;I.pixel_y=32
						src.client<<I
					else
						var/image/I=image('Effects.dmi',N.loc,"gray?",8,SOUTH)
						I.name=Q;I.pixel_y=32
						src.client<<I
					goto CurQuest
			var/image/I
			var/ShowQ=1
			if(Q.QuestReq)	if(!ListCheck(Q.QuestReq,src.CompletedQuests))	ShowQ=0
			if(src.Level<Q.LevelReq)	ShowQ=0
			if(ShowQ)	I=image('Effects.dmi',N.loc,"!",8,SOUTH)
			else	I=image('Effects.dmi',N.loc,"gray!",8,SOUTH)
			I.name=Q;I.pixel_y=32
			src.client<<I
			CurQuest
			break

mob/proc/QuestAdd(var/QuestName,var/turf/Loco,var/list/Objectives=list(),var/ExpReward=0,var/Duration=0)
	for(var/datum/QuestDatum/D in src.Quests)
		if(D.name==QuestName)	return
	if(QuestName in src.CompletedQuests)	return
	var/datum/QuestDatum/QD=new()
	QD.name=QuestName
	QD.TimeLimit=Duration
	QD.QuestX=Loco.x
	QD.QuestY=Loco.y
	QD.QuestZ=Loco.z
	QD.ExpReward=ExpReward
	for(var/datum/ObjectiveDatum/D in Objectives)
		var/datum/ObjectiveDatum/OD=new()
		OD.Objective=D.Objective
		OD.Stat=D.Stat
		OD.Goal=D.Goal
		QD.Objectives+=OD
		if(OD.Objective=="Collect")
			for(var/obj/Items/I in src.Inventory)
				if(I.name==D.Stat)	OD.Current+=I.CurStack
	src.Quests+=QD
	src<<"<b><font color=yellow>Quest Added: [QuestName]"
	for(var/obj/HUD/QuestOrb/O in src.client.screen) MyFlick("QuestFlash",O)
	src.TrackQuests();src.QuestRefresh()

mob/proc/QuestComplete(var/Exp2Give,var/QuestName,var/G,var/S,var/C,var/Item2Give)
	var/ItemTag=""
	if(Item2Give)
		var/NewPath=text2path(Item2Give);var/obj/O=new NewPath
		ItemTag="[O.name]";src.GetItem(O)
		ItemTag=" > > [ItemTag] Received!"
	var/GoldTag=""
	if(G)	GoldTag+=" [G] Gold";if(S)	GoldTag+=" [S] Silver";if(C)	GoldTag+=" [C] Copper"
	if(G||S||C)
		src.GiveGold(G,S,C)
		GoldTag=" > > Received[GoldTag]!"
	src<<"<b><font color=yellow>Quest Complete: [QuestName]"
	for(var/datum/QuestDatum/D in src.Quests)
		if(D.name==QuestName)
			src.Quests-=D;del D
	src.CompletedQuests+=QuestName
	src.GiveExp(Exp2Give,"Completed '[QuestName]'")
	for(var/obj/HUD/QuestOrb/O in src.client.screen) MyFlick("QuestFlash",O)
	src.ClearQuests();src.TrackQuests()
	src.QuestRefresh();src.Save()
	ShowText(src,"-[QuestName] Complete- > > [Exp2Give] Exp Received![ItemTag][GoldTag]")

mob/proc/CompleteCheck(var/QuestName)
	for(var/datum/QuestDatum/D in src.Quests)
		if(D.name==QuestName)
			var/counter=0
			for(var/datum/ObjectiveDatum/O in D.Objectives)
				if(O.Objective=="Reach")	if(src.vars["[O.Stat]"]>=O.Goal)	counter+=1
				else	if(O.Current>=O.Goal)	counter+=1
			if(counter>=D.Objectives.len)	return 1
			else	return 0

mob/proc/ClearQuests()
	for(var/obj/Supplemental/QuestLoc/Q in src.client.screen)	del Q
	for(var/datum/LowCpuHudDatum/D in src.LowCpuHuds)	if(D.VarID=="Quest")	D.Delete()

mob/proc/ViewQuestDetails(var/TQ)
	if(src.Chatting)	return
	for(var/obj/NPC/Quest_Giver/N in world)
		for(var/datum/QuestDatum/Q in N.Quests)	if(Q.name==TQ)
			src<<browse(null,"window=Quests")
			if(TQ in src.CompletedQuests)	ShowAlert(src,Q.desc,list("Close"))
			else	switch(ShowAlert(src,Q.desc,list("Abandon","Locate","Close")))
				if("Abandon")
					if(ShowAlert(src,"Are you sure you want to Abandon [TQ]? > If you Abandon this Quest you can restart it by speaking with the NPC again.",list("Abandon","Cancel"))=="Abandon")
						for(var/datum/QuestDatum/D in src.Quests)	if(D.name==TQ)
							src.Quests-=D;del D;QuestShow(src,"[TQ] Abandoned")
							src.QuestRefresh();src.TrackQuests()
							src<<"<b><font color=yellow>Quest Abandoned: [TQ]"
							for(var/obj/HUD/QuestOrb/QO in src.client.screen)	QO.Click()
							return
				if("Locate")
					for(var/datum/QuestDatum/D in src.Quests)	if(D.name==TQ)
						src.LocateQuest(D);return
			return
	QuestShow(src,"No Quest Documentation Found")

obj/Supplemental
	QuestLoc
		layer=21
		icon='Effects.dmi';icon_state="QuestLoc"
		mouse_over_pointer="QuestMouseOver"
		Click()
			usr.ViewQuestDetails(src.name)
			return	//old method!  Directly locations quest
			if(usr.Chatting || usr.RegenWait>=0)	return
			for(var/datum/QuestDatum/Q in usr.Quests)
				if(Q.name==src.name)
					usr.LocateQuest(Q);break

mob/proc/TrackQuests(/**/)
	if(!src.client)	return
	if(src.client.eye!=src)	return
	var/counter=-1
	var/hudy=1;var/hudyo=-8
	for(var/datum/QuestDatum/D in src.Quests)
		for(var/datum/ObjectiveDatum/O in D.Objectives)
			counter+=1
			hudyo+=10;if(hudyo>=32)	{hudy+=1;hudyo-=32}
			var/ThisCurrent=O.Current
			if(O.Objective=="Reach")	ThisCurrent=src.vars["[O.Stat]"]
			var/CompletionInfo="[ThisCurrent]/[O.Goal]"
			if(ThisCurrent>=O.Goal)	CompletionInfo="Complete"
			var/FullMsg="[O.Objective] [O.Stat]: [CompletionInfo]"
			if(O.Objective=="Reach")	FullMsg="[O.Objective] [O.Stat] [O.Goal]: [CompletionInfo]"
			if(!src.UpdateHUDText("[D.name]-[O.Objective][O.Stat]",FullMsg))
				src.CreateHUDText(1,18,hudy,hudyo,"Quest",src,"[D.name]-[O.Objective][O.Stat]",FullMsg)
		counter+=1
		hudyo+=10;if(hudyo>=32)	{hudy+=1;hudyo-=32}
		var/TimeTag=""
		if(D.TimeLimit)
			TimeTag=" - "
			var/TimeCalc=D.TimeLimit-(round(D.TimeLimit/60)*60)
			if(TimeCalc<10)	TimeCalc="0[TimeCalc]"
			TimeTag+="[round(D.TimeLimit/60)]:[TimeCalc]"
		if(!src.UpdateHUDText(D.name,"[D.name][TimeTag]"))
			var/obj/Supplemental/QuestLoc/Q=new();src.client.screen+=Q
			Q.name=D.name;Q.screen_loc="1:2,[hudy]:[hudyo]"
			src.CreateHUDText(1,13,hudy,hudyo,"Quest",src,"[D.name]","[D.name][TimeTag]")
			hudyo+=2

mob/proc/LocateQuest(var/datum/QuestDatum/Q)
	if(usr.OnLevelScreen)	return
	if(usr.client.eye!=locate(10,67,2))	src.ViewMap()
	for(var/datum/ObjectiveDatum/O in Q.Objectives)
		var/mob/A
		if(O.Objective=="Speak With")
			for(var/obj/NPC/N in world)	if(N.name==O.Stat)	{A=N;break}
		if(O.Objective=="Kill")
			for(var/mob/Enemy/E in world)	if(initial(E.name)==O.Stat)	{A=E;break}
		if(O.Objective=="Collect")
			for(var/obj/NPC/Random/QuestChest/C in world)	if(C.name=="QC [O.Stat]")	{A=C;break}
		if(!A)	continue
		var/StartX;var/StartY
		var/InitZ=(A.z==2 ? initial(A.z) : A.z)
		if(InitZ==1)	{StartX=200;StartY=200}
		if(InitZ==3)	{StartX=200;StartY=0}
		if(InitZ==4)	{StartX=0;StartY=200}
		if(InitZ==6)	{StartX=0;StartY=0}
		if(InitZ==7)	{StartX=0;StartY=400}
		if(InitZ==9)	{StartX=400;StartY=200}
		if(InitZ==10)	{StartX=400;StartY=400}
		StartX+=4+(A.z==2 ? initial(A.x) : A.x);StartY+=(A.z==2 ? initial(A.y) : A.y)
		var/Xpos=1;var/Ypos=1
		while(StartX-16>32)	{Xpos+=1;StartX-=32}
		while(StartY>32)	{Ypos+=1;StartY-=32}
		var/obj/NO=new/obj/HUD/UnLearned_Skill(1,1);NO.icon='Other.dmi';NO.icon_state="Quest Here"
		NO.screen_loc="[Xpos]:[StartX-16],[Ypos]:[StartY-1]";src.client.screen+=NO;NO.layer+=1