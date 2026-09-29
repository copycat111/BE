mob/proc/UpdateStatusEffects()
	if(!src.client)	return
	for(var/obj/StatusEffectDisplay/S in src.client.screen)	del S
	var/counter=0
	for(var/datum/StatusEffects/E in src.StatusEffects)
		var/obj/StatusEffectDisplay/S=new();S.RelatedEffect=E
		S.icon_state=E.name;S.screen_loc="[6+round(counter/2)]:[(counter*24)-(round(counter/2)*32)],[17-round(counter/10)]:8"
		S.mouse_over_pointer="MouseOver";src.client.screen+=S;counter+=1

obj/StatusEffectDisplay
	layer=19;icon='StatusEffects.dmi'
	var/datum/StatusEffects/RelatedEffect
	Click()
		if(usr.Chatting)	return
		if(!src.RelatedEffect)	return
		var/list/OList=list("Dispell","Close")
		var/datum/StatusEffects/RE=src.RelatedEffect
		if(!(RE in usr.StatusEffects) || RE.Abnormal)	OList-="Dispell"
		var/TimeRemaining="[round(RE.Duration/60)]m [RE.Duration-(round(RE.Duration/60)*60)]s"
		if(!RE.Duration)	TimeRemaining="Infinite"
		var/CompMsg="[RE.name] > > [RE.desc] > Source: [RE.CastBy] > Time Remaining: [TimeRemaining]"
		if(CustAlert(usr,CompMsg,OList,5,13,13,16)=="Dispell")	RE.RemovalProc(usr)

obj/Supplemental
	OrbitFront
		icon='Effects.dmi'
		layer=6
	OrbitBack
		icon='Effects.dmi'
		layer=MOB_LAYER-1

