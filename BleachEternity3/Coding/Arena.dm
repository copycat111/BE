obj/Supplemental
	Arena
		density=0
		var/mob/User

mob/proc/StartArena()
	for(var/obj/Supplemental/Arena/A in world)
		if(!A.User)
			A.User=src
			src.Arena=A
			src.MatchStart()
			return
	QuestShow(src,"It Appears all Arenas are Full!")
	src.loc=locate(100,12,8)

mob/proc/MatchStart()
	if(!src.Arena)	return
	src.dir=EAST;src.loc=locate(src.Arena.x-3,src.Arena.y,src.Arena.z)
	src.ArenaBonus+=1*src.ArenaRound
	src.ArenaRound+=1
	var/NewType=pick(HollowTypes)
	if(src.ArenaRound%10==0)
		NewType=pick(typesof(/mob/Enemy/Bosses)-text2path("/mob/Enemy/Bosses"))
	var/mob/Enemy/Hollows/M=new NewType

	var/AR=src.ArenaRound
	var/Mmsg="Moving on to Round [AR]!  Next up it looks like we have a level [AR] [M.name]!  Will our contestant stand and fight!?"
	var/Mmsg1="Our contestant has fought bravely so far!  But how much longer can they last?  Will they continue on into Round [AR] against a level [AR] [M.name]!?"
	var/Mmsg2="Our contestant has already racked up [src.ArenaBonus] Bonus Copper!  Will they quit now and take it? or fight on into Round [AR] against a level [AR] [M.name] worth an additional [AR*1] Bonus Copper!?"
	var/Mmsg3="This is an impressive show of strength folks!  Our contestant has blown through [AR-1] hollows like it was nothing!  Lets hope they continue to Round [AR] against a level [AR] [M.name]!"
	var/Mmsg4="This next round is worth [AR*1] Bonus Copper.  I'm sure our contestant wont let us down!  Lets see if they can defeat the level [AR] [M.name] in Round [AR]!"
	Mmsg=pick(Mmsg,Mmsg1,Mmsg2,Mmsg3,Mmsg4)
	if(src.ArenaRound==1)	Mmsg="It looks like we have a new challenger folks!  Will they be able to fight their way through the hollows and attain glorious victory!?  The first match is about to begin!"
	if(src.ArenaRound%10==0)	Mmsg="Now its time to see what our challenger can really do!  Here in the [AR]th Round our challenger will be facing off against [M.name] at Level [AR]!  The battle is about to begin!"

	if(ShowAlert(src,"Announcer: > [Mmsg] > > Quit now for [src.ArenaBonus] Bonus Copper",list("Fight!","Quit"))=="Fight!")
		if(!src.Arena)	return
		M.loc=locate(src.Arena.x+3,src.Arena.y+rand(-2,2),src.Arena.z)
		M.dir=WEST
		M.SightRange=12
		M.TargetMob(src)
		M.StartedBy=src
		M.LevelShift(src.ArenaRound)
		spawn(rand(0,5))	if(M)	M.EnemyAI()
	else
		if(M)	del M
		if(!src)	return
		if(!src.Arena)	return
		src.loc=locate(100,12,8)
		src.GiveGold(0,0,src.ArenaBonus)
		src.LevelCheck()
		UpdateArenaScores(src.name,src.ArenaRound-1)
		QuestShow(src,"[src.ArenaBonus] Bonus Copper Received!")
		src.Arena.User=null;src.Arena=null
		src.ArenaBonus=0;src.ArenaRound=0