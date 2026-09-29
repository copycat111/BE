obj/NPC/Quest_Giver
	DblClick()
		if(src in get_step(usr,usr.dir))
			PlayMenuSound(usr,'TP_Talk_Start.wav')
			for(var/datum/QuestDatum/Q in src.Quests)
				if(usr.CompleteCheck(Q.name))//turning in the quest
					if(Q.name=="Shikai Training"&&usr.Class=="Soul Reaper")	usr.Skills+=new/obj/Skills/SoulReaper/Shikai
					if(Q.name=="Bankai Training"&&usr.Class=="Soul Reaper")	usr.Skills+=new/obj/Skills/SoulReaper/Bankai
					if(Q.name=="Sanrei Training"&&usr.Class=="Quincy")	usr.Skills+=new/obj/Skills/Quincy/Final_Form
					for(var/datum/ObjectiveDatum/O in Q.Objectives)
						if(O.Objective=="Collect")
							for(var/obj/Items/I in usr.Inventory)	if(I.name==O.Stat)	I.Discard(O.Goal)
					usr.QuestComplete(Q.ExpReward,Q.name,Q.GoldReward,Q.SilverReward,Q.CopperReward,Q.ItemReward)
					if(usr && Q.name=="Shikai Training" && usr.Class=="Soul Reaper")	usr.ZanCreation()
					return
				for(var/T in usr.CompletedQuests)//quest already done
					if(Q.name==T)	goto NextQuest
				if(usr.Level<Q.LevelReq)//not high enuf level to take the quest
					ShowText(usr,"** Come back once you've Reached Level [Q.LevelReq]")
					return
				if(Q.QuestReq)
					if(!ListCheck(Q.QuestReq,usr.CompletedQuests))
						ShowText(usr,"** Come back once you've Completed [Q.QuestReq]")
						return
				ShowText(usr,Q.desc)
				if(!usr)	return
				for(var/datum/QuestDatum/D in usr.Quests)
					if(D.name==Q.name)	return
				usr.QuestAdd(Q.name,src.loc,Q.Objectives,Q.ExpReward,Q.TimeLimit)
				return
				NextQuest
			ShowText(usr,"You have already completed all that I have to offer.  I thank you for your assistance.")
	Tutorial_Quest_Holder
		New()
			var/datum/QuestDatum/Q1;var/datum/ObjectiveDatum/OD
			Q1=new();Q1.name="Basic Training";Q1.ExpReward=25;Q1.desc="Speak with the Newbie Trainer about Game Basics"
			OD=new();OD.Objective="Speak With";OD.Stat="Newbie Trainer";OD.Goal=1
			Q1.Objectives+=OD;src.Quests+=Q1

			Q1=new();Q1.name="Combat Training";Q1.ExpReward=50;Q1.desc="Speak with the Combat Trainer about Combat Basics"
			OD=new();OD.Objective="Speak With";OD.Stat="Combat Trainer";OD.Goal=1
			Q1.Objectives+=OD;src.Quests+=Q1

			Q1=new();Q1.name="Hollow Practice";Q1.ExpReward=75;Q1.desc="Practice on Hollows to Reach Level 2"
			OD=new();OD.Objective="Reach";OD.Stat="Level";OD.Goal=2
			Q1.Objectives+=OD;src.Quests+=Q1

			Q1=new();Q1.name="Level Training";Q1.ExpReward=125;Q1.desc="Speak with the Combat Trainer Leveling Basics"
			OD=new();OD.Objective="Speak With";OD.Stat="Combat Trainer";OD.Goal=1
			Q1.Objectives+=OD;src.Quests+=Q1

			Q1=new();Q1.name="Hollow Hunting";Q1.ExpReward=250;Q1.desc="Defeat 20 Hollows in the Tutorial Area"
			OD=new();OD.Objective="Kill";OD.Stat="Ground Hollow";OD.Goal=10;Q1.Objectives+=OD
			OD=new();OD.Objective="Kill";OD.Stat="Flying Hollow";OD.Goal=10
			Q1.Objectives+=OD;src.Quests+=Q1
			return ..()
	Begining_Quester
		New()
			var/datum/QuestDatum/Q=new()
			Q.name="Starting Out";Q.ExpReward=150;Q.desc="To the West you'll find the Soul Reaper in charge of Training at this Facility.  Speak with him to get started. > > Objectives: Speak with the Training Reaper."
			var/datum/ObjectiveDatum/OD=new();Q.Objectives+=OD
			OD.Objective="Speak With";OD.Stat="Training Reaper"

			src.Quests=list(Q)
			return ..()
	Training_Reaper
		New()
			var/datum/QuestDatum/Q=new()
			Q.name="Academy Training";Q.ExpReward=200;Q.desc="There are some Academy Students Training outside.  Lets see how good you really are, I want you to join the students in their Sparring Exercises. > > Objectives: Defeat 10 First Year Students."
			var/datum/ObjectiveDatum/OD=new()
			OD.Objective="Kill";OD.Stat="First Year Student";OD.Goal=10
			Q.Objectives+=OD

			var/datum/QuestDatum/Q1=new()
			Q1.name="Spyder Squasher";Q1.ExpReward=250;Q1.desc="It seems you can hold your own against other students.  Now try the group of Spyder Hollows approaching the Training Outpost's West Wall. > > Objectives: Eliminate 15 Spyder Hollows."
			OD=new();OD.Objective="Kill";OD.Stat="Spyder";OD.Goal=15
			Q1.Objectives+=OD

			var/datum/QuestDatum/Q2=new()
			Q2.name="Menacing Mantaurs";Q2.ExpReward=300;Q2.desc="Mantaur Hollows are reinforcing the Spyder Hollows from the South, I want you to head over there and Eliminate them all. > > Objectives: Eliminate 20 Mantaur Hollows."
			OD=new();OD.Objective="Kill";OD.Stat="Mantaur";OD.Goal=20
			Q2.Objectives+=OD

			var/datum/QuestDatum/Q3=new()
			Q3.name="Moving On";Q3.ExpReward=150;Q3.desc="By the northern exit of the outpost you'll find a Soul Reaper standing guard.  He should have more Quests for you, Seek him out next. > > Objectives: Speak with the Guard Reaper."
			OD=new();Q3.Objectives+=OD
			OD.Objective="Speak With";OD.Stat="Guard Reaper"

			src.Quests=list(Q,Q1,Q2,Q3)
			return ..()
	Guard_Reaper
		New()
			var/datum/QuestDatum/Q=new()
			Q.name="Forestor";Q.LevelReq=5;Q.ExpReward=500;Q.desc="Several tree-shaped hollows have been spotted near the outpost, wipe them out before they take root. > > Objectives: Eliminate 10 Treezer Hollows."
			var/datum/ObjectiveDatum/OD=new();Q.Objectives+=OD
			OD.Objective="Kill";OD.Stat="Treezer";OD.Goal=10

			var/datum/QuestDatum/Q1=new()
			Q1.name="Snaking Suspicion";Q1.ExpReward=550;Q1.desc="As if those Tree Hollows werent bad enough, Now we've got serpent like hollows joining their ranks. > > Objectives: Eliminate 15 Slithar Hollows."
			OD=new();OD.Objective="Kill";OD.Stat="Slithar";OD.Goal=15
			Q1.Objectives+=OD

			var/datum/QuestDatum/Q2=new()
			Q2.name="Slime Suffocation";Q2.ExpReward=600;Q2.desc="There is a gap in the fence to the northeast and the forsaken lake reaches through.  This has drawn some Sea Spines to the area.  They arent really a major threat, but they are killing the grass! > > Objectives: Eliminate 20 Sea Spine Hollows."
			OD=new();OD.Objective="Kill";OD.Stat="Sea Spine";OD.Goal=20
			Q2.Objectives+=OD

			var/datum/QuestDatum/Q3=new()
			Q3.name="Scavangers";Q3.ExpReward=650;Q3.desc="Spire Gulls have been amassing in front of the Floating Pillars.  They attack anyone who tries to enter the area, see if you can clear them out for us. > > Objectives: Eliminate 25 Spire Gull Hollows."
			OD=new();OD.Objective="Kill";OD.Stat="Spire Gull";OD.Goal=25
			Q3.Objectives+=OD

			var/datum/QuestDatum/Q4=new()
			Q4.name="The Next Step";Q4.ExpReward=150;Q4.desc="Directly south of me, behind the buildings you'll find another Soul Reaper.  Find him to get your next set of missions. > > Objectives: Speak with the Alley Reaper."
			OD=new();Q4.Objectives+=OD
			OD.Objective="Speak With";OD.Stat="Alley Reaper"

			var/datum/QuestDatum/Q5=new()
			Q5.name="A Birthday Wish";Q5.ExpReward=250;Q5.desc="To the NorthWest of this outpost there's a small village named Arial.  It's my daughter, Sarah's, birthday today, but I can't leave my post here.  Could you go to Arial and wish her a happy birthday for me? > > Objectives: Speak with Sarah in Northern Arial."
			OD=new();Q5.Objectives+=OD
			OD.Objective="Speak With";OD.Stat="Sarah"

			src.Quests=list(Q,Q1,Q2,Q3,Q4,Q5)
			return ..()
	Alley_Reaper
		New()
			var/datum/QuestDatum/Q=new()
			Q.name="The Floating Pillars";Q.LevelReq=10;Q.ExpReward=750;Q.desc="To the North of this Training Outpost lies the Floating Pillars. As of late, frog-like Hollows have inhabited the area, Wipe them out before they become too powerfull. > > Objectives: Defeat 15 Frogling Hollows and 20 Tadite Hollows."
			var/datum/ObjectiveDatum/OD=new();Q.Objectives+=OD
			OD.Objective="Kill";OD.Stat="Tadite";OD.Goal=20
			var/datum/ObjectiveDatum/OD1=new();Q.Objectives+=OD1
			OD1.Objective="Kill";OD1.Stat="Frogling";OD1.Goal=15

			var/datum/QuestDatum/Q1=new()
			Q1.name="Boss: Frawg";Q1.ExpReward=1500;Q1.desc="There is one hollow at the Floating Pillars that seems to be much stronger then the others.  We have Tagged him 'Frawg'.  Eliminating him should reduce the threat generated by the other hollows inhabiting the pillars.  You may want to bring some friends with you on this one. > > * Right Click other Players to Create a Party > > Objectives: Eliminate Frawg."
			OD=new();OD.Objective="Kill";OD.Stat="Frawg";OD.Goal=1
			Q1.Objectives+=OD

			var/datum/QuestDatum/Q2=new()
			Q2.name="Onward to Arial";Q2.ExpReward=150;Q2.desc="Far to the Northwest you'll find a small town named Arial, which was contructed by the Soul Society to provide Support for this Training Outpost.  Meet with the Guard outside Arial for further Instructions. > > Objectives: Speak with the Arial Guard."
			OD=new();Q2.Objectives+=OD
			OD.Objective="Speak With";OD.Stat="Arial Guard"

			src.Quests=list(Q,Q1,Q2)
			return ..()
	Arial_Guard
		New()
			var/datum/QuestDatum/Q1=new()
			Q1.name="Wolfsbane";Q1.LevelReq=10;Q1.ExpReward=800;Q1.desc="Im sure you noticed the wulf hollows on your way here.  As you can see theyre blocking a major road between here and the Training Outpost. > > Objectives: Eliminate 10 Wulf Hollows."
			var/datum/ObjectiveDatum/OD=new();OD.Objective="Kill";OD.Stat="Wulf";OD.Goal=10
			Q1.Objectives+=OD;src.Quests+=Q1

			Q1=new();Q1.name="Werewolves?";Q1.ExpReward=900;Q1.desc="South of here are some humanoid wolf hollows.  They appear to be very dangerous, approach with caution. > > Objectives: Eliminate 15 Holwer Hollows."
			OD=new();OD.Objective="Kill";OD.Stat="Howler";OD.Goal=15
			Q1.Objectives+=OD;src.Quests+=Q1

			Q1=new();Q1.name="Werewolves!";Q1.ExpReward=1000;Q1.desc="Even further south youll find a group of hollows that resemble werewolves.  We need to prevent them from spreading any further! > > Objectives: Eliminate 20 Growler Hollows."
			OD=new();OD.Objective="Kill";OD.Stat="Growler";OD.Goal=20
			Q1.Objectives+=OD;src.Quests+=Q1

			Q1=new();Q1.name="Into the Muck";Q1.ExpReward=100;Q1.desc="Near the Northern wall of Arial you'll find a Soul Reaper guarding the entrance to the sewers.  Those sewers lead to Karakura, but lately we've been having problems with hollows emerging from them.  We've stationed a guard at the sewer entrance, speak with him for more details. > > Objectives: Speak with the Sewer Guard in Northern Arial."
			OD=new();OD.Objective="Speak With";OD.Stat="Sewer Guard"
			Q1.Objectives+=OD;src.Quests+=Q1
			return ..()
	Urahara
		icon='NPCs.dmi'
		icon_state="Urahara"
		New()
			var/datum/QuestDatum/Q1=new()
			Q1.name="Shikai Training";Q1.LevelReq=20;Q1.ExpReward=2500;Q1.desc="So you think you're ready to learn your Zanpakuto's name huh?  Meet me downstairs and we'll see. > > Objectives: Defeat Urahara in his Training Facility."
			var/datum/ObjectiveDatum/OD=new();OD.Objective="Kill";OD.Stat="Urahara";OD.Goal=1
			Q1.Objectives+=OD;src.Quests+=Q1

			Q1=new();Q1.name="Ultima";Q1.LevelReq=100;Q1.ExpReward=99999;Q1.desc="A Massive Hollow has appeared in Downtown Karakura, we've tagged it 'Ultima'.  It has already killed several Soul Reaper who attempted to stop it.  You may want to bring some support with you on this one. > > Objectives: Destroy Ultima."
			OD=new();OD.Objective="Kill";OD.Stat="Ultima";OD.Goal=1
			Q1.Objectives+=OD;src.Quests+=Q1
			return ..()
	Yoruichi
		icon='NPCs.dmi'
		icon_state="Yoruichi"
		New()
			var/datum/QuestDatum/Q1;var/datum/ObjectiveDatum/OD
			Q1=new();Q1.name="Bankai Training";Q1.LevelReq=50;Q1.ExpReward=10000;Q1.desc="This special training will allow you to unleash your Bankai in just 3 days. > > Objectives: Find and Defeat your Zanpakuto's Spirit within 3 minutes."
			OD=new();OD.Objective="Kill";OD.Stat="Zanpakuto Spirit";OD.Goal=1;Q1.TimeLimit=180
			Q1.Objectives+=OD;src.Quests+=Q1
			return ..()
	Arial
		Sarah
			icon='NPCs.dmi'
			icon_state="Little Girl"
			New()
				var/datum/QuestDatum/Q1=new()
				Q1.name="BDay Invitation";Q1.LevelReq=10;Q1.ExpReward=500;Q1.desc="Tomorrow is my birthday!  My friend samantha lives near the bottom left corner of Arial.  My mommy said I could invite her to my party!  So can you take this invitation to her? > > Objectives: Deliver a Birthday Invitation to Samantha."
				var/datum/ObjectiveDatum/OD=new();OD.Objective="Speak With";OD.Stat="Samantha"
				Q1.Objectives+=OD;src.Quests+=Q1

				Q1=new();Q1.name="Squishing the Squishies";Q1.LevelReq=10;Q1.QuestReq="Present Delivery";Q1.ExpReward=2500;Q1.desc="Ohhh those mean little hollows hurt samantha!?  Hey mister! I want you to go teach those hollows a lesson for me! > > Objectives: Kill 50 Squishy Hollows."
				OD=new();OD.Objective="Kill";OD.Stat="Squishy";OD.Goal=50
				Q1.Objectives+=OD;src.Quests+=Q1

				return ..()
		Samantha
			icon='NPCs.dmi'
			icon_state="Little Girl"
			New()
				var/datum/QuestDatum/Q1=new()
				Q1.name="Present Recovery";Q1.QuestReq="BDay Invitation";Q1.ExpReward=750;Q1.desc="I got Sarah a diary for her birthday.  But I lost it when those squishy little hollows attacked me!  I was playing at the beach when they got me, maybe you can find it for me? > > Objectives: Find Samantha's Diary. > > ** Take a right at the Arial Guard to reach the beach"
				var/datum/ObjectiveDatum/OD=new();OD.Objective="Collect";OD.Stat="Diary";OD.Goal=1
				Q1.Objectives+=OD;src.Quests+=Q1

				Q1=new();Q1.name="Present Delivery";Q1.ExpReward=1000;Q1.desc="Thanks for finding the diary.  I'm too hurt to get out of bed, so can you deliver it to Sarah for me? > > Objectives: Deliver Samantha's Present to Sarah."
				OD=new();OD.Objective="Speak With";OD.Stat="Sarah"
				Q1.Objectives+=OD;src.Quests+=Q1
				return ..()
		Sewer_Guard
			New()
				var/datum/QuestDatum/Q1;var/datum/ObjectiveDatum/OD
				Q1=new();Q1.name="Down and Around";Q1.LevelReq=15;Q1.ExpReward=2080;Q1.desc="If you're headed to Karakura you're gonna hafta go through the sewers.  We've lost a few good men down there so keep on your guard.  Before you get too deep into the sewers you should probably test the waters.  Take out 10 Gator Hollows and report back to me. > > Objectives: Defeat 10 Gators."
				OD=new();OD.Objective="Kill";OD.Stat="Gator";OD.Goal=10
				Q1.Objectives+=OD;src.Quests+=Q1

				Q1=new();Q1.name="Abounding Ratts";Q1.ExpReward=3315;Q1.desc="The Ratt population is getting out of hand.  If you can take out a decent amount of them then you should be ready to head deeper into the sewers. > > Objectives: Defeat 15 Ratts."
				OD=new();OD.Objective="Kill";OD.Stat="Ratt";OD.Goal=15
				Q1.Objectives+=OD;src.Quests+=Q1

				Q1=new();Q1.name="Stuck in the Sewers";Q1.ExpReward=250;Q1.desc="Well you seem to be doing good enough down there.  We currently have a couple Soul Reapers stationed down there in the B2 level.  See if they need help with anything. > > Objectives: Speak with the Stranded Reaper in Sewers B2."
				OD=new();OD.Objective="Speak With";OD.Stat="Stranded Reaper";OD.Goal=1
				Q1.Objectives+=OD;src.Quests+=Q1
				return ..()
	Sewers
		Stranded_Reaper
			New()
				var/datum/QuestDatum/Q1;var/datum/ObjectiveDatum/OD
				Q1=new();Q1.name="The Way Back Out";Q1.LevelReq=18;Q1.ExpReward=3510;Q1.desc="So I apparently got stationed down here in the sewers, just for accidentally blowing up a building with kidou.  I'm sure you noticed the bats and spiders on your way in, they're a problem to everyone.  Lets start by clearing those out. > > Objectives: Defeat 10 Sewer Bats > Defeat 10 Sewer Spiders."
				OD=new();OD.Objective="Kill";OD.Stat="Sewer Bat";OD.Goal=10;Q1.Objectives+=OD
				OD=new();OD.Objective="Kill";OD.Stat="Sewer Spider";OD.Goal=10
				Q1.Objectives+=OD;src.Quests+=Q1

				Q1=new();Q1.name="Giant Lizards";Q1.ExpReward=2730;Q1.desc="Lizards lizards everywhere, even in your underwear?. > > Objectives: Defeat 10 Giant Lizards > Defeat 10 Gekkos."
				OD=new();OD.Objective="Kill";OD.Stat="Gekko";OD.Goal=10;Q1.Objectives+=OD
				OD=new();OD.Objective="Kill";OD.Stat="Giant Lizard";OD.Goal=10
				Q1.Objectives+=OD;src.Quests+=Q1

				Q1=new();Q1.name="Corpses on the Move";Q1.ExpReward=2860;Q1.desc="The corpses are up and about, put them back down! > > Objectives: Defeat 10 Walking Corpses."
				OD=new();OD.Objective="Kill";OD.Stat="Walking Corpse";OD.Goal=10
				Q1.Objectives+=OD;src.Quests+=Q1

				Q1=new();Q1.name="Down to B3";Q1.ExpReward=250;Q1.desc="Looks like we've got this floor under control for now.  You should go see how the Soul Reaper on the next floor is doing. > > Objectives: Speak With B3 Reaper."
				OD=new();OD.Objective="Speak With";OD.Stat="B3 Reaper";OD.Goal=1
				Q1.Objectives+=OD;src.Quests+=Q1
				return ..()
		Hungry_Reaper
			New()
				var/datum/QuestDatum/Q1;var/datum/ObjectiveDatum/OD
				Q1=new();Q1.name="Poopsicles";Q1.LevelReq=18;Q1.ExpReward=2340;Q1.desc="So... Hungry...  I hear bat guano has high nutritional values, I think I saw some bats around here...  Hey you!  Bring me some guano would ya?  I'm too hungry to go running around. > > Objectives: Collect 10 Bat Guano."
				OD=new();OD.Objective="Collect";OD.Stat="Bat Guano";OD.Goal=10
				Q1.Objectives+=OD;src.Quests+=Q1

				Q1=new();Q1.name="Geiko Gekko";Q1.ExpReward=2600;Q1.desc="Those darn lizards won't stop trying to sell us insruance!  Go show them who the ones needing insurance are! > > Objectives: Defeat 10 Gekkos."
				OD=new();OD.Objective="Kill";OD.Stat="Gekko";OD.Goal=10
				Q1.Objectives+=OD;src.Quests+=Q1

				Q1=new();Q1.name="Hobo Sandwich";Q1.ExpReward=4290;Q1.desc="They just stick us down here and forget about us.  They never even send any food!  And those darn hobos down here, hording all the decent food... You know what, why don't you go fight some hobos for their ham sandwiches?  14 should keep me fed for a week or two! > > Objectives: Collect 14 Ham Sandwiches."
				OD=new();OD.Objective="Collect";OD.Stat="Ham Sandwich";OD.Goal=14
				Q1.Objectives+=OD;src.Quests+=Q1

				Q1=new();Q1.name="Full for Now";Q1.ExpReward=250;Q1.desc="Whew, I feel better after getting some food in me.  Can you deliver our progress report to the Soul Reaper in the next floor of the sewers?. > > Objectives: Speak With B3 Reaper."
				OD=new();OD.Objective="Speak With";OD.Stat="B3 Reaper";OD.Goal=1
				Q1.Objectives+=OD;src.Quests+=Q1
				return ..()
		Spiral_Reaper
			New()
				var/datum/QuestDatum/Q1;var/datum/ObjectiveDatum/OD
				Q1=new();Q1.name="Into the Spiral 1";Q1.LevelReq=24;Q1.ExpReward=4680;Q1.desc="This is the last floor of the sewers, but its still a pretty long walk before Karakura.  Start off slow, and feel free to come back here to rest. > > Objectives: Defeat 10 Sewer Bats > Defeat 10 Skeleton Brutes > Defeat 10 Skeletal Knights."
				OD=new();OD.Objective="Kill";OD.Stat="Skeleton Brute";OD.Goal=10;Q1.Objectives+=OD
				OD=new();OD.Objective="Kill";OD.Stat="Skeletal Knight";OD.Goal=10
				Q1.Objectives+=OD;src.Quests+=Q1

				Q1=new();Q1.name="Into the Spiral 2";Q1.ExpReward=5070;Q1.desc="Skeletons to Goblins.  See if you can take those out too. > > Objectives: Defeat 10 Goblins > Defeat 10 Goblin Raiders."
				OD=new();OD.Objective="Kill";OD.Stat="Goblin";OD.Goal=10;Q1.Objectives+=OD
				OD=new();OD.Objective="Kill";OD.Stat="Goblin Raider";OD.Goal=10
				Q1.Objectives+=OD;src.Quests+=Q1

				Q1=new();Q1.name="Into the Spiral 3";Q1.ExpReward=5460;Q1.desc="Goblins to Ooze!  See if you can take those out too. > > Objectives: Defeat 10 Slimes > Defeat 10 Sludges."
				OD=new();OD.Objective="Kill";OD.Stat="Slime";OD.Goal=10;Q1.Objectives+=OD
				OD=new();OD.Objective="Kill";OD.Stat="Sludge";OD.Goal=10
				Q1.Objectives+=OD;src.Quests+=Q1

				Q1=new();Q1.name="Into the Spiral 4";Q1.ExpReward=6500;Q1.desc="Finally the Roaches.  See if you can take those out too. > > Objectives: Defeat 10 Roach Coaches > Defeat the Roach Lord."
				OD=new();OD.Objective="Kill";OD.Stat="Roach Coach";OD.Goal=10;Q1.Objectives+=OD
				OD=new();OD.Objective="Kill";OD.Stat="Roach Lord";OD.Goal=1
				Q1.Objectives+=OD;src.Quests+=Q1

				Q1=new();Q1.name="Out of the Spiral";Q1.ExpReward=300;Q1.desc="Looks like you're ready to go.  Take the ladder up to Karakura and speak with Geize > > Objectives: Speak with Geize in Karakura."
				OD=new();OD.Objective="Speak With";OD.Stat="Geize";OD.Goal=1
				Q1.Objectives+=OD;src.Quests+=Q1
				return ..()
		B3_Reaper
			New()
				var/datum/QuestDatum/Q1;var/datum/ObjectiveDatum/OD
				Q1=new();Q1.name="Clearing the Path 1";Q1.LevelReq=25;Q1.ExpReward=4875;Q1.desc="This is the last section of sewers, but theres still plenty of hollows in your way. > > Objectives: Defeat 10 Skeletal Knights > Defeat 10 Goblins."
				OD=new();OD.Objective="Kill";OD.Stat="Skeletal Knight";OD.Goal=10;Q1.Objectives+=OD
				OD=new();OD.Objective="Kill";OD.Stat="Goblin";OD.Goal=10
				Q1.Objectives+=OD;src.Quests+=Q1

				Q1=new();Q1.name="Clearing the Path 2";Q1.ExpReward=5265;Q1.desc="Next up on the path are Goblin Raiders and Slimes. > > Objectives: Defeat 10 Goblin Raiders > Defeat 10 Slimes."
				OD=new();OD.Objective="Kill";OD.Stat="Goblin Raider";OD.Goal=10;Q1.Objectives+=OD
				OD=new();OD.Objective="Kill";OD.Stat="Slime";OD.Goal=10
				Q1.Objectives+=OD;src.Quests+=Q1

				Q1=new();Q1.name="Clearing the Path 3";Q1.ExpReward=5655;Q1.desc="Next up on the path are Sludges and Roach Coaches. > > Objectives: Defeat 10 Sludges > Defeat 10 Roach Coaches."
				OD=new();OD.Objective="Kill";OD.Stat="Sludge";OD.Goal=10;Q1.Objectives+=OD
				OD=new();OD.Objective="Kill";OD.Stat="Roach Coach";OD.Goal=10
				Q1.Objectives+=OD;src.Quests+=Q1

				Q1=new();Q1.name="Clearing the Path 4";Q1.ExpReward=6000;Q1.desc="Final Sewer Boss!  Take out the Roach Lord and you'll be ready for Karakura. > > Objectives: Defeat the Roach Lord."
				OD=new();OD.Objective="Kill";OD.Stat="Roach Lord";OD.Goal=1
				Q1.Objectives+=OD;src.Quests+=Q1

				Q1=new();Q1.name="A City of Lights";Q1.ExpReward=300;Q1.desc="You're probably tired of the dark damp sewers by now.  Luckily for you, Karakura is right up that ladder.  Head up there and speak with Geize for some new targets. > > Objectives: Speak with Geize in Karakura."
				OD=new();OD.Objective="Speak With";OD.Stat="Geize"
				Q1.Objectives+=OD;src.Quests+=Q1
				return ..()
	Karakura
		Jenny
			icon='SchoolFemale.dmi'
			New()
				var/datum/QuestDatum/Q1=new()
				Q1.name="Lost Purse";Q1.ExpReward=1500;Q1.desc="I seem to have lost my purse.  Do you think you can help me find it?  I must have dropped it somewhere around Urahara's Shop. > > Objectives: Find Jenny's Purse."
				var/datum/ObjectiveDatum/OD=new();OD.Objective="Collect";OD.Stat="Lost Purse";OD.Goal=1
				Q1.Objectives+=OD;src.Quests+=Q1
				return ..()
		Wounded_Reaper
			icon_state="Sitting"
			New()
				var/datum/QuestDatum/Q1=new()
				Q1=new();Q1.name="Healing Compound";Q1.LevelReq=20;Q1.ExpReward=2500;Q1.desc="I came down here to take care of the hollow infestation, but ended up getting hurt in the process.  Rashka could probably whip up a healing compound... Could you go find her for me?  She should be somewhere in Arial. > > Objectives: Find Rashka in Arial."
				var/datum/ObjectiveDatum/OD=new();OD.Objective="Speak With";OD.Stat="Rashka"
				Q1.Objectives+=OD;src.Quests+=Q1

				Q1=new();Q1.name="Clear a Path";Q1.QuestReq="Healing Compound Delivery";Q1.ExpReward=4000;Q1.desc="Thanks for the healing compound, now to get out of here.  I'm still not at 100% think you could help me clear a path out? > > Objectives: Eliminate 10 Gators."
				OD=new();OD.Objective="Kill";OD.Stat="Gator";OD.Goal=10
				Q1.Objectives+=OD;src.Quests+=Q1
				return ..()
		Rashka
			gender="female"
			New()
				var/datum/QuestDatum/Q1=new();var/datum/ObjectiveDatum/OD=new()
				Q1.name="Healing Compound Materials";Q1.QuestReq="Healing Compound";Q1.ExpReward=3000;Q1.desc="I see, so that fool went and got himself hurt again.  I can make the healing compound but I'll need some materials first.  The healing compound will require 10 Sour Flowers, 5 Tin Flowers, and 1 Sturdy Rock for mixing.  You should be able to find all of these materials along the path South of Arial.   > > Objectives: Collect Materials: > 10 Sour Flowers > 5 Tin Flowers > 1 Sturdy Rock"
				OD=new();OD.Objective="Collect";OD.Stat="Sour Flower";OD.Goal=10;Q1.Objectives+=OD
				OD=new();OD.Objective="Collect";OD.Stat="Tin Flower";OD.Goal=5;Q1.Objectives+=OD
				OD=new();OD.Objective="Collect";OD.Stat="Sturdy Rock";OD.Goal=1;Q1.Objectives+=OD
				src.Quests+=Q1

				Q1=new();Q1.name="Healing Compound Delivery";Q1.ExpReward=3500;Q1.QuestReq="Healing Compound Materials";Q1.desc="Ah, good, you've collected everything we need.  Give me a moment and I'll put together the healing compound... > ... ... > ... ... ... > OK, its ready, take this to him and he should be fine. > > Objectives: Bring the Healing Compound to the Wounded Soul Reaper."
				OD=new();OD.Objective="Speak With";OD.Stat="Wounded Reaper"
				Q1.Objectives+=OD;src.Quests+=Q1
				return ..()

		Geize
			New()
				var/datum/QuestDatum/Q1=new()
				Q1.name="Stuffed Love";Q1.LevelReq=30;Q1.ExpReward=4030;Q1.desc="Teddy Bear like hollows?  Don't be fooled by their appearance!  > > Objectives: Defeat 15 Deady Teddies."
				var/datum/ObjectiveDatum/OD=new();OD.Objective="Kill";OD.Stat="Deady Teddy";OD.Goal=15
				Q1.Objectives+=OD;src.Quests+=Q1

				Q1=new();Q1.name="Snipping Stingers";Q1.ExpReward=4160;Q1.desc="Scorpion hollows have infested the Karakura High School campus.  Get rid of them before anybody gets hurt! > > Objectives: Eliminate 20 Skorepeons."
				OD=new();OD.Objective="Kill";OD.Stat="Skorepeon";OD.Goal=20
				Q1.Objectives+=OD;src.Quests+=Q1

				Q1=new();Q1.name="Chilling Out";Q1.ExpReward=100;Q1.desc="Near the South West Corner of the School Campus you'll find a reaper named Shaizar.  Speak with him for more information... > > Objectives: Speak with Shaizar outside Karakura High."
				OD=new();OD.Objective="Speak With";OD.Stat="Shaizar"
				Q1.Objectives+=OD;src.Quests+=Q1
				return ..()
		Shaizar
			New()
				var/datum/QuestDatum/Q1=new()
				Q1.name="Frozen Crusade";Q1.LevelReq=30;Q1.ExpReward=4290;Q1.desc="Freezers are clogging up the Ice Caverns.  Clear them out for us. > > Objectives: Defeat 10 Freezers."
				var/datum/ObjectiveDatum/OD=new();OD.Objective="Kill";OD.Stat="Freezer";OD.Goal=10
				Q1.Objectives+=OD;src.Quests+=Q1

				Q1=new();Q1.name="Chilling Howls";Q1.ExpReward=4420;Q1.desc="These Arctic Wulfs are Dangerous, the've injured several explorers.  Get rid of them before anyone else gets hurt. > > Objectives: Eliminate 15 Arctic Wulfs."
				OD=new();OD.Objective="Kill";OD.Stat="Arctic Wulf";OD.Goal=15
				Q1.Objectives+=OD;src.Quests+=Q1

				Q1=new();Q1.name="Hot Ice";Q1.ExpReward=4550;Q1.desc="Ice on Fire?  That may not make sense, but your weapons should still work on them. > > Objectives: Destroy 20 Shivering Flames."
				OD=new();OD.Objective="Kill";OD.Stat="Shivering Flame";OD.Goal=20
				Q1.Objectives+=OD;src.Quests+=Q1

				Q1=new();Q1.name="Subzero Honor";Q1.ExpReward=4680;Q1.desc="The Icicle Knights are tied to this world by strong bonds of Honor.  Give their souls peace! > > Objectives: Take Out 25 Icicle Knights."
				OD=new();OD.Objective="Kill";OD.Stat="Icicle Knight";OD.Goal=25
				Q1.Objectives+=OD;src.Quests+=Q1
				return ..()
		Chilly_Reaper
			New()
				var/datum/QuestDatum/Q1=new()
				Q1.name="Ice Golem";Q1.LevelReq=35;Q1.ExpReward=5000;Q1.desc="Deep within these Ice Caverns lurks an Ice Golem Hollow.  Finish it off for me and I'll make it worth your while. > > Objectives: Defeat the Ice Golem."
				var/datum/ObjectiveDatum/OD=new();OD.Objective="Kill";OD.Stat="Ice Golem";OD.Goal=1
				Q1.Objectives+=OD;src.Quests+=Q1

				Q1=new();Q1.name="The Ever Forest?";Q1.ExpReward=100;Q1.desc="If you take the exit past the Ice Golem it will lead you to the Ever Forest.  In the eastern region of the Ever Forest there lies a village known as Rugella.  Find the chief of the village, Guanto, for more objectives to complete. > > Objectives: Speak with Guanto at Rugella in the Ever Forest."
				OD=new();OD.Objective="Speak With";OD.Stat="Guanto"
				Q1.Objectives+=OD;src.Quests+=Q1
				return ..()
	Ever_Forest
		Guanto
			icon='NPCs.dmi';icon_state="Chief"
			New()
				var/datum/QuestDatum/Q1=new()
				Q1.name="Canadian Lumber";Q1.LevelReq=35;Q1.ExpReward=4810;Q1.desc="There have been reports of living trees to the South of the village.  They appear to pose a threat to the inhabitants of the village.  We have requested somebody be sent to eliminate them for us, that must be you.  If you follow the path out of the village to the South, and then to the East, you should be able to spot the Treen.  > > Objectives: Defeat 10 Treen Hollows."
				var/datum/ObjectiveDatum/OD=new();OD.Objective="Kill";OD.Stat="Treen";OD.Goal=10
				Q1.Objectives+=OD;src.Quests+=Q1

				Q1=new();Q1.name="Oh Snap, Fly Snap!";Q1.ExpReward=4940;Q1.desc="Venus Fly Traps with Hollow Masks?  Directly West of the Treens you just did battle with, They've been snatching up the souls of anyone unlucky enough to cross their paths.  We sent out a party of our hunters to deal with them, but, sadly, none returned.  Please eliminate the Fly Snaps for us, and set our hunter's souls to rest. > > Objectives: Eliminate 15 Fly Snaps."
				OD=new();OD.Objective="Kill";OD.Stat="Fly Snap";OD.Goal=15
				Q1.Objectives+=OD;src.Quests+=Q1

				Q1=new();Q1.name="Tangled Green";Q1.ExpReward=5070;Q1.desc=". > > Objectives: Eliminate 20 Lost Vines."
				OD=new();OD.Objective="Kill";OD.Stat="Lost Vines";OD.Goal=20
				Q1.Objectives+=OD;src.Quests+=Q1
				return ..()
		Eganto
			icon='NPCs.dmi';icon_state="Native"
			New()
				var/datum/QuestDatum/Q1;var/datum/ObjectiveDatum/OD
				Q1=new();Q1.name="A Brother's Revenge";Q1.LevelReq=35;Q1.ExpReward=5500;Q1.desc="Those Treen Hollows stole my little brothers life!  He was out playing and wandered to far from the village when they got him.  I'd do something about it myself, but I know I'm too weak to fight such monsters.  Please, destroy as many of them as you can!  Bring me back 10 of their arms so my brother's soul may rest in peace. > > Objectives: Collect 10 Treen Arms."
				OD=new();OD.Objective="Collect";OD.Stat="Treen Arms";OD.Goal=10
				Q1.Objectives+=OD;src.Quests+=Q1
				return ..()
		Nobano
			icon='NPCs.dmi';icon_state="Native"
			New()
				var/datum/QuestDatum/Q1;var/datum/ObjectiveDatum/OD
				Q1=new();Q1.name="Into the Fire";Q1.LevelReq=50;Q1.ExpReward=7020;Q1.desc="To the North of our village lies the sacred volcano.  Inside it the Volcanic Enclave where we used to hold many of our rituals and festivals has become populated by monsters!  Our weapons have no effect against their firey bodies, perhaps you can do something about them for us? > > Objectives: Defeat 10 Lava Balls."
				OD=new();OD.Objective="Kill";OD.Stat="Lava Ball";OD.Goal=10
				Q1.Objectives+=OD;src.Quests+=Q1

				Q1=new();Q1.name="Great Balls of Fire";Q1.ExpReward=10725;Q1.desc="So it seems your abilities are far beyond our own.  Perhaps you would be willing to further exterminate the threats harbored inside the Enclave? > > Objectives: > Defeat 5 Lava Balls. > Defeat 15 Fire Walkers."
				OD=new();OD.Objective="Kill";OD.Stat="Lava Ball";OD.Goal=5
				Q1.Objectives+=OD
				OD=new();OD.Objective="Kill";OD.Stat="Fire Walker";OD.Goal=15
				Q1.Objectives+=OD;src.Quests+=Q1
				return ..()
		Bantuu
			icon='NPCs.dmi';icon_state="Native"
			New()
				var/datum/QuestDatum/Q1;var/datum/ObjectiveDatum/OD
				Q1=new();Q1.name="Heat of the Soul";Q1.LevelReq=50;Q1.ExpReward=12000;Q1.ItemReward="/obj/Items/Equipment/Back/Crystal_Threaded_Cape"
				Q1.desc="North of here, the monsters in the Volcanic Enclave contain the hottest souls known to our people.  We use the Crystals forged by their souls to create a variety of trinkets here in the village.  Lately, however, our stocks of these Flaming Crystals have been running low, and the monsters are becoming more and more powerful.  Could you collect some for me?  If you bring me 25 I will craft you a special trinket. > > Objectives: Collect 25 Flaming Crystals."
				OD=new();OD.Objective="Collect";OD.Stat="Flaming Crystal";OD.Goal=25
				Q1.Objectives+=OD;src.Quests+=Q1
				return ..()
		Native_Snake
			icon='NPCs.dmi';icon_state="Native"
			New()
				var/datum/QuestDatum/Q1;var/datum/ObjectiveDatum/OD
				Q1=new();Q1.name="CRAB BATTLE!!!";Q1.LevelReq=50;Q1.ExpReward=15000;Q1.desc="I've encountered some kind of cave demon. > I... I don't think I'll be leaving this place alive. > OH MY GOD!... It's looking right at me... > SWEET JESUS!!!  IT'S GETTING CLOSER!!! > It'll tear me to shreds!! > A knife is useless against those massive claws!  They could rip a tank apart!  Jesus Christ! > Errg!  It's... it's moving so fast... CRAB BATTLE!!! > > Objectives: Defeat the Kenyan Mangrove Crab in an Epic CRAB BATTLE!!!"
				OD=new();OD.Objective="Kill";OD.Stat="Kenyan Mangrove Crab";OD.Goal=1
				Q1.Objectives+=OD;src.Quests+=Q1
				return ..()
		Grandpa_Ishida
			icon='NPCs.dmi';icon_state="Grandpa Ishida"
			New()
				var/datum/QuestDatum/Q1;var/datum/ObjectiveDatum/OD
				Q1=new();Q1.name="Sanrei Training";Q1.LevelReq=25;Q1.ExpReward=2500;Q1.desc="The Sanrei Gloves allows you to disperse spirit particles at a high level.  When you put it on and form a bow, if you can maintain it for 7 days and 7 nights, you will reach the pinnacle of a quincy's power.  When the glove is removed your ability to draw in spirit particles will have passed the limits of a quincy. > > Objectives: Fire your Quincy Bow 777 times."
				OD=new();OD.Objective="Fire Bow";OD.Stat="Times";OD.Goal=777
				Q1.Objectives+=OD;src.Quests+=Q1
				return ..()

