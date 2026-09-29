var/RequiredByondVersion

proc/VerifyByondVersion()
	var/Retries=0;RETRY;Retries+=1
	var/http[]=world.Export("http://www.angelfire.com/hero/straygames/ByondVersion.txt")
	if(!http)
		world<<"BYOND Version could not be Verified!"
		if(Retries<=10)	{world<<"Retry Attempt # [Retries]";goto RETRY}
		return
	RequiredByondVersion=text2num(file2text(http["CONTENT"]))
	return RequiredByondVersion

mob/proc/CheckByondVersion()
	if(src.client && src.client.byond_version<RequiredByondVersion)
		src<<"<font size=5 color=red><b>BYOND Version [RequiredByondVersion] or Higher is now Required to Play!"
		src<<link("http://www.byond.com/download/")
		del src.client

mob/GM/verb
	Verify_BYOND_Version()
		set category="GM"
		VerifyByondVersion()
		src<<"Required BYOND Version: [RequiredByondVersion]"
		for(var/mob/M in Players)	M.CheckByondVersion()

world/New()
	spawn()	VerifyByondVersion()
	return ..()

mob/Login()
	src.CheckByondVersion()
	return ..()