var/list/AllStatusEffects=list()
var/list/AllStatusEffectsNames=list()
datum/StatusEffects
	var/name="Unknown"
	var/desc="Unknown Effect"
	var/CastBy="Unknown Caster"
	var/Abnormal=0	//determines if good, or bad (can be dispelled or not)
	var/Duration=0	//in seconds, loops only get executed once per second on effects
	var/Stat2Boost
	var/Amt2Boost
	New(var/Durate,var/CastedBy)
		if(!isnum(Durate))	return
		src.Duration=Durate;src.CastBy="[CastedBy]"
	proc/Execute(var/mob/M)	return
	proc/AddProc(var/mob/M,var/ShowMsg=1)
		if(src.Stat2Boost)	M.vars[src.Stat2Boost]+=src.Amt2Boost
		if(src.Stat2Boost=="MaxSTM"||src.Stat2Boost=="MaxREI")	M.HUDRefresh()
		if(ShowMsg)	QuestShow(M,"Effect Gained: [src.name]")
		M.StatusEffects+=src;src.Execute(M)
		M.UpdateStatusEffects()
	proc/RemovalProc(var/mob/M,var/ShowMsg=1)
		if(src.Stat2Boost)	M.vars[src.Stat2Boost]-=src.Amt2Boost
		if(src.Stat2Boost=="MaxSTM")	{M.STM=min(M.STM,M.MaxSTM);M.StmBar()}
		if(src.Stat2Boost=="MaxREI")	{M.REI=min(M.REI,M.MaxREI);M.ReiBar()}
		if(src.Stat2Boost=="MaxSTM"||src.Stat2Boost=="MaxREI")	M.HUDRefresh()
		if(ShowMsg)	QuestShow(M,"Effect Fades: [src.name]")
		M.StatusEffects-=src;M.UpdateStatusEffects()
		del src;return
	Regen
		name="Regen";desc="Stamina will recover even during combat"
	Invincibles
		Last_Gasp
			name="Last Gasp"
			Duration=2;desc="Temporarily Prevents Damage after Last Gasp Activates"
		Quincy_Pride
			name="Quincy Pride"
			Duration=2;desc="Temporarily Prevents Damage after Quincy Pride Activates"
	StatBooster
		New(var/Name,var/Stat,var/Amt,var/Dur,var/Desc,var/CastedBy)
			src.name=Name;src.desc=Desc;src.Duration=Dur;src.CastBy="[CastedBy]"
			src.Stat2Boost=Stat;src.Amt2Boost=Amt
	ItemStatBooster
		New(var/obj/Items/StatBoosters/S,var/CastedBy)
			if(!istype(S,/obj/Items/StatBoosters))	return
			src.name=S.name;src.desc=S.desc;src.Duration=S.Duration;src.CastBy="[CastedBy]"
			src.Stat2Boost=S.Stat2Boost;src.Amt2Boost=S.Amt2Boost
	Berserk
		var/AtkBoost=0
		var/DefDown=0
		New(var/Nam,var/Atk,var/Def,var/Dur,var/CastedBy)
			src.name=Nam;src.AtkBoost=Atk;src.DefDown=Def
			var/DefTag="";if(src.DefDown)	DefTag=" > Increases Damage Taken by [src.DefDown]"
			src.desc="Increases Damage Dealt by [src.AtkBoost]%[DefTag]"
			src.Duration=Dur;src.CastBy="[CastedBy]"
	RadialEffects
		var/obj/Supplemental/OrbitFront/FrontObj=new
		var/obj/Supplemental/OrbitBack/BackObj=new
		var/FrontIS="BlueBallFront"
		var/BackIS="BlueBallBack"
		var/EffectRange=0
		var/ReiCost=0
		proc/AddOverlays(var/mob/M)
			M.overlays-=src.FrontObj;M.overlays-=src.BackObj
			src.FrontObj.icon_state="[src.FrontIS]"
			src.BackObj.icon_state="[src.BackIS]"
			M.overlays+=src.FrontObj;M.overlays+=src.BackObj
		New(var/Name,var/Durate,var/CastedBy,var/Stat2,var/Amt2,var/Desc,FIS,BIS,var/Range,var/Cost)
			if(!isnum(Durate))	return
			src.FrontIS=FIS;src.BackIS=BIS
			src.name=Name;src.desc=Desc
			src.Duration=Durate;src.CastBy="[CastedBy]"
			src.Stat2Boost=Stat2;src.Amt2Boost=Amt2
			src.EffectRange=Range;src.ReiCost=Cost
		AddProc(var/mob/M,var/ShowMsg=1)
			src.AddOverlays(M)
			return ..(M,ShowMsg)
		RemovalProc(var/mob/M,var/ShowMsg=1)
			M.overlays-=src.FrontObj;M.overlays-=src.BackObj
			return ..(M,ShowMsg)
		Execute(var/mob/M)
			if(src.ReiCost && M.REI<src.ReiCost)
				src.RemovalProc(M);return
			M.REI-=src.ReiCost;M.ReiBar()
			if(src.EffectRange && src.CastBy=="[M]" && !M.invisibility)
				for(var/mob/N in oview(src.EffectRange,M))	if(!M.CanPVP(N))
					N.AddEffect(new/datum/StatusEffects/RadialEffects(src.name,2,M,src.Stat2Boost,src.Amt2Boost,src.desc,\
						src.FrontIS,src.BackIS,0,0))
	PoisonTypes
		Abnormal=1
		New(var/Durate,var/CastedBy,var/Damage=10,var/Desc)
			if(!isnum(Durate))	return
			src.Duration=Durate;src.CastBy="[CastedBy]"
			src.Amt2Boost=Damage;src.desc=Desc
		Execute(var/mob/M)
			if(M.STM>1)
				DamageShow(M,src.Amt2Boost)
				M.STM=max(1,M.STM-src.Amt2Boost);M.StmBar()
		Poison
			name="Poison"
		Bleed
			name="Bleed"

mob/var/list/StatusEffects=list()

mob/proc/AddEffect(var/datum/StatusEffects/N)
	var/ShowMsg=1
	for(var/datum/StatusEffects/E in src.StatusEffects)	if(E.name==N.name)
		if(E.Duration && E.Duration<=N.Duration && E.Amt2Boost<=N.Amt2Boost)
			ShowMsg=0;E.RemovalProc(src,ShowMsg);break
		else	{del N;return}
	N.AddProc(src,ShowMsg)

mob/proc/FindEffect(var/Effect2Find)
	for(var/datum/StatusEffects/E in src.StatusEffects)
		if(E.name==Effect2Find)	return max(1,E.Duration)
	return 0

mob/proc/StatusDuration()
	for(var/datum/StatusEffects/E in src.StatusEffects)
		E.Execute(src);if(!E)	continue
		if(!E.Duration)	continue
		E.Duration-=1;if(E.Duration<=0)	E.RemovalProc(src)