obj/NPC
	Newbie_Trainer
		New()
			var/datum/QuestDatum/Q=new();Q.name="Basic Training"
			src.Quests=list(Q)
			return ..()
		DblClick()
			if(src in get_step(usr,usr.dir))
				PlayMenuSound(usr,'TP_Talk_Start.wav')
				ShowText(usr,"You won't be able to battle or interact with certain NPCs unless you are in Spirit Form. > > ** Press Space Bar to enter Spirit Form. > > ** Press Tab to return to your Gigai or Physical Body.")
				if(!usr)	return
				if(usr.TutLevel<1)
					usr.TutLevel=1
					usr.QuestComplete(25,"Basic Training",Item2Give="/obj/Items/Potions/Energy_Drink")
	Combat_Trainer
		New()
			var/datum/QuestDatum/Q=new();Q.name="Combat Training"
			var/datum/QuestDatum/Q1=new();Q1.name="Hollow Practice"
			var/datum/QuestDatum/Q2=new();Q2.name="Level Training"
			src.Quests=list(Q,Q1,Q2)
			return ..()
		DblClick()
			if(src in get_step(usr,usr.dir))
				PlayMenuSound(usr,'TP_Talk_Start.wav')
				if(!usr.SpiritForm)
					ShowText(usr,"You Must be in Spirit Form to talk to this NPC")
					return
				if(usr.Level<2)
					switch(usr.Class)
						if("Soul Reaper")
							ShowText(usr,"Time for Combat Training! > Combat is performed with the S, D, and F keys")
							ShowText(usr,"Chain Attacks: > Soul Reapers can execute Chain Combos by quickly Linking Attacks. > At your current Level the only Chains you know are FFF, SFF, and DFF")
							ShowText(usr,"Guarding: > Use the G Key to Guard. > Guarding Directly after a Chain will prevent you from taking Damage. > You will also Automaticaly face any Enemy that Hits you while Guarding > > You can Counter Step behind an enemy by pressing G just as they are preparing to attack.  This will leave them open for attack!")
						if("Quincy")
							ShowText(usr,"Time for Combat Training! > Bow Combat: > S will Charge an Arrow's Attack Power. > D will Charge an Arrow's Range. > F will Fire a Charged Arrows in your Current Direction")
							ShowText(usr,"Flash Stepping: > Quincy's have naturally high Speed.  By Double Clicking the Map you can Flash Step. > Use this method to Avoid taking Damage while Charging Arrows. > After performing a Flash Step you will automatically face your current Target.")
						if("Bount")
							ShowText(usr,"Time for Combat Training! > Pet Combat: > S will Call your Pet Back. > D will Activate your Pet. > F will use a basic Melee Attack")
							ShowText(usr,"To Summon and Dismiss your Pet press the A key after Selecting the appropriate Skill. > Click the Active Skill Icon at the top of your HUD under the REI Stat to display available Skills.")
							ShowText(usr,"Setup your Pet's Soul Sync Combo Chain: > Click the Blue LVL Orb in the Top Right of your HUD. > Once at the Level Screen, Select the Combo Tab at the Bottom. > From the Combo Screen, Click the Drop Down Arrows to Make Various Selections.")
					ShowText(usr,"Targeting: > Pressing T will Target the Closest Enemy. > If you don't have a Target and are Hit by an Enemy then you will Automatically Target them. > You can also Click on an Enemy to Target or UnTarget them.")
					ShowText(usr,"Down the Path to the Right are Some Hollows.  > Use them to Practice. > Come back and Talk to me once you've Reached Level 2.")
					if(!usr)	return
					if(usr.TutLevel<2)
						usr.QuestComplete(50,"Combat Training",Item2Give="/obj/Items/Potions/Phoenix_Feather")
						if(!usr)	return
						var/datum/ObjectiveDatum/OD=new()
						OD.Objective="Reach";OD.Stat="Level";OD.Goal=2
						usr.QuestAdd("Hollow Practice",src.loc,list(OD))
						ShowText(usr,"** A Gray ? Over an NPC's Head means you have UnFinished Quests with Them")
						if(usr)	usr.TutLevel=2
				else
					ShowText(usr,"The Orbs at the Top of your Screen Allow you to keep track of Different Stats. > Clicking on any of these Orbs will Display further Information about that Stat.")
					ShowText(usr,"The Yellow ! orb keeps track of your Quests. > Clicking on it will display your current que of Quests.")
					ShowText(usr,"Exp earned during battle will be displayed over the Exp Orb. > This will cause the orb to slowly Fill with Green Spirit Energy. > Once it becomes full you will gain a level.")
					ShowText(usr,"When you Level up you gain Stat, Skill, and Trait Points. > The LvL Orb will continue to glow as long as you have points remaining. > > By clicking the LvL Orb you can select how to Distribute these Points. > > The point distribution screens use a simple point and click system.")
					if(!usr)	return
					if(usr.TutLevel<3)
						usr.QuestComplete(75,"Hollow Practice");if(!usr)	return
						usr.QuestComplete(125,"Level Training");if(!usr)	return
						usr.TutLevel=3
	Final_Trainer
		New()
			var/datum/QuestDatum/Q=new()
			Q.name="Hollow Hunting";Q.LevelReq=2
			src.Quests=list(Q)
			return ..()
		DblClick()
			if(src in get_step(usr,usr.dir))
				PlayMenuSound(usr,'TP_Talk_Start.wav')
				if(usr.CompleteCheck("Hollow Hunting") || ListCheck("Hollow Hunting",usr.CompletedQuests))
					ShowText(usr,"You've finished all the training, Good job!  > The Portal Below me will Take you to the Main World.  Good Luck!")
					if(!usr)	return
					if(usr.TutLevel<4)
						usr.QuestComplete(250,"Hollow Hunting")
						if(usr)	usr.TutLevel=4
				else
					ShowText(usr,"Click the Active Skill Icon at the top of your HUD under the REI Stat to display available Skills.  From the drop down that appears you can change your currently selected Skill. > Press the A Key to use that Selected Skill. > > HotKeys: > You can drag Skills from the Active Skill drop down menu to select HotKeys.")
					if(!usr)	return
					if(usr.Class=="Quincy")	ShowText(usr,"For Quincies, Use the Same method to Select your Arrow Type. > Clicking the Arrow Type Icon on the Left side of your HUD will Display your Arrow Type Options. > Arrow Types Cannot be HotKeyed")
					ShowText(usr,"Press Tab to return to your body if you need to recover before taking on more Hollows. > > ** When you are NOT in Spirit form you will Recover both Stamina and Reiatsu at a faster rate.")
					ShowText(usr,"For your Final Test, Take this Path to the Left and Kill 10 Ground Hollows and 10 Flying Hollows")
					var/datum/ObjectiveDatum/OD=new()
					OD.Objective="Kill";OD.Stat="Flying Hollow";OD.Goal=10
					var/datum/ObjectiveDatum/OD1=new()
					OD1.Objective="Kill";OD1.Stat="Ground Hollow";OD1.Goal=10
					if(!usr)	return
					usr.QuestAdd("Hollow Hunting",src.loc,list(OD,OD1))