var/list/GlobalVoters=list()
var/list/Votes=list()
var/list/VoteTypes=list(new/obj/Votes/Mute,new/obj/Supplemental/Vote_History)
var/list/VoteHistory=list()


obj/Supplemental
	Vote_History
		icon='Other.dmi'
		icon_state="VoteHistory"
		Click()
			var/HtmlText="<title>Vote Log</title><body bgcolor=black>"
			HtmlText+="<center><table bgcolor=black bordercolor=#CCCC99 border=1 width=100%>"
			HtmlText+="<tr><td><center><b><font color=#CCCC99>[VoteHistory.len] Votes Logged"
			for(var/x in VoteHistory)
				HtmlText+="<tr><td><b><font color=#CCCC99>[x]"
			HtmlText+="</table>"
			usr<<browse(HtmlText,"window=GenericBrowser")
obj/Votes
	var/Remaining=180
	var/Reason
	var/VoteStarter
	var/VoteStarterKey
	var/VoteStarterIP
	var/VoteName
	var/VoteKey
	var/VoteIP
	var/Yes=0
	var/No=0
	var/list/Voters=list()
	icon='Other.dmi'
	New()
		spawn(1800)	if(src.name!=initial(src.name))
			world<<"[VoteInfoTag]Vote to <b>[initial(src.name)] [src.VoteName]([src.VoteKey])</b> has <b>Ended:</b> [src.Yes]Y / [src.No]N"
			if(src.Yes>src.No)
				VoteHistory+="[initial(src.name)] [src.VoteName]([src.VoteKey])<br>Started by [src.VoteStarter]([src.VoteStarterKey])<br>[src.Reason]<br>Successful: [src.Yes]Y / [src.No]N"
				world<<"[VoteInfoTag]Vote to <b>[initial(src.name)] [src.VoteName]([src.VoteKey])</b> was <b>Successful</b> - [src.VoteName]([src.VoteKey]) has been Muted"
				src.WonVote()
			else
				VoteHistory+="[initial(src.name)] [src.VoteName]([src.VoteKey])<br>Started by [src.VoteStarter]([src.VoteStarterKey])<br>[src.Reason]<br>Rejected: [src.Yes]Y / [src.No]N"
				world<<"[VoteInfoTag]Vote to <b>[initial(src.name)] [src.VoteName]([src.VoteKey])</b> was <b>Rejected - [src.VoteStarter]([src.VoteStarterKey]) has been Muted</b>"
				src.LostVote()
			del src
		spawn(10)
			while(src)
				if(src.name!=initial(src.name))
					src.Remaining-=1
					var/TimeCalc=src.Remaining-(round(src.Remaining/60)*60)
					if(TimeCalc<10)	TimeCalc="0[TimeCalc]"
					src.suffix="[src.Yes]Y/[src.No]N   [round(src.Remaining/60)]:[TimeCalc]"
					sleep(10)
				else	break
		return ..()
	Del()
		Votes-=src
		return ..()
	proc
		WonVote()	return
		LostVote()	return
	Click()
		if(src.name==initial(src.name))
			if((usr.key in GlobalVoters)||(usr.client.address in GlobalVoters))
				QuestShow(usr,"Limit One Vote Start per Hour!");return
			if(usr.IsMuted())//Checks to see if starter is already muted
				QuestShow(usr,"Cannot Start Votes while Muted");return
			var/list/Mobs=list()
			for(var/mob/M in world)	if(M.client && M.LastSays.len)	Mobs+=M
			var/mob/M=input("Select a Player to Start the Vote Against","Vote [src.name]") as null|anything in Mobs-usr
			if(!M)	return
			if(M.key=="Falacy")	return
			var/NewReason=input("Select the Message to Mute for:","Vote Mute Reason") as null|anything in M.LastSays
			if(!M || !usr || !NewReason)	return
			if((usr.key in GlobalVoters)||(usr.client.address in GlobalVoters))
				QuestShow(usr,"Limit One Vote Start per Hour!");return
			if(usr.IsMuted())//Checks to see if starter is already muted
				QuestShow(usr,"Cannot Start Votes while Muted");return
			for(var/obj/Votes/V in Votes)
				if(V.VoteKey==usr.key)
					QuestShow(usr,"Cannot Start Vote while Voted Against");return
			for(var/datum/PlayerInfo/P in MuteList)//Checks to see if player is already muted
				if(P.Key==M.key || P.IP==M.client.address)
					QuestShow(usr,"This Player is Already Muted");return
			for(var/obj/Votes/V in Votes)
				if(V.VoteKey==M.key)
					QuestShow(usr,"A Vote is Already Underway Against this Player");return
			if(!NewReason)
				QuestShow(usr,"Must Submit a Valid Reason!");return
			VoteLimit(usr.key,usr.client.address)
			world<<"[VoteInfoTag]A Vote to Mute <b>[M]([M.key])</b> has been Started By <b>[usr]([usr.key])</b>"
			world<<"[VoteInfoTag]Reason:</b> [NewReason]"
			var/NewPath=text2path("/obj/Votes/[src.name]")
			var/obj/Votes/V=new NewPath;V.VoteStarter=usr.name;V.Reason=NewReason
			V.VoteName=M.name;V.VoteStarterKey=usr.key;V.VoteStarterIP=usr.client.address
			V.name="[src.name] [M]";V.VoteKey=M.key;V.VoteIP=M.client.address;Votes+=V
		else
			if((usr.key in src.Voters)||(usr.client.address in src.Voters))
				QuestShow(usr,"Already Voted!");return
			src.Voters+=usr.key;src.Voters+=usr.client.address
			if(alert("[src.name] \nStarted By: [src.VoteStarter] \nReason: [src.Reason]","[src.name]","Mute [VoteName] ([VoteKey])","Mute [VoteStarter] ([VoteStarterKey])")=="Mute [VoteName] ([VoteKey])")
				src.Yes+=1
			else	src.No+=1
	Mute
		icon_state="Mute"
		WonVote()
			var/HH=text2num(time2text(world.realtime,"hh"))+1
			if(HH<=9)	HH="0[HH]"
			ExecuteMute(src.VoteName,src.VoteKey,src.VoteIP,"Vote Mute by [src.VoteStarter]([src.VoteStarterKey]) \n[src.Reason]",time2text(world.realtime,"YYYYMMDD[HH]mm"),time2text(world.realtime,"[HH]:mm, MMM, DD YYYY"))
		LostVote()
			var/HH=text2num(time2text(world.realtime,"hh"))+1
			if(HH<=9)	HH="0[HH]"
			ExecuteMute(src.VoteStarter,src.VoteStarterKey,src.VoteStarterIP,"Failed Vote Against [src.VoteName]([src.VoteKey]) \n[src.Reason]",time2text(world.realtime,"YYYYMMDD[HH]mm"),time2text(world.realtime,"[HH]:mm, MMM, DD YYYY"))

proc/VoteLimit(var/Key,var/IP)
	GlobalVoters+=Key
	GlobalVoters+=IP
	spawn(36000)
		GlobalVoters-=Key
		GlobalVoters-=IP