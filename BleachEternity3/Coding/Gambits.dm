var/list/AllGambits=list()

datum/Gambits
	GambitHolder
		name="Command 1"
		proc/ActivateGambit(var/mob/Owner,var/mob/Pet)
			if(!src.Target || !src.Variable || !src.Operator || !src.VariableType || !src.Action)	return
			var/mob/ThisTarget=src.Target.RunGambit(Owner,Pet);if(!ThisTarget)	return
			var/ThisVarValue=src.Variable.RunGambit(ThisTarget);if(ThisVarValue==null)	return
			var/MaxVarValue=src.Variable.RunMaxGambit(ThisTarget)
			var/CheckOperator=src.Operator.RunGambit(ThisTarget,src.VariableType,ThisVarValue,MaxVarValue)
			if(!CheckOperator)	return
			if(!Pet.CanMove || Pet.Blocking || Pet.Stunned)	return 1
			return src.Action.RunGambit(ThisTarget,Owner,Pet)
		var/datum/Gambits/Targets/Target
		var/datum/Gambits/Variables/Variable
		var/datum/Gambits/Operators/Operator
		var/datum/Gambits/VariableTypes/VariableType
		var/datum/Gambits/Actions/Action

datum/Gambits
	var/name
	var/desc
	var/Value
	proc/GetValueInput()	return
	proc/RunGambit()	return
	proc/RunMaxGambit()	return
	Targets
		Pet
			name="Pet";desc="Select this Pet as the Target"
			RunGambit(var/mob/Owner,var/mob/Pet)	return Pet
		Owner
			name="Owner";desc="Select this Pet's Owner as the Target"
			RunGambit(var/mob/Owner,var/mob/Pet)	return Owner
		Enemy
			name="Enemy";desc="Select the closest Enemy as the Target"
			RunGambit(var/mob/Owner,var/mob/Pet)
				if(!Owner || !Pet)	return
				for(var/mob/E in oview(9,Pet)-Owner)
					if(Pet.Owner.CanPVP(E))	return E
		PartyMember
			name="Party Member";desc="Select a nearby Party Member"
			RunGambit(var/mob/Owner,var/mob/Pet)
				if(Owner && Owner.Party)
					for(var/mob/Player/M in Owner.Party.Members)
						if(MyGetDist(Pet,M)<=9)	return M
		PetTarget
			name="Pet's Target";desc="Select the Target of this Pet"
			RunGambit(var/mob/Owner,var/mob/Pet)
				if(Pet)	return Pet.Target
		OwnersTarget
			name="Owner's Target";desc="Select the Target of this Pet's Owner"
			RunGambit(var/mob/Owner,var/mob/Pet)
				if(Owner)	return Owner.Target
	Variables
		Level
			name="Level";desc="If the Target's Level is..."
			RunGambit(var/mob/ThisTarget)	return ThisTarget.Level
		Stamina
			name="Stamina";desc="If the Target's Stamina is..."
			RunGambit(var/mob/ThisTarget)	return ThisTarget.STM
			RunMaxGambit(var/mob/ThisTarget)	return ThisTarget.MaxSTM
		Reiatsu
			name="Reiatsu";desc="If the Target's Reiatsu is..."
			RunGambit(var/mob/ThisTarget)	return ThisTarget.REI
			RunMaxGambit(var/mob/ThisTarget)	return ThisTarget.MaxREI
		Mysic
			name="Mysic";desc="If the Target's Mystic is..."
			RunGambit(var/mob/ThisTarget)	return ThisTarget.MGC
		MysticDefense
			name="MysticDefense";desc="If the Target's Mystic Defense is..."
			RunGambit(var/mob/ThisTarget)	return ThisTarget.MGCDEF
		Strength
			name="Strength";desc="If the Target's Strength is..."
			RunGambit(var/mob/ThisTarget)	return ThisTarget.STR
		Vitality
			name="Vitality";desc="If the Target's Vitality is..."
			RunGambit(var/mob/ThisTarget)	return ThisTarget.VIT
		Agility
			name="Agility";desc="If the Target's Agility is..."
			RunGambit(var/mob/ThisTarget)	return ThisTarget.AGI
		Luck
			name="Luck";desc="If the Target's Luck is..."
			RunGambit(var/mob/ThisTarget)	return ThisTarget.LCK
		HasStatusEffect
			var/datum/StatusEffects/Effect2Check
			name="Has Status Effect";desc="If the Target has the Effect of..."
			RunGambit(var/mob/ThisTarget)
				return	//this isnt coded yet apparently <.<
				for(var/datum/StatusEffects/E in ThisTarget.StatusEffects)
					if(E.type==Effect2Check.type)	return 1
		LacksStatusEffect
			var/datum/StatusEffects/Effect2Check
			name="Lacks Status Effect";desc="If the Target doesn't have the Effect of..."
			RunGambit(var/mob/ThisTarget)
				return //this isnt coded yet apparently <.<
				for(var/datum/StatusEffects/E in ThisTarget.StatusEffects)
					if(E.type==Effect2Check.type)	return 0
				return 1
	Operators
		Effect
			name="Effect";desc="Has or Lacks a Status Effect"
			RunGambit(var/mob/Target,var/datum/Gambits/VType,var/Stat,var/MaxStat)	return 1
		LessThan
			name="Less Than";desc="If the Variable's Value is Less Than..."
			RunGambit(var/mob/Target,var/datum/Gambits/VType,var/Stat,var/MaxStat)
				if(istype(VType,/datum/Gambits/VariableTypes/Amount))
					if(Stat<VType.Value)	return 1
				if(istype(VType,/datum/Gambits/VariableTypes/Percent))
					if(round(Stat/MaxStat*100)<VType.Value)	return 1
		GreaterThan
			name="Greater Than";desc="If the Variable's Value is Greater Than..."
			RunGambit(var/mob/Target,var/datum/Gambits/VType,var/Stat,var/MaxStat)
				if(istype(VType,/datum/Gambits/VariableTypes/Amount))
					if(Stat>VType.Value)	return 1
				if(istype(VType,/datum/Gambits/VariableTypes/Percent))
					if(round(Stat/MaxStat*100)>VType.Value)	return 1
		EqualTo
			name="Equal To";desc="If the Variable's Value is Equal to..."
			RunGambit(var/mob/Target,var/datum/Gambits/VType,var/Stat,var/MaxStat)
				if(istype(VType,/datum/Gambits/VariableTypes/Amount))
					if(Stat==VType.Value)	return 1
				if(istype(VType,/datum/Gambits/VariableTypes/Percent))
					if(round(Stat/MaxStat*100)==VType.Value)	return 1
		NotEqualTo
			name="Not Equal To";desc="If the Variable's Value is Not Equal to..."
			RunGambit(var/mob/Target,var/datum/Gambits/VType,var/Stat,var/MaxStat)
				if(istype(VType,/datum/Gambits/VariableTypes/Amount))
					if(Stat!=VType.Value)	return 1
				if(istype(VType,/datum/Gambits/VariableTypes/Percent))
					if(round(Stat/MaxStat*100)!=VType.Value)	return 1
		LessThanEqualTo
			name="Less Than/Equal To";desc="If the Variable's Value is Less Than or Equal to..."
			RunGambit(var/mob/Target,var/datum/Gambits/VType,var/Stat,var/MaxStat)
				if(istype(VType,/datum/Gambits/VariableTypes/Amount))
					if(Stat<=VType.Value)	return 1
				if(istype(VType,/datum/Gambits/VariableTypes/Percent))
					if(round(Stat/MaxStat*100)<=VType.Value)	return 1
		GreaterThanEqualTo
			name="Greater Than/Equal To";desc="If the Variable's Value is Greater Than or Equal to..."
			RunGambit(var/mob/Target,var/datum/Gambits/VType,var/Stat,var/MaxStat)
				if(istype(VType,/datum/Gambits/VariableTypes/Amount))
					if(Stat>=VType.Value)	return 1
				if(istype(VType,/datum/Gambits/VariableTypes/Percent))
					if(round(Stat/MaxStat*100)>=VType.Value)	return 1
	VariableTypes
		/*Text
			name="Text";desc="Input a Text String"
			GetValueInput()
				src.Value=input("Input a Text Value","Input Value") as text*/
		Amount
			name="Amount";desc="Input a Numerical Value 0-9999"
			GetValueInput()
				usr.Chatting=1
				src.Value=input("Input a Numerical Amount between 0 and 9999","Input Value") as num
				src.Value=round(max(0,min(9999,src.Value)))
				usr.Chatting=0
		Percent
			name="Percent";desc="Input a Numerical Percentage 0-100"
			GetValueInput()
				usr.Chatting=1
				src.Value=input("Input a Numerical Percent between 0 and 100","Input Value") as num
				src.Value=round(max(0,min(100,src.Value)))
				usr.Chatting=0
		StatusEffect
			name="Status Effect";desc="Select a Status Effect"
			GetValueInput()
				usr.Chatting=1
				src.Value=input("Select a Status Effect","Input Value") as anything in AllStatusEffectsNames-"Unknown"
				usr.Chatting=0
	Actions
		Attack
			name="Attack";desc="Use a Basic Attack or Advance"
			RunGambit(var/mob/T,var/mob/O,var/mob/Pets/P)
				if(MyGetDist(P,T)==1)
					P.dir=get_dir(P,T)
					MyFlick("PullBack",P)
					P.Pulling=1
					var/image/I=image('Effects.dmi',P,"CounterStep",P.layer-1,SOUTH)
					if(T.client)	T.client<<I
					sleep(5)
					if(I)	del I
					if(!P)	return
					P.Pulling=0
					MyFlick("Attack",P)
					P.Attack(rand(1,3))
					spawn(3)	if(P)	P.dir=get_dir(P,T)
				else
					if(!step_to(P,T,1))
						P.TargetMob(null);return
				return 1
		UseSkill
			name="Use Skill";desc="Use the Selected Skill"
			GetValueInput(var/mob/Pets/P)
				usr.Chatting=1
				src.Value="[input("Select a Skill","Input Value") as anything in P.Skills]"
				usr.Chatting=0
			RunGambit(var/mob/T,var/mob/O,var/mob/Pets/P)
				if(!src.Value)	return
				P.UseSkillProc(src.Value);return 1
		UseItem
			name="Use Item";desc="Use the Selected Item"
			GetValueInput(var/mob/Pets/P)
				usr.Chatting=1
				var/list/UseableItems=list()
				for(var/obj/Items/O in usr.Inventory)
					if(O.HasUse)	UseableItems+=O
				src.Value="[input("Select an Item","Input Value") as anything in UseableItems]"
				usr.Chatting=0
			RunGambit(var/mob/T,var/mob/O,var/mob/Pets/P)
				if(!src.Value)	return
				for(var/obj/Items/I in O.Inventory)
					if(I.name==src.Value)
						if(I.Use(T)!="Failed")
							QuestShow(P.Owner,"[P] Used [src.Value] on [T]");return 1
						else
							QuestShow(P.Owner,"[P] Failed to Use [I]");return
				QuestShow(P.Owner,"No [src.Value]s Remaining for [P] to Use")
		Advance
			name="Advance";desc="Move Pet towards the Target"
			RunGambit(var/mob/T,var/mob/O,var/mob/Pets/P)
				return step_to(P,T)
		Retreat
			name="Retreat";desc="Move Pet away from the Target"
			RunGambit(var/mob/T,var/mob/O,var/mob/Pets/P)
				return step_away(P,T)