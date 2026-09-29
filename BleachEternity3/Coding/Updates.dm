mob/verb
	ViewUpdates()
		set hidden=1
		src<<browse({"
			Recent Updates - Most Recent at Top<br>
			<b>Help Keep the Game Running Smoothly<br>
			Post any Bugs you Find on the Forums</b><br>
			<a href="http://www.byond.com/members/Falacy/forum" target="Z">Report A Bug</a><p>

			10-07-10<br>
			-Version 11.3<br>
			-Disabled Multi-Server Login Restrictions<p>

			07-19-10<br>
			-Version 11.2<br>
			-Changed Movement Systems<br>
			-Changed the Offensive Filters<p>

			03-03-10<br>
			-Version 11.1<br>
			-Added BYOND Client Version Verification<p>

			12-28-09<br>
			-Version 11.0<br>
			-Global Character Respec<br>
			-Fixed Bug with Zanpakuto Changes<p>

			12-27-09<br>
			-Version 10.9<br>
			-Added Global Mute Systems<br>
			-Added a Zanpakuto Manager<br>
			-Added and Updated Chat Filters<br>
			-Added GM Command: Download File<br>
			-Added F2 Macro for Taking ScreenShots<br>
			-Changed the Interface Image Buttons to Labels<br>
			-Disabled Vote Mutes<br>
			-Disabled Forum Linking at Logout<br>
			-Enemies Level 70+ will now Scale to Players 75+<br>
			-Raised the Layer of Status Effect HUDs (Mianata)<br>
			-Removed Window Transparency to Improve Performance<br>
			-Subscriptions will now Apply without Reloging<br>
			-Sub Font Color is now Selected from the Color Chart<br>
			-Fixed several RunTime Errors<br>
			-Fixed a few Non-Glowing Tiles in the Volcanic Enclave<p>

			08-09-09<br>
			-Version 10.8<br>
			-Fixed Bug with Infinite OverDrive (Naoh)<br>
			-Fixed Bug with Multi-Charging Arrow Distance (WufeiLord)<p>

			08-04-09<br>
			-Version 10.7<br>
			-Added Global Ban Reason Support<br>
			-Changed Portal density and layer<br>
			-Updated Website Links<p>

			07-29-09<br>
			-Version 10.6<br>
			-Compiled with BYOND v446.1027<br>
			-Added Zone Chat<br>
			-Added Pet Name Change on Right Click<br>
			-Changed the Hub Password<br>
			-Changed Portal density to 0 (Lorejul22)<br>
			-Changed the Invalid Command Notification<br>
			-Changed the Client Logger to not Log until Loaded<br>
			-Changed how Fast you Move while Following Somebody<br>
			-Changed the BG Color on the Top Image Button to Black<br>
			-Changed the PM System to use a null winget() Instead of a for() Loop<br>
			-Rounded the Corners of the Top Image Button's Image for Better Blending<br>
			-Updated the Sub Font Color Chart Link<br>
			-Fixed RunTime Error with Status Effect Pet Syncs<br>
			-Fixed Bug with Number Key 9 Showing a Note (Kaylee)<br>
			-Fixed Bug with Rukia having an Ichigo Voice Clip (Kaylee)<br>
			-Fixed Bug with Arena Monsters not Displaying the Correct Level (Quezziefox)<p>

			06-21-09<br>
			-Version 10.5<br>
			-Compiled with BYOND v442.1020<br>
			-Updated the Client Logger<br>
			-Attempted Fix for Parties not Deleting<p>

			06-06-09<br>
			-Version 10.4<br>
			-Compiled with BYOND v441.1019<br>
			-Added the Client Logger<br>
			-Added computer_id Global Ban Support<p>
			-Adjusted Quest Exp on Lvl 30+ Quests (W1ndswords)<br>
			-Removed Mirror Gate from the Spell Tree<br>
			-Fixed RunTime with Enemy Invisibility Checks<br>
			-Fixed 'Corpses on the Move' Quest Description (Trickeli)<p>

			05-21-09<br>
			-Version 10.3<br>
			-Added Option to Disable PMs<br>
			-Added Options for Auto Target Facing<br>
			-Added a Dummy NPC with Tutorial Quests<br>
			-Added New Quest Giver: B3 Reaper<br>
			-Added New Quest Giver: Spiral Reaper<br>
			-Added New Quest Giver: Hungry Reaper<br>
			-Added New Quest Giver: Stranded Reaper<br>
			-Added New Quest: Abounding Ratts (Sewer Guard)<br>
			-Added New Quest: Stuck in the Sewers (Sewer Guard)<br>
			-Changed all Forum Related Links<br>
			-Changed the mouse_opacity on Effects to 0<br>
			-Changed Save Notification from proc to verb<br>
			-Changed the hub_password to set at RunTime<br>
			-ReAdded the Parties Tab<br>
			-Removed Caching of RGBed Icons<br>
			-Removed Shadows near B3 Sewer Entrance<br>
			-Restricted Sending and Receiving PMs while Muted<br>
			-Limited max Exp Gains based on Level<br>
			-Enemy Specific Skills can now be Blocked<br>
			-Pressing Escape will now Cancel your Battle Stance<br>
			-Trait Related Updates:<br>
			* Kidou now effects Mystic Damage<br>
			* Zanjutsu now only effects Melee Damage<br>
			-Fixed Exploit with Turning in Quests Twice (ScreamJet)<br>
			-Fixed Spelling Error on Sub's Free Charges (Gester-89)<br>
			-Fixed Quincy Key Descriptions being Swapped (Ryuuk)<br>
			-Fixed Bug with Woosh Knockback Causing Agro<br>
			-Fixed Bug with Slam Attack Icon not being Displayed<br>
			-Fixed Bug with Enemies Attacking Players at Level Screens (Benito)<br>
			-Fixed Bug with the Use Option Showing on Progress Cupons (Deyudey)<p>

			05-14-09<br>
			-Version 10.2<br>
			-Added Key Display in Logout()<br>
			-Added Duel Name Info to PVP Duel Flags<br>
			-Added Player Checking from the Who List (ScreamJet)<br>
			-Changed the mouse_opacity on Duel Flags to 0<br>
			-Restricted Subscriber Access on Save Slots to New Only<p>

			05-14-09<br>
			-Version 10.1<br>
			-Added View -> Credits Menu<br>
			-Added an In-Depth Datum Profiler<br>
			-Added Follow and Duel Menus on Right Click<br>
			-Added Level and Class Display to Player Profiles<br>
			-Added Zanpakuto Call Information to Player Profiles<br>
			-Changed Levels on Skorepeon and Deady Teddy (Benitobrd)<br>
			-Removed Non-Useable Items from Pet AI Sync Selections<br>
			-Skill Related Updates:<br>
			* Lowered the Stun Time on Most Skills/Spells/Kidous<br>
			* Changed Bleed Damage on Wound (Beast Shikai)<br>
			* Changed Savior Skill Effects Time from 5 to 1 Seconds<br>
			* Changed the Heal Values on Heal Pet and Syphon Health (Bounts)<br>
			-Moved Sarah and Decorated her House<br>
			-Updated the View -> Forums Menu's Link<p>

			05-07-09<br>
			-Version 10.0<br>
			-Added Click Usage to HotKeys<br>
			-Added a Datum Counter Tracking System<br>
			-Added New Quest: A Birthday Wish (Guard Reaper)<br>
			-Added a Level Requirement on the BDay Invitation Quest<br>
			-Added a Message when Using Party Chat while not Partied<br>
			-Changed the Delay on Movement Speed<br>
			-Changed the MouseOver Pointer on Status Effects<br>
			-Changed the HotKeys Control Info from 1-0 to 1-9<br>
			-Changed the FAQs Visored Level to Match the Skills<br>
			-Removed Augmentation Spell: Jog<br>
			-Removed Augmentation Spell: Run<br>
			-Removed the Use Option from Non-Useable Items<br>
			-Removed Damage Multiplier from Reiatsu on Arrows<br>
			-Removed Boss Stat Multipliers from VIT and MGCDEF<br>
			-Removed Random Movement from the Zanpakuto Spirit<br>
			-Fixed Minor Mapping Error near the Arial Sewer Entrance<br>
			-Fixed Bug with not being able to Locate 'Collect' Quests<br>
			-Fixed Bug with Getsuga Tenshous Killing the Music (Ryuuk)<br>
			-Fixed Bug with 'Speak With' Quests not Making a Chat Sound<p>

			05-05-09<br>
			-Version 9.9<br>
			-Added Auto Target Facing on Skill Use<br>
			-Changed Energy Effects to Last for 2 Minutes Max<br>
			-Fixed Ichigo Hair State for D1 Combo Attack<br>
			-Fixed Bug with Appear Effects Existing Forever<p>

			05-05-09<br>
			-Version 9.8<br>
			-Added ProfileAtoms() to world/New()<br>
			-Changed Vote History Table Width to 100%<br>
			-Changed Pets to Dismiss when their Owner Dies<br>
			-Changed Max Name Length from 14 to 15 Characters<br>
			-Changed the Enemy Respawn Time from 15-30 to 30-60 Seconds<br>
			-Removed Area and Turf Checks from Profile_Atoms()<br>
			-Fixed RunTime caused by Pet Fix when Loading<br>
			-Fixed Exploit with Invisible Players Throwing Radial Effects<br>
			-Fixed Bug with Enemy Levels not Showing<br>
			-Fixed Bug with Global Bans not Booting on Login<p>

			05-03-09<br>
			-Version 9.7<br>
			-Added a Fix for Having Multiple Pets<br>
			-Added Auto Save when Turning in a Quest<br>
			-Changed the Buddy List Layout<br>
			-Changed world.view from 30 to 15<br>
			-Removed Enemy Level Shifting<br>
			-Removed the Boss Stat Multiplier from AGI<br>
			-Removed Buddy List Auto-Showing at Login<br>
			-Removed Buddy List Updates from Login() & Logout()<br>
			-Swapped Quest "A City of Lights" with "Into the Muck" (Arial Guard)<br>
			-Skill Related Updates:<br>
			* Flash Assault now has a 1 Second Stun Effect on Target<br>
			-Fixed Exploit of Sending Links in RP/Emote<br>
			-Fixed Exploit of Bounts on the Level Screen with an Active Pet<br>
			-Fixed Exploit/Bug with Starting Characters Multiple Times<br>
			-Fixed Bug with Element Not Applying when going into Bankai<p>

			05-02-09<br>
			-Version 9.6<br>
			-Ran a Global Character & Pet Respec<br>
			-Changed the PVE Damage Multiplier to only Activate Against NPCs<p>

			05-02-09<br>
			-Version 9.5<br>
			-Added an IP Logger<br>
			-Added a Loop Music Option<br>
			-Added Auto Save on Level Up<br>
			-Added the Refresh Bans GM Command<br>
			-Added the Mute Auto-Expiration System<br>
			-Added Numerical Quest Display in the Quest Log<br>
			-Added Safe Zones and Spirit Managers in the Sewers<br>
			-Added a Warning when using an Older Version of BYOND<br>
			-Changed Boss Stat Modifier to x2<br>
			-Changed Enemy Stats to +3 per Level<br>
			-Changed the PVE Damage Multiplier to x2<br>
			-Changed the Ice Golems Level from 20 to 35<br>
			-Changed Burst Arrows to not Peirce Targets<br>
			-Changed Front Radial Effect Overlays to Layer 6<br>
			-Changed the layout of the Vote Mute Start Announcement<br>
			-Changed Quest Level Requirements to Match New Enemy Levels<br>
			-Macroed L for Viewing the Quest Log<br>
			-Skill Related Updates:<br>
			* ReAdded Berserk<br>
			* ReAdded Blind Strength<br>
			* Changed Damage on Getsuga to 3x STR<br>
			* Lowered Damage Boost on Blind Strength<br>
			* Lowered the Rei Cost on all Teleportation Spells to 200<br>
			* Using Bankai while Renji's Snake is Active will now Destroy It<br>
			* Restricted Power Strike, Shock Wave, and Spirit Blast during Scatter<br>
			-Fixed Bug with Element Clearing during Bankai<p>

			05-01-09<br>
			-Version 9.4<br>
			-Added a Controls Info Tab<br>
			-Added a Watch Player GM Command<br>
			-Changed the Buddy List to a Single HTML Table<br>
			-Changed Logon Files to Save Separately from Configs<br>
			-Removed Buddy List Sorting from Logout()<br>
			-Removed Everyones Config File due to Server Crash<br>
			-Fixed Quincy Trans State in Several Hair Icons<br>
			-Fixed Bug with Infinite Recursion in Chain Destroy()<p>

			04-29-09<br>
			-Version 9.3<br>
			-Added Level Display to the Party HUD<br>
			-Added Boot and Delete GM Commands<br>
			-Added Check, Kick and Leave to the Party Orb Menu<br>
			-Changed Trans Category Drop Down Icons to White Crystals<br>
			-Changed the Crystal Threaded Cape's VIT Boost from 50 to 25<br>
			-Ran a Global Respec<br>
			-Removed the Following Skills:<br>
			* Enrage<br>
			* Berserk<br>
			* Blind Strength<br>
			* Combat Mastery<p>

			04-27-09 - 04-29-09<br>
			-Version 9.2<br>
			-Added World Mute GM Commands<br>
			-Added the Volcanic Enclave for Quest Locating<br>
			-Added a Sound Effect when Swapping HotKeys<br>
			-Added Average % per Player to the CPU Logger<br>
			-Changed Pet Stats to Boost by 2 per Level<br>
			-Changed the Damage on Getsuga Tenshous<br>
			-Changed all PVP Checks to go through CanPVP()<br>
			-Changed Vote Mute Reasons to be Chosen from a List<br>
			-Changed the Combos Effected by Combat Mastery to 5<br>
			-Fixed Minor Mapping Error on the Floating Pillars<br>
			-Attempted Fix for Multiple Getsuga Hits<br>
			-Fixed Bug with Scatter in Bankai (Sderg)<br>
			-Fixed Bug with Flash Comboing into Dense Turfs<br>
			-Fixed Bug with Heat of the Soul Quest (ArkadiaTilia)<br>
			-Fixed Bug with Savior Skills Canceling after 1 Second<br>
			-Fixed Bug with Class Orb not Turning Red During Combat<br>
			-Fixed Bug with Attacking while Charging Skills (Benitobrd)<br>
			-Fixed Bug with Transforming+Reverting Getting Stuck (Benitobrd)<br>
			-Fixed Bug with Getsugas Getting Stuck with Exact Rei (Benitobrd)<p>

			04-26-09<br>
			-Version 9.1<br>
			-Changed the way WriteLine() Deletes HUD<br>
			-Fixed Bug with Shikai & Bankai Skill CoolDowns<p>

			04-26-09<br>
			-Version 9.0<br>
			-Changed CoolDownSystem() back to 1 Tick<br>
			-Changed how Supplemental Effects Delete<br>
			-Changed DamageShow() to ReUse Damage Objects<br>
			-Disabled Safety Checks in MyFlick()<br>
			-ReEnabled Radial Status Effects<br>
			-Fixed Bug with Quest Info after Exiting Level Screens<p>

			04-26-09<br>
			-Version 8.9<br>
			-Added Item: Flaming Crystal<br>
			-Added Enemies to the Ever Forest<br>
			-Added Equipment: Crystal Threaded Cape<br>
			-Added New Quests:<br>
			* Down and Around (Sewer Guard)<br>
			* Into the Fire (Nobano)<br>
			* Great Balls of Fire (Nobano)<br>
			* Heat of the Soul (Bantuu)<br>
			-Changed the Fly Trap's Icon<br>
			-Changed how Delete() Deletes HUD<br>
			-Changed Crab's Level from 40 to 55<br>
			-Changed Phoenix's Level from 50 to 75<br>
			-Changed how much the Bount Skills Heal<br>
			-Changed how the Next Button Deletes HUD<br>
			-Changed the Quest ? to Show Quest Details<br>
			-Changed the Stat Gains on NPCs from 3 to 1<br>
			-Changed when Radial Effect Overlays are Added<br>
			-Changed the PVE Damage Multipliers from 2 to 1<br>
			-Changed the CoolDown on Skills and Spells to 3<br>
			-Removed the null Discarder from HUD Refresh()<br>
			-Removed the KnockBack when Canceling OverShields<br>
			-Fixed Bug with Pets not Deleting on Logout()<br>
			-Fixed Bug with Reverting Removing Equipment Overlays<p>

			04-25-09<br>
			-Version 8.8<br>
			-Changed the Bount Skill Tree<br>
			-Changed Bount Skill Info: Mystic to MGC<br>
			-Changed PVP Damage Reduction from 90% to 50%<br>
			-Changed the 'Enemy' Pet Sync to Target PVP Players<br>
			-Disabled Radial Effect Spreading Again<br>
			-Fixed Bug with the Buddy List<br>
			-Fixed Bug with Radial Effects on Pets During PVP<p>

			04-25-09<br>
			-Version 8.7<br>
			-Added ]\[s to world.status<br>
			-Changed how the LvlOrb Clears HUD<br>
			-Changed Shikai Skills to be Available in Bankai<br>
			-Changed Bounts to Heal and Regen Rei at the Same Time<br>
			-Changed the Default CoolDown on Skills from 10 to 3 Seconds<br>
			-Halved how often CoolDownSystem() Runs<br>
			-ReWrote the Buddy List System<br>
			-ReEnabled Radial Status Effects<br>
			-Fixed Various Pet Related RunTimes<p>

			04-24-09<br>
			-Version 8.6<br>
			-Added Transporter Instructions<br>
			-Changed Overlays to Reset on Revert<br>
			-Changed how Choice Buttons Cleared HUD<br>
			-Disabled the Radial Effects to Test CPU<br>
			-Removed CoolDown Messages<br>
			-Fixed Bug with Radial Effect Spamming<p>

			04-24-09<br>
			-Version 8.5<br>
			-Fixed Bug with Joining Parties<br>
			-Fixed RunTime with Loading Out-Dated Skills<p>

			04-24-09<br>
			-Version 8.4<br>
			-Added Message about Sent Party Invites<br>
			-Added Esc (Escape) Macro to Cancel Target<br>
			-Added Character Info to the Start Game Popup<br>
			-Added a Warning when Entering your own Portals<br>
			-Changed Location of the World Map's Back Button<br>
			-Changed Quincy Stance when Using Spiritual Overdrive<br>
			-Reset Respawn Locations<br>
			-Removed Gain/Faded Messages when Renewing Status Effects<br>
			-Fixed Urahara, Uryu, & Renji Bankai Hair Combo States<br>
			-Fixed Maki, Urahara, Uryu, & Yoruichi Bankai Hair Movement States<p>

			04-24-09<br>
			-Version 8.3<br>
			-Added a Default Basic Attack Sync to Pets<br>
			-Added the Volcanic Enclave to the World Map<br>
			-Added AI Setup Information to the Bount Tutorial<br>
			-Changed Music to Play on Channel 7<br>
			-Changed Flower Offsets from 16 to 12<br>
			-Removed Flowers from Half-Grass Turfs<br>
			-Removed the Frame Delay from Visored Masks and Clothes<br>
			-Fixed Bug with Restoration Spells not Showing (Trickeli)<p>

			12-17-08 - 04-24-09<br>
			-Version 8.2<br>
			-Compiled with BYOND v440.1016<br>
			-Added the MyRGB() proc<br>
			-Added Playable Class: Bounts<br>
			-Added an Advanced CPU Logger<br>
			-Added Random Flowers on Grass<br>
			-Added Handling for Empty Chests<br>
			-Added Pet AI (Soul Sync) Systems<br>
			-Added CoolDown System for Skills<br>
			-Added Spiritual OverDrive Systems<br>
			-Added Text Confirmation to Delete<br>
			-Added Access to Bankai Skill Trees<br>
			-Added an On-Screen Bug Report Button<br>
			-Added a final round() check in Damage()<br>
			-Added Recall Scrolls to the Item Shop in Arial<br>
			-Added Area: Volcanic Enclave<br>
			-Added Bosses: Roach Lord, Phoenix<br>
			-Added Enemy Skills: Woosh, Sting, Poison Cloud, Slam, Cry for Help<br>
			-Added Enemies:<br>
			* Sewers: Giant Lizard, Lost Hobo, Walking Corpse, Skeletal Knight, Goblin, Goblin Raider, Slime, Sludge,
			 Roach Coach<br>
			* Ever Forest: Gorilla, Crocogator, Giant Croc, Grand Wasp, Emerald Beetle, Forest Critter, Wild Mongoose,
			 Tree Frog<br>
			* Volcanic Enclave: Lava Ball, Fire Walker, Burning Blob, Fire Bat, Heated Stinger, Rock Lava, Salamander,
			 Ember Dragon, Crested Turtle, Porcupine, Volcanite, Crimson Crystal, Flaming Boar, Hellz Hopper,
			 Lava Bubble, Molten Man, Molten Slug, Lava Puddle, Hellion Harpy, Eruptor, Solidified Golem<br>
			-Changed the Party HUD<br>
			-Changed the Hub Password<br>
			-Changed Vizard to Visored<br>
			-Changed control_freak to Enabled<br>
			-Changed world.view from 20 to 30<br>
			-Changed various Variables to /tmp<br>
			-Changed Shikai Skill Tree Layouts<br>
			-Changed PVP Damage to 10% PVE Values<br>
			-Changed Global Bans to Handle IP Ranges<br>
			-Changed Vote Mute History to Track Keys<br>
			-Changed the Stamina and Reiatsu Bar Icons<br>
			-Changed Max Enemy Level Shift from 3 to 1<br>
			-Changed Auto-Mute Messages to Player Only<br>
			-Changed Mute Vote Time from 5 to 3 Minutes<br>
			-Changed Enemies to Randomly Locate on Spawn<br>
			-Changed Current Stamina and Reiatsu to Save<br>
			-Changed Class Orbs to Turn Red During Combat<br>
			-Changed Bars to Offset based on whats Showing<br>
			-Changed PlayTime to Increase Regardless of AFK<br>
			-Changed Enemies to not Aggro after being Reset<br>
			-Changed the ComboList var to be Empty by Default<br>
			-Changed Timed Sound Effects to be Volume Filtered<br>
			-Changed the Skill, Arts, and Spell Category Icons<br>
			-Changed the Sewers to Lead from Arial and Karakura<br>
			-Changed Savior Effect Durations from 2 to 5 Seconds<br>
			-Changed KnockBack() to no Longer KnockBack off-screen<br>
			-Changed Attacking to Automatically Face nearby Targets<br>
			-Changed Targets to no longer auto-set if Already Targeted<br>
			-Changed Replacing Status Effects to be both Stronger & Longer<br>
			-Ran a Global Character Respec<br>
			-Removed Frame Delays from Attack Animations<br>
			-Restricted Sending Links in Chat<br>
			-Restricted Pre-Transporting/Traveling/Portaling<br>
			-Restricted Changing Level Screen Tabs with Popups Open<br>
			-Skill Related Updates:<br>
			* Added: Group Morale (Quincy)<br>
			* Added: Flash Combo (Ghost Bankai)<br>
			* Added: A Little Faster (Ghost Bankai)<br>
			* Added: Black Getsuga Tenshou (Ghost Bankai)<br>
			-Spell Related Updates:
			* Added: Mysticism (Knowledge Book)<br>
			* Recall is now Classified under the Teleportation Book<br>
			* Spells are now Sorted by Knowledge Book in the Drop Down<br>
			* The Teleportation Knowledge Book is now Known by Default<br>
			* White Prostration and Mirror Gate are now Mysticism Spells<br>
			+Fixed Bug with Stuck Movement (due to a BYOND Update)<br>
			-Fixed Bug with OverHead NPC Quest Icon Layers<br>
			-Fixed Bug with Global Bans not Checking at Login<br>
			-Fixed Bug with Stream Attacks not Damaging Chains<br>
			-Fixed Bug with Shikai/Bankai/Final Form + Reverting<p>

			11-30-08<br>
			-Version 8.1<br>
			-Minor Tweeks to Various Systems<br>
			-NPCs can no longer Enter Doors<br>
			-PVP Time Limit Raised to 10 Seconds<br>
			-PVP Time now Resets when Taking Damage<br>
			-Temporarily Disabled Mirror Gate<p>

			11-28-08<br>
			-Version 8.0<br>
			-Fixed RunTime with nulls in MyGetDist()<p>

			11-24-08<br>
			-Version 7.9<br>
			-Compiled with BYOND v431.1006<br>
			-Added an Interface Icon<br>
			-Added new Voice Set: Rukia<br>
			-Enemies will no longer agro on Loading<br>
			-2/5ths of Charged Rei now goes to Getsuga Tenshou and Quincy Arrows<br>
			-Modified Damage Calculations on Getsuga Tenshou<br>
			-Fixed Bug with Teleporting<br>
			-Fixed Bug with get_dist Ignoring Zs<br>
			-Fixed Bug with Colliding Blade Breaks<br>
			-Fixed Bug with Spread Shot's Damage Calculations<p>

			11-13-08<br>
			-Version 7.8<br>
			-Added a Teleportation Request Window<br>
			-Added Multiple Restrictions when Summoning<br>
			-Added Skills: Stone Skin, Mystic Glow, Mystic Aura<br>
			-Enemy's Caches now Clear if Deleted<br>
			-Increased the Retract Speed of Blade Break<br>
			-Interface Windows are now Semi-Transparent<br>
			-Lowered the Max Shop Stock to 25<br>
			-Lowered the Range of Blade Break by 1<br>
			-Lowered Arrows for Final Form from 7000 to 777<br>
			-Modified Stat and Trait Screen Information<br>
			-Movement now uses client.Dir() instead of step()<br>
			-Stun type Effects now Cancel the Charging of Skills<br>
			-Fixed Bug with Blue FireBall's Attack Count<br>
			-Fixed Bug with Reverse Critical Rate Calculations<br>
			-Fixed Bug with Dragon Projectiles Piercing Mirror Gate<br>
			-Fixed Bug with Combo HUD not Resetting on Counter Steps<p>

			11-08-08<br>
			-Version 7.7<br>
			-Colliding Projectiles will now be Destroyed<br>
			-Prevented Teleporting to Players before Tutorial Completion<br>
			-Ran a Global Character Respec<br>
			-Fixed Bug with ClearHUD() Deleting Inventory Items<br>
			-Fixed RunTime with Projectile Stun Damage<p>

			11-07-08<br>
			-Version 7.6<br>
			-Prevented Scatter from Running while at the Level Screens<br>
			-Prevented Summoning Players who haven't finished the Tutorial<br>
			-Prevented Guarding and Counter Stepping during additional Situations<br>
			-Set Portals icon_states to invis before flicking closed<br>
			-When Entering a Portal it now displays the Creator<br>
			-Fixed Bug with Negative Gold<br>
			-Fixed Bug with Summoning People into the Arena<br>
			-Fixed RunTime on Enemies killed in the Arena with Double Strike<p>

			11-05-08<br>
			-Version 7.5<br>
			-Halved the Rei Costs of all Teleportation Spells<br>
			-Ice Dragon Assault now has a 10% Chance to Freeze<br>
			-Modified the Damage done by Scatter<br>
			-Reset Sub Bonuses on Expiration<br>
			-Fixed Bug with new Spell Class's Icons<br>
			-Fixed Bug with 4 Digit Stats Overlapping<br>
			-Fixed Bug with Teleporting into the Arena (Ark)<br>
			-Fixed a RunTime caused by Ice Dragon's Freezing<br>
			-Prevented a RunTime in the Damage Procedure<p>

			11-05-08<br>
			-Version 7.4<br>
			-Added an Icon for Barber Cupons<br>
			-Added a Level Requirement on the Healing Compound Quest<br>
			-Beastiary no longer logs Enemy Types Killed in the Arena<br>
			-Lowered the Amount Bosses' Stats are Boosted<br>
			-Spell Related Updates:<br>
			* Changed the Icon for Recall<br>
			* Added Knowledge Book: Teleportation<br>
			* Added: Travel (Teleportation)<br>
			* Added: Teleport (Teleportation)<br>
			* Added: Portal (Teleportation)<br>
			* Added: Summon (Teleportation)<br>
			-Fixed Bug with Arena Monsters Deleting<br>
			-Fixed Bug with Logging out of Arena Round 1<br>
			-Fixed Bug with Final Form Charge Cancelling<br>
			-Fixed Bug with Double Strike Arena Ring-Outs (Karim)<p>

			11-03-08<br>
			-Version 7.3<br>
			-Added a Spirit Master in Arial<br>
			-Changed Cupons and Recall Scrolls to Stack x25<br>
			-ReNamed the Weapon Vender to Gear Vendor<br>
			-Class Related Updates:<br>
			* Final Form Quincies have Infinite Shots Again<br>
			* Final Form Quincies Attack Delay has been Increased<br>
			-Enemy Related Updates:<br>
			* Bosses now get Defense Boosts<br>
			* Removed Frawg's Special Attacks<br>
			-Skill Related Updates:<br>
			* Changed Damage done by Ice Dragon Assault<br>
			* Increased Getsuga Tenshou's Range by 1<br>
			* Getsuga Tenshou is now a 3 Wide Blast<br>
			* Petal Stream's Level now boosts Damage 25%<br>
			* Backlash no longer returns as Melee Damage<br>
			-Fixed Bug with Arrow Names<br>
			-Fixed Bug with Movement Chat Detection<br>
			-Fixed Bug with Roaring Thunder Burn's Damage<br>
			-Fixed Bug with Custom Clothes on Ichigo's Bankai<br>
			-Fixed Bug with Directional Changes when Deflecting Projectiles<p>

			11-03-08<br>
			-Version 7.2<br>
			-Compiled with BYOND v430.1003<br>
			-Limited QuestShow() Messages to 6<br>
			-Changed Quincy's Base Attack from STR to MGC<br>
			-Displayed VIT, MGC, and MGCDEF in the Beastiary<br>
			-Classified Damage into 3 Categories: Melee, Mystic, Break<br>
			-Ran a Global Character Respec<br>
			-Stat Points can now be used on VIT, MGC, and MGCDEF<br>
			-Status Effects can now be given Infinite Durations<br>
			-Skill Related Updates:<br>
			* Added Fire Type to Dragon Assault<br>
			* Enrage's Level now Increases Duration<br>
			* Berserk's Level now Increases Duration<br>
			* Backlash only works against Melee Attacks<br>
			* Modified the Damage on All Skills/Spells/Kidous<br>
			-Quest Related Updates:<br>
			* Quests can now be given Time Limits<br>
			* Locating will now Directly Track live Enemies<p>

			10-28-08<br>
			-Version 7.1<br>
			-Ran a Global Character Respec<br>
			-Macroed / on NumPad for Auto Walking<br>
			-Minor Tweeks to Various Systems<br>
			-Moved Login Restrictions back to Login()<br>
			-Spell Related Updates:<br>
			* Added Knowledge Book: Restoration<br>
			* Added Knowledge Book: Augmentation<br>
			* Added: Jog (Augmentation)<br>
			* Added: Run (Augmentation)<br>
			-Minor Fixes for Various Systems<p>

			10-28-08<br>
			-Version 7.0<br>
			-Added a Taunt Effect Icon<br>
			-Blocking now Deflects Projectiles<br>
			-Changed the Skill Category Icons<br>
			-Changed Equipment to Support Multiple Stats<br>
			-Char Preview now Rotates<br>
			-Increased Boss Stats<br>
			-Level Acquisitions now Log<br>
			-Item Related Updates:<br>
			* Added: Toy Vizard Mask (Head Gear)<br>
			-Enemy Related Updates:<br>
			* Added Skills: Poison Cloud (Shroom)<br>
			* Added Enemies: Sewer Bat (24), Sewer Spider (25)<br>
			* Added Enemies: Skeleton Brute (26), Gekko (27)<br>
			* Modified Existing Enemy Levels<br>
			* Renamed Wood Hollows to Forest<br>
			-Skill Related Updates:<br>
			* Added the Final Form Skill Tree<br>
			* Added: Berserk (Soul Reaper)<br>
			* Added: Enrage (Ghost & Beast Shikais)<br>
			* Added: Hold Charge (Final Form)<br>
			* Backlash disabled against Ranged Attacks<br>
			* Removed the use of Special Skill Lists<br>
			* Power Strike Rei Cost Reduced from 150 to 25<br>
			* Spirit Blast Rei Cost Reduced from 250 to 50<br>
			* Power Shot Rei Cost Reduced from 150 to 50<br>
			* ShockWave Rei Cost Reduced from 300 to 75<br>
			* Barrage Rei Cost Reduced from 250 to 150<br>
			* Freeze Ring Rei Cost Raised from 200 to 350<br>
			-Fixed Bug with UnEquipping Items<p>

			10-16-08<br>
			-Version 6.9<br>
			-Added Enemy Skills<br>
			-Added an Instant Quest Locater Icon<br>
			-Disabled Enemy Agro caused by Respawn<br>
			-ReNamed Petal Blast to Petal Stream<br>
			-Restricted/Auto Closed Inventory during Popups<br>
			-Set Taunted Enemies to hold Targets<br>
			-Set Votes to Display who you're Voting For<br>
			-Fixed Bug with Honor Calculations<br>
			-Fixed Bug with Reach type Quests Tracking<p>

			10-14-08<br>
			-Version 6.8<br>
			-Compiled with BYOND v429.999<br>
			-Added a Hub Password<br>
			-Added Shopping Systems<br>
			-Added basic Equipment Systems<br>
			-Added a View Subscribers Option<br>
			-Added a Locate Option for Quests<br>
			-Added a "None" Exp Display Option<br>
			-Added More Enemies in the Tutorial<br>
			-Added Stat Booster type Items and Skills<br>
			-Added On-Screen Display of Status Effects<br>
			-Added On-Screen Display of Quest Progress<br>
			-Added 'Dye Clothes' Option for Subscribers<br>
			-Added a Trash Bin and Close X to the Inventory<br>
			-Added Progress Cupons; received every 10 levels<br>
			-Decreased Movement Speed by 2<br>
			-Decreased Shared Party EXP by 20% per Level Difference<br>
			-Expanded the EXP Orb's Icon from 10 to 25 Frames<br>
			-Expanded the STM and REI Bars from 10 to 33 Frames<br>
			-Expanded the Zanpakuto Call/Name Limits from 25 to 500<br>
			-Increased the Delay between Combo Attacks<br>
			-Macroed I to Inventory Toggle<br>
			-Modified KnockBack Systems<br>
			-Modified Auto-Target Coding<br>
			-Modified the QuestShow() Procedure<br>
			-Modified Alot of Item Related Systems<br>
			-Modified On-Screen Font-Icons and Coding<br>
			-Modified the Money System to Handle over 99 Gold<br>
			-Moved the Help Macro from H to ?<br>
			-Moved Login Restrictions to IsBanned()<br>
			-Nerfed All Stats on All Enemies<br>
			-Nerfed Bosses on top of Enemy Nerf<br>
			-Raised the Drop Rates on Unique Items<br>
			-Redid Some Turf, HUD, and Menu Graphics<br>
			-Ran a Global Player-Wipe<br>
			-Removed Chat Mode<br>
			-Removed AFK Booting<br>
			-Removed the VIT Stat<br>
			-Removed Shared Party Drops<br>
			-Removed Multi-Tiled Monsters<br>
			-Removed Party Level Restrictions<br>
			-Removed the Kill Stealing Message<br>
			-Removed Party Leadership Disbanding<br>
			-Removed Pre-Loading Resource Settings<br>
			-Replaced suffix Usage on Items with CurStack<br>
			-ReWrote alot of the Tutorial<br>
			-ReWrote the Subscriber Systems<br>
			-Restricted Movement while at Menu Screens<br>
			-Restricted Inventory Access during Menu Screens<br>
			-Set the Max Stack Size on Items to 25<br>
			-Set Dragon Projectiles to Pierce Targets<br>
			-Set Max Respec and Barber Costs to 100 Gold<br>
			-Set Stamina and Reiatsu to Recover Separately<br>
			-Set the Stack Limit on Hollow Mask Items to 25<br>
			-Set Inventory to Auto-Update when Receiving Gold<br>
			-Set Red Flames to Automaticaly cause Spirit Form<br>
			-Shortened the Time in which Attacks can Collide<br>
			-Trimmed Spaces off the Beginning and Ends of Names<br>
			-Updated the Beastiary Calculations<br>
			-When Respeccing: All Status Effects will Fade<br>
			-Quest Related Updates:<br>
			* "Gather" Quest Types were ReNamed to "Collect"<br>
			* Collect Quests are now Handled like Gather Quests<br>
			-Item Related Updates:<br>
			* Added Onyx<br>
			* Added Phoenix Feather<br>
			* Added Settings for Unique Items<br>
			* Modified Energy Drinks and Spirit Dew<br>
			-Skill Related Updates:<br>
			* Recall is now Known by Default<br>
			* Last Gasp is now Handled as a Status Effect<br>
			* Knockback and Counter Step no Longer cause Aggro<br>
			-Fixed Bug with Backlash Infinite Looping<br>
			-Fixed Bug/Tweeked how Flash Assault worked<br>
			-Fixed Bug with the way Counter Stepping Worked<br>
			-Fixed Bug with Status Effects being Saved/Loaded<br>
			-Fixed Bug with the Inventory not Updating Correctly<p>

			09-01-08<br>
			-Version 6.71<br>
			-Disabled Damage Multipliers Against Player Targets<br>
			-Disabled Log Message about Mobless Logouts<br>
			-Fixed a RunTime Error in the Arena<p>

			09-01-08<br>
			-Version 6.7<br>
			-Added Font Face and Color Options for Subs<br>
			-Added 1 Minute and 10 Second Reboot Warnings<br>
			-All Enemies now have a 10% Immunity to Status Effects<br>
			-Applied Damage Multipliers to Higher Level Monsters<br>
			-Credit for Kills now goes to whoever did the most Damage<br>
			-Gather Quests now take Items already owned into Account<br>
			-If the Leader Leaves the Party it will Disband<br>
			-Lowered how much Reiatsu Spirit Shine Gives<br>
			-New Boss Added: 40. Kenyan Mangrove Crab<br>
			-New Quest Added: CRAB BATTLE!!! (Native Snake)<br>
			-PVP Results no longer Announce to the world<br>
			-PVP Results now Display how much Honor was Gained/Lost<br>
			-Safe-Guarded Hosting<br>
			-Fixed Bug/Tweeked how Login Detection Works<br>
			-Fixed Bug with Quest Completion Display in Que<br>
			-Fixed Bug with Opening Chests with Full Inventory<p>

			08-30-08<br>
			-Version 6.6<br>
			-Arrow Icons will now vary in Final Form<br>
			-Changed Zanpakuto's Spirit Type Selections<br>
			-Cost of In-Game Services now Increase each Use<br>
			-Global Ban now Kicks anyone Added between Loads<br>
			-Log Files now Save Based on Server Port<br>
			-More Arrows Required for Final Form<br>
			-PMs now Notify you if Someone is AFK<br>
			-Removed the Rapid Fire Arrow Type<br>
			-Safe Guarded the Party Invite System<br>
			-Fixed Bug with Spirit Shell<br>
			-Fixed Bug with Party Related Popups<br>
			-Fixed Bug with Arena Enemy Spawn Points<br>
			-Fixed Bug with Lost Vote Expiration Dates<br>
			-Fixed Bug with Firing Arrows while Stunned<br>
			-Attempted to Fix an odd Infinite Damage Loop<p>

			08-29-08<br>
			-Version 6.53<br>
			-Fixed a Bug with the Auto-UnMute System<p>

			08-29-08<br>
			-Version 6.52<br>
			-Lowered Enemey Stamina and Reiatsu<br>
			-Fixed a Bug with Arena Monsters not Moving<p>

			08-29-08<br>
			-Version 6.51<br>
			-Changes to Player Limit Info<br>
			-Fixed a Bug with the Shikai Quest<br>
			-Fixed Bug with Mirror Gate in the Arena<p>

			08-29-08<br>
			-Version 6.5<br>
			-Boosted Enemy Stamina, Reiatsu, Agility, and Luck<br>
			-Prevented some Unnecessary calls to QuestRefresh<br>
			-Added Special Icons for each Quincy Arrow Type<br>
			-The REI Stat now gives 5 instead of 10 MaxRei<br>
			-Added a Pre-Invite Party Invite Notification<br>
			-Added Generic Quest Objective Display in Que<br>
			-The Luck Stat no longer effects Hit Rate %s<br>
			-Expanded/Added more Enemies in the Tutorial<br>
			-The Overall Scoreboard now tracks Play Time<br>
			-Restricted Recalling from Inside the Arena<br>
			-Added Safety Zones at Karakura and Rugella<br>
			-Internal Changes to how Gather Quests work<br>
			-Server Tab now Displays Server Tag Info<br>
			-Modified the effects of Global Respecs<br>
			-Minor Modifications to the Chat System<br>
			-Added the /me Command for Role Playing<br>
			-Tweeks to Flash Step and FS Targeting<br>
			-E Key Macroed for Emote/Role Playing<br>
			-Removed Host Info from world.status<br>
			-Q Key Macroed for Targeting Allies<br>
			-Ran a Global Character Respec<br>
			-Bosses now Give Double EXP<br>
			-Skill Related Updates:<br>
			* Updated Final Form (Quincy)<br>
			* Barrage Damage now Includes STR<br>
			* Changed the Icon-Set for Scatter<br>
			* Power Strike Damage now Includes STR<br>
			* Attack Animation for Power Strike Added<br>
			* Mirror Gate no longer Effects Dense Areas<br>
			-Fixed Bug with Party HUD<br>
			-Fixed Bug with Blade Break<br>
			-Fixed Bug with Auto-UnMuting<br>
			-Fixed Bug with Regen Immortality<br>
			-Tweeked/Fixed Bugs with Target Facing<br>
			-Fixed Bug with Hollows Attacking Eachother<p>

			08-25-08<br>
			-Version 6.42<br>
			-Fixed Bug with the Level Screen during PVP/Combat<p>

			08-25-08<br>
			-Version 6.41<br>
			-Removed the Interact Icon after Interacting<br>
			-Fixed Bug with Heal Rounding<br>
			-Fixed Bugs with Blade Break<p>

			08-24-08<br>
			-Version 6.4<br>
			-HotKeys can now be Directly Swapped with Eachother<br>
			-Added a Transporter and Spirit Manager in Rugella<br>
			-Added Item: Respec Cupon {Suggested by Dbzlb}<br>
			-Added an Interaction Notification Overlay<br>
			-Gold is now Displayed in the Inventory<br>
			-Status Effects are now Lost at Death<br>
			-Changed the Order of the Hub Info<br>
			-Changes to Stun's PVP Detection<br>
			-Changed all the Tabs around<br>
			-Restricted Guest Keys<br>
			-Skill Related Updates:<br>
			* Added: Wound (Renji Shikai){Suggested by Dbzlb}<br>
			* Added: Freeze Blade (Toshiro Shikai)<br>
			* Applied the Effects of Spirit Shell<br>
			* Completed: Scatter (Byakuya Shikai)<br>
			* Completed: Blade Break (Renji Shikai)<br>
			* Freeze Ring no longer effects dense areas<br>
			* White Lightning damage decreases with range<br>
			-Fixed Bug with Chest Counter Info<br>
			-Fixed Bug with the Duration of Regen<br>
			-Fixed Bug with Flash Stepping into Frozen Areas<br>
			-Fixed Bug with Healing Calculations not Rounding<br>
			-Fixed a RunTime caused by Ice Golems having no Drops<p>

			08-23-08<br>
			-Version 6.3<br>
			-Compiled with BYOND v427.997<br>
			-Added Status Effects<br>
			-Added Treasure Chests<br>
			-AFK Mode now Activates after 5 Minutes<br>
			-Added AFK and Directional Arrow Overlays<br>
			-Finished the Beastiary (Bestiary?) System<br>
			-Kidous Now Require Higher Level Kidou Traits<br>
			-Macroed the U Key for Viewing Updates<br>
			-Quests can now Reward Gold/Silver/Copper/Items<br>
			-Ran a Global Character Respec<br>
			-Slightly Boosted Enemy Stamina<br>
			-New Skills Added:<br>
				Blind Strength (Ichigo/Renji Shikai)<br>
				Brave Shout (Soul Reaper)<br>
				Selfless Distraction (Quincy)<br>
				Combat Mastery is now Applied<br>
			-New Spells Added:<br>
				Regen , Brightest Light, Cleanse, Recall<br>
			-New Items Added:<br>
				Beastiary, Spirit Dew, Hollow Bait, Recall Scroll<br>
			-New Area Added: The Ever Forest<br>
			-New Quest Type Added: Gather<br>
			-New Quests Added:<br>
				Lost Purse (Jenny)<br>
				The Ever Forest? (Chilly Reaper)<br>
				Canadian Lumber (Guanto)<br>
				Oh Snap, Fly Snap! (Guanto)<br>
				Tangled Green (Guanto)<br>
				A Brother's Revenge (Eganto)<br>
			-New Enemies Added:<br>
				24. Treen, 25. Fly Snap*, 26. Lost Vines*, 27. Scruffy,<br>
				28. Beast, 29. Shroom*, 30. Turtle Spider, 31. Wood Snail,<br>
				32. Wood Bat*<br>
			-Animations Added for the Following Enemy Types:<br>
				Snails, Tadpoles, Bears, Trees, Wolves,<br>
				WereWolves, Serpents, Frogs, Scorpions<br>
			-Fixes for various Global Ban Stuff<br>
			-Fixed/Applied the On-Screen Party Stats System<br>
			-Fixed Bug with Quincies getting stuck after Death<br>
			-Fixed Bug with Rei not being used in Certain Situations<p>

			08-17-08<br>
			-Version 6.2<br>
			-Added the Global Ban System<br>
			-Added Inventory Item Information<br>
			-Lowered Stm/Rei/Agi/Lck on all Enemies<br>
			-Inventory now Automaticaly Updates when Open<br>
			-Recoded some On-Screen Text Systems for Usability<br>
			-Mirror Gate now Densifies Turfs to help Path-Finding<br>
			-Mirror Gate now Automaticaly Clears when you Die<br>
			-Minor Bug Fix for manualy Clearing Mirror Gate<p>

			08-15-08<br>
			-Version 6.1<br>
			-Added a Female School-Girl Icon<br>
			-Added a Loading Notification Window<br>
			-Added the Inventory Management System<br>
			-Added Enemy Spoils (Enemies drop Items)<br>
			-Added AFK Mode - Stops Counting Playtime<br>
			-Added Support for Multiple Configs; Based on Port<br>
			-Auto-Opened the Options and Messages Box upon Login<br>
			-Classified Vote Info Announcements with Yellow Prefix<br>
			-Classified Player Info Announcements with Blue Prefix<br>
			-Classified Server Info Announcements with Green Prefix<br>
			-Changes to PVP Honor:<br>
				Players within 10 levels of you: +1 Honor<br>
				11 or more levels lower than you: -1 Honor<br>
				11 or more levels higher than you: +2 Honor<br>
			-Kidou Updates:<br>
				Swapped the Damage on Black Coffin and Complete Seal<br>
				Complete Seal now does the specified Damage<br>
				Roaring Thunder Burn is now Functional<br>
				Tracing Sparrow is now Functional<br>
				Black Coffin is now Functional<br>
				Silky Sky is now Functional<br>
			-Skill Updates:<br>
				Freeze Ring is now Functional<br>
			-Spell Updates:<br>
				Added Mirror Gate<br>
				Added White Prostration<br>
			-Made Enemies and Bosses Tougher<br>
			-Minor Changes to Quest Kill Detection<br>
			-Modifications Made to the Reboot System<br>
			-Party Stats are now Displayed On-Screen<br>
			-Restricted Level Screen Access During Combat<br>
			-Removed the Status Bar due to it being Useless<br>
			-Rewrote the LowCpuHud System to Improve Dynamic Application<br>
			-The Following In-Game Services are now Free to SG Subs:<br>
				Respeccing<br>
				Hair Styling<br>
				Added a Name Changer NPC<br>
			-Fixed Bug with Regain at the Level Screen<br>
			-Fixed Bug with Party Kills at the Level Screen<br>
			-Fixed Bug with Stuns Visual Effects after Death<p>

			06-29-08<br>
			-Version 6.0<br>
			-Made Enemies Stronger<br>
			-Added the new Arts Sections<br>
			-Uploaded new Resource Package<br>
			-Randomized Arena Spawn Locations<br>
			-Increased the Damage of Getsuga Tenshou<br>
			-Getsuga Tenshou now Requires 25 Reiatsu<br>
			-Fixed Bug with Quincy Arrows caused in 5.95<p>

			06-28-08<br>
			-Version 5.95<br>
			-Applied AsciiCheck to Player Names<br>
			-Disabled Double Click on NPCs. Use F!<br>
			-Reset Selected Arrow Type when Respecing<br>
			-Reverting no longer Resets Movement Control<br>
			-Increased the Vote Reason Limit Length to 100<p>

			06-27-08<br>
			-Version 5.94<br>
			-Player Save Files now create Self-Backups<p>

			06-27-08<br>
			-Version 5.93<br>
			-You can no longer Damage Yourself<br>
			-Mutes & Bans now Save by Player Name<br>
			-Tweeks to how Players are Forcibly DCed<p>

			06-27-08<br>
			-Version 5.92<br>
			-Only Party Leaders can Invite Members<br>
			-Prevention for Multiple Server Logins<br>
			-Fixed Bug with UnChanged Player Count on Ban<br>
			-Fixed Bug with Lost Enemies in the Arena<br>
			-Fixed Bug with the Auto-UnMute System<br>
			-Fixed Bug with Text Input Windows<p>

			06-26-08<br>
			-Version 5.91<br>
			-Added Time Zone Display<br>
			-Fixed a Focus Bug with PMs<br>
			-Fixed Bug with Multiple Votes<br>
			-Fixed a Bug with Volume Inputs<p>

			06-26-08<br>
			-Version 5.9<br>
			-Added Mute Reversal<br>
			-Added a Reboot Host Verb<br>
			-Added Music Track Selection<br>
			-Can now Aim Getsuga Tenshou<br>
			-Lowered Mute Time to 1 Hour<br>
			-Lowered Auto-Reboot to 4 Hours<br>
			-Restricted new Votes while Muted<br>
			-Fixed some Bugs with the Mute System<br>
			-Fix on Counter Step during White Lightning<p>

			06-22-08<br>
			-Version 5.81 - 5.82<br>
			-Fixes for the Mute Expiration System<p>

			06-22-08<br>
			-Version 5.8<br>
			-Added Auto-Reboot every 6 Hours<br>
			-Added the Change Name verb for SG Subs<br>
			-Changed back to the old QuestShow System<br>
			-Limited Votes by both Key and IP<br>
			-Most Recent Exp Gains Appear at top of Exp Log<br>
			-Mute Votes are now only effective for 24 Hours<br>
			-Fixed Bug with Max Rei Gain per Level<br>
			-Fixed some RunTime Errors<p>

			06-22-08<br>
			-Version 5.71<br>
			-Fixed Bug with Missed PMs<p>

			06-22-08<br>
			-Version 5.7<br>
			-PM List is now Sorted Alphabeticaly<br>
			-New Messages Appear at the Top of the List<p>

			06-22-08<br>
			-Version 5.6<br>
			-Added the PM List<br>
			-Added the Mail System Icon<br>
			-Added Pager Ban Protection<br>
			-Changes to the Mute and Ban GM Verbs<br>
			-Changed a couple Skill Descriptions<br>
			-Changes to the Options Window<br>
			-Minor Tweeks to Various Systems<br>
			-Macroed the F8 key for PM List<br>
			-Macroed the O key for Options<br>
			-Macroed the M key for Map<br>
			-Mail System Icon will Flash when PMed<br>
			-PMs will no longer Automaticaly Popup<br>
			-Prevented Starting PMs while Muted<br>
			-You can now View Quest Info/Abandon Quests<br>
			-Fixed a RunTime Error with Text Input<p>

			06-11-08<br>
			-Version 5.5<br>
			-Boss Names are now Red<br>
			-Changed Hakuda and Hohou Traits<br>
			-Changed the On-Screen Info System<br>
			-Last Gasp makes you Invincible for 1 Second<br>
			-Removed Monster Blocks near the Outpost<br>
			-Updated the World Map to include Sewers<br>
			-Fixed Bug with Shared Stat/Trait Buttons<p>

			06-10-08<br>
			-Version 5.4<br>
			-Added Multi Distribute to Traits<br>
			-Added Kidous:<br>
				Hadou 54: Incinerating Flame<br>
			-Applied Zanjutsu and Hakuda to Damage Calcs<br>
			-Modified the Combo Skill's Info<br>
			-Modified the Vote Systems<br>
			-Removed Instances of Unused Icons<br>
			-Fixed 'Healing Compound Materials' Quest<br>
			-Fixed Bug with Following Players<br>
			-Fixed some Info Datum RunTime Errors<p>

			06-10-08<br>
			-Version 5.3<br>
			-Added Vote History<br>
			-Added the /Follow Command<br>
			-Added the World Map Icon HUD<br>
			-Added Menu and Voice Volume Options<br>
			-Added Level Reqs to certain Skills Info<br>
			-Applied Volume Options to Sounds Effects<br>
				(Excluding Looped Energy Volume)<br>
			-Applied Stat Boosts to Boss Type NPCs<br>
			-Arena Scores will now Save on Losses<br>
			-Every 10th Arena Round is now a Boss<br>
			-Made PVP Available at Level 1<br>
			-Modifications to the Voting Systems<br>
			-Modifications to the Mute and Ban Systems<br>
			-Moved Help to the Left Side of Tutorials<br>
			-Another Fix Attempt for White Lightning<br>
			-Fixed Bug with Reverting while Playing Music<br>
			-Fixed Bug with Hollows Targeting Eachother<p>

			06-06-08<br>
			-Version 5.2<br>
			-ReEnabled DEBUG Mode<br>
			-Disabled Control_Freak<br>
			-Tweeks to the Invisibility Systems<br>
			-Converted Invisible turfs to Phase ones<br>
			-Fixed Bug with the Text Input Window<br>
			-Fixed Bug with Zanpakuto Element Names<br>
			-Fixed Bug with Exp Display Option Buttons<br>
			-Fixed Bug with Max Stm/Rei HUD on Level Up<br>
			-Fixed Bug with Char Clicks during Creation<br>
			-Fixed Minor Text Bug on Stat & Trait Screens<p>

			06-05-08<br>
			-Version 5.1<br>
			-Disabled DEBUG Mode<br>
			-Removed the Vote Ban<br>
			-Same Player Vote Limits<br>
			-Votes are now Limited by IPs<br>
			-Vote Tab now Display Vote Count<br>
			-Fixed a Bug with the Hurt SE<p>


			06-05-08<br>
			-Version 5.0<br>
			-Added New Location:<br>
				Karakura Sewers<br>
			-Added New Hollows:<br>
				22. Gator<br>
				23. Ratt<br>
			-Added New Hair Styles:<br>
				Maki<br>
				Yoruichi<br>
			-Added New Quests<br>
				Healing Compound<br>
			-Added an Exp Log<br>
			-Added the Voting System<br>
			-Added an Instrument System<br>
			-Added a Global Option System<br>
			-Added Character Emotes (/Help)<br>
			-Added Custom Text Input System<br>
			-Added Prices to some NPC Shops<br>
			-Changed the way you earn Money<br>
			-Gain +10 STM / +5 REI per Level<br>
				Adjusted Enemy STM/REI Accordingly<br>
			-Hold Shift to Distribute Multiple Stat Points<br>
			-HotKey Bar can now be Hidden/Extended<br>
			-Modified the HotKey System<br>
			-Modified Stance State on Death<br>
			-Modified to the Available Traits<br>
			-Moved the HotKeys from F5-F8 to 1-9<br>
			-New Resource Package Uploaded<br>
			-No Longer get Quest Kills in the Arena<br>
			-Player Menus moved to Right Click<br>
			-Quest Kill-Steal Prevention<br>
			-Quest Kills now Shared in Parties<br>
			-Tweeks to NPC Respawn Variants<br>
			-Tweeks to the Log File System<br>
			-Fixed a Bug with Area Doors<br>
			-Fixed a Couple RunTime Errors<p>

			04-15-08<br>
			-Version 4.9<br>
			-Minor Tweeks to Various Systems<br>
			-Started on the Currency System<br>
			-The Arena now Gives Copper not EXP<br>
			-Fixed a couple Minor Bugs<p>

			04-13-08<br>
			-Versions 4.81 & 4.82<br>
			-Auto Arena Save System<br>
			-Several Bug Fixes<p>

			04-13-08<br>
			-Version 4.8<br>
			-Added Scoreboard In Arena<br>
			-Added an Overall Scoreboard<br>
			-Disabled InGame AutoSaves<br>
			-Disabled Actions During Popups<br>
			-Increased Enemy Agro Distance<br>
			-New Skills Added:
				Ice Dragon Assault (Ice Dragon Shikais)<br>
			-Updated to BYOND 416.981<br>
			-Compatibility Fixes for Update<br>
			-Tweeks to the Movement System<br>
			-Fixed a Couple RunTime Errors<p>

			04-13-08<br>
			-Version 4.71<br>
			-Fixes and Tweeks<p>

			04-13-08<br>
			-Version 4.7<br>
			-Added 2 new Minor Quests<br>
			-Added 15 Minute AFK Boot Timer<br>
			-Added Detailed Check on Players<br>
			-Arena Scoreboard only Tracks top 10<br>
			-Can now Leave Parties<br>
			-Can now Kick Party Members (Leaders Only)<br>
			-Disabled Kill Steal Message in Parties<br>
			-Minor Map Changes near the Arena<br>
			-Randomized Damage Locations<br>
			-Renamed Sonic Speed to Flash Step<br>
			-Subscribers now show a Star in OOC<br>
			-Subscribers now show a * in Who List<br>
			-Unstun on Death (Visual Remains!*#$@?)<br>
			-Fixed Bug with Flickering HP/MP Bars<br>
			-Fixed Bug with Level Screen in Arena<br>
			-Fixed Bug with Shikai/Bankai Skills<br>
			-Fixed a RunTime Error<p>

			04-13-08<br>
			-Version 4.6<br>
			-Added a Name-Guard System<br>
			-Added a Scoreboard System for the Arena<br>
			-No Longer Recover Stats during Popups<br>
			-Nerfed Battle Focus and Dodge Skills<br>
			-Fixed a Minor Mapping Error<p>

			04-13-08<br>
			-Version 4.5<br>
			-Added the Golden Battle Arena<br>
				(Located in Karakura for now)<br>
			-Autosize Buttons on Popups<br>
			-Changes to Char Buttons<br>
			-Delay applied to Next Button<br>
			-Semi-Transparent Popup Background<br>
			-PVP Stats Tweeked and Reset<br>
			-Fixed a Bug with Enemy EXP<p>

			04-04-08<br>
			-Version 4.4<br>
			-Added Party System<br>
			-Added Specific Chat Modes<br>
			-Expanded Enemy Agro Distance<br>
			-Ice Golem is now Ice Elemental<br>
			-Dense Fix on Menu Viewing Players<br>
			-Lowered Multi-Mob Agi and Luck<br>
			-Fixes for Stun/Binding Spells<p>

			04-03-08<br>
			-Version 4.3<br>
			-Getsuga Tenshou Base Damage Tripled<br>
			-Lowered Player Immunity Skill Boost to 15%<br>
			-Multi Tiled Enemies now have 50% Immunity<br>
			-Multi Tiled Enemies are now Stronger<br>
			-Max Stat Checking in Second Loop<br>
			-Quincy STR into Arrows Halved<br>
			-Tweeks to make Last Gasp more Accuracy<br>
			-Fixes for Spaces and 's in BYOND Keys<br>
			-Fixed Bug with Geize the NPC<br>
			-Fixed Bug with Deleting Saves<br>
			-Fixed some Enemy Location Errors<p>

			04-02-08<br>
			-Version 4.2<br>
			-Removed Global Save System<p>

			04-02-08<br>
			-Version 4.1<br>
			-???<p>

			04-01-08<br>
			-Version 4.0<br>
			-Globified Shikai Trees<br>
			-ReAdded the Subscription Menu<p>

			04-01-08<br>
			-Version 3.9<br>
			-Max Level Skills Available<br>
			-Relog Bonuses Enabled for Subs<p>

			04-01-08<br>
			-Version 3.8<br>
			-Added Kidous:<br>
				Hadou 31: Red Flame Cannon<br>
				Hadou 33: Blue Fireball<br>
			-Added Skills:<br>
				Pride of the Quincy (Quincy)<br>
				Backlash (Soul Reaper)<br>
			-Added Shikai Skill Trees: (Unfinished)<br>
				Dark Ghost (Default Ghost)<br>
				Ice Dragon (Default Dragon)<br>
				Light Dragon<br>
				Earth Beast (Default Beast)<br>
			-Added a Required Update System<br>
			-Added Server Link Information<br>
			-Added Reiatsu Defense<br>
			-Different Icons for Each Paralysis Kidou<br>
			-Game AutoSaves after Creating a new Char<br>
			-Minor Changes to the World Map System<br>
			-Raised the Rei Cost of Binding Kidous<br>
			-Removed Subscription Features<br>
			-Removed Second Life<br>
			-Fixed Bug with Quincy Flash Step<br>
			-Fixed Bug with Reverse Elemental Damage<br>
			-Fixed minor Bug with the Bald Hair Style<p>

			03-30-08<br>
			-Version 3.7<br>
			-Added Player Count Correction<br>
			-Changed when World Config Saves<br>
			-Lowered AutoSave to 10 Minutes<br>
			-Made Multi-Tiled Mobs Stronger<br>
			-Fixed some Minor Bugs and RunTimes<p>

			03-29-08<br>
			-Version 3.6<br>
			-New Resource file Uploaded<br>
			-Attempt to fix an Icon Bug<p>

			03-29-08<br>
			-Version 3.5<br>
			-Fixed Bug: Level 1 Players couldnt Save<p>

			03-29-08<br>
			-Version 3.4<br>
			-Version Verification Added<br>
			-Global Save System Implemented<p>

			03-24-08<br>
			-Version 3.3<br>
			-Added Multi Tile Mobs<br>
			-Added New Quests<br>
			-Added New Hollows:<br>
				20. Shivering Flame<br>
				21. Icicle Knight<br>
				30. Ice Golem<br>
			-Added Who List Sort (Level & Play Time)<br>
			-Fixes to Respeccing<br>
			-Fixes on Player and NPC Deaths<p>

			03-23-08<br>
			-Version 3.1 & 3.2<br>
			-Added a World Map<br>
			-Added a few Kidous<br>
			-Added a Functional Sub List<br>
			-Bug Fixes and Tweeks to Various Systems<p>

			03-23-08<br>
			-Version 3.0<br>
			-Added a Relog Timer<br>
			-Added Multikey Prevention<br>
			-Messenger Now Displays Name instead of Key<br>
			-Minor Tweeks to Various Systems<br>
			-Fixed a Minor RunTime Error<p>

			03-22-08<br>
			-Version 2.7 & 2.9<br>
			-W Macroed for Who<br>
			-H Macroed for Help<br>
			-Added Player Limit<br>
			-Added Zanpakuto Info<br>
			-Added a Respeccing NPC<br>
			-Added Fluid Movement System<br>
			-Added a New Menu Sound Effect<br>
			-Added New Map Area:<br>
				Ice Caverns<br>
			-Added New Skills:<br>
				Rei Rage (Soul Reaper, Quincy)<br>
				Flash Assault (Soul Reaper)<br>
				Rapid Fire, Barrage (Quincy)<br>
				ExoShell, Spirit Shine, Brute, Stone Skin, Blur,Lucky Stars (All)<br>
			-Added New Hollows:<br>
				18. Freezer<br>
				19. Arctic Wulf<br>
			-Added Multiple Save Slot Stsyem<br>
			-Added the FAQs Section of the Help Files<br>
			-Applied Elemental Attack Attributes<br>
			-Applied Level Effects to Attack Skills<br>
			-Bosses are now Immune to Status Effects<br>
			-Changed the Chat Icon to Reduce CPU<br>
			-Changed 'Darkness' Element to 'Dark'<br>
			-Changed the Order of the General/About<br>
			-Created a Loop that Runs per Second<br>
			-Disabled Moving NPCs<br>
			-Game now Distinguishes Message Types (!/?)<br>
			-Game now Distinguishes between Dodge/Miss<br>
			-Increased Regen Speed and Wait<br>
			-Lowered Critical/Miss/Dodge Chances<br>
			-Made Enemies Stronger<br>
			-Minor Tweeks to Various Systems<br>
			-New Resource File Packaged<br>
			-Randomized Enemy Respawn Locations<br>
			-Reset Player's PlayTime<br>
			-Started on the Kidou System<br>
			-Tweeks to Arrow Offset Effect<br>
			-Using Sonic Speed now Requires REI<br>
			-Fixed some Minor Turfing Errors<br>
			-Fixed Bug with Counter Stepping<br>
			-Fixed Bug with Quincy HUD<br>
			-Fixed some RunTime Errors<p>

			03-07-08<br>
			-Version 2.6<br>
			-Added Small Mode<br>
			-Changes to Enemy AI<br>
			-Disabled ColorFlick to Test CPU<br>
			-Added Prevention for Kill Stealing<br>
			-Fixes for Hair, Voice and Zanpakuto Browsers<p>

			03-05-08<br>
			-Version 2.4<br>
			-Noobed down the Tutorial<br>
			-Added 2 new Hollow Types<br>
			-Game now Records Play Time<br>
			-Who List Displays Play Time<br>
			-Widened the Default Who List Size<br>
			-Applied Paralysis Arrow's Effect %<br>
			-Halved the CritBonus of Battle Focus<br>
			-Power Arrow now works as the skill describes<br>
			-Enemies Only Start if you're directly next to them<br>
			-Fixed Bug with Door in Urahara's<br>
			-Fixed a Minor RunTime Error<p>

			03-05-08<br>
			-Version 2.3<br>
			-Added a Delay to PVP and Regen<br>
			-Added NPCs with AI Paths<br>
			-Added a Mute Verb<br>
			-Added New Quests<br>
			-Updated the Spam Filters<br>
			-Minor Tweeks to the Who List<br>
			-Stat/Trait Info written on Map<br>
			-Shikai Call can now use , . or !<br>
			-Disabled Auto Targetting to Test CPU<br>
			-Fixed Bug with Flash Step while Stun<p>

			03-02-08<br>
			-Version 2.2<br>
			-Added New Hair Styles:<br>
				Byakuya<br>
				Kenpachi<br>
				Izuru<br>
			-Changes to the Interface<br>
			-Fixed Projectile PVP<br>
			-Fixed the HUD Fix System <.<<br>
			-Fixed some RunTime Errors<p>

			03-01-08<br>
			-Version 2.1<br>
			-Added a System to AutoRefresh the HUD<br>
			-Changes made to the Interface<br>
			-Changed Resources to PreLoad from my Website<br>
			-Changed the way OnScreen Text works to Prevent Runtimes<p>

			03-01-08<br>
			-Version 2.0<br>
			-Added a Beastiary System<br>
			-Added some Trees to the Map<br>
			-Mapped Karakura HighSchool Exterior<br>
			-Minor Tweeks to Various Systems<br>
			-Burst Arrow Effect now activates OnHit<br>
			-Fixed Bug with Level Shifting<br>
			-Fixed Bug with the Death Effect<br>
			-Fixed Bug with Beast Type Bankais<p>

			02-26-08<br>
			-Version 1.9<br>
			-Added Beast Bankai - Snake Systems<br>
			-Added a Spirit Manager at the Outpost<br>
			-Added Dynamic Level Shifting for Enemies<br>
			-Zanpakuto Blade Color now Effects Swoosh Color<br>
			-Minor Changes Made to the Interface<br>
			-Minor Changes Made to Various Systems<br>
			-Fixed Bug with Counter Attack<br>
			-Fixed Bug with the Messanger<p>

			02-25-08<br>
			-Version 1.8<br>
			-Names now force Upper Case on first letter<br>
			-You can now call out your Zanpakuto<br>
			-Fixed Dates on this Update List<p>


			02-24-08<br>
			-Version 1.7<br>
			-Completed Battle Animations:<br>
				Urahara<br>
				Spire Gulls<br>
			-Zanpakuto Creation System Finished<br>
			-Extended the F Chain to 5<br>
			-Who List now Sorts by Level<br>
			-Changes to Color Flicking<br>
			-Changes to OnScreen Damage<br>
			-Halved Enemy Respawn Time<br>
			-Fixed a layer bug on chairs<p>

			02-24-08<br>
			-Version 1.6<br>
			-Added Traits<br>
			-Added a MOTD<br>
			-Added New Quests<br>
			-Added the Combo Tree<br>
			-Added PVP Display Icon<br>
			-Added Server Management GM<br>
			-Added Forums to the View Menu<br>
			-Added Double Clicking Players for Info<br>
			-Applied Voice Sets to Various Attacks<br>
			-Dodge now precedes over Guard Break<br>
			-Started on the map for Karakura Town<br>
			-Started on the map for the Soul Society<br>
			-Minor Tweeks to Various Systems<br>
			-Major Changes to the HUD<br>
			-Major Changes to Skills and Skill Trees<br>
			-Fixed Bug with Guarding<p>

			02-02-08<br>
			-Version 1.5<br>
			-Added a Barber<br>
			-Added Voice Sets<br>
			-Added Character HUD<br>
			-Added Chargeable Skills<br>
			-Added HotKeys for Skills<br>
			-Added an in-game Messenger<br>
			-Added More Areas to the Map<br>
			-Added Shikai/Zanpakuto Customization<br>
			-PVP is now Available<br>
			-NPC Names are now Displayed<br>
			-Minor Tweeks to Various Systems<br>
			-Changes to Soul Reaper Skill Tree<p>

			01-29-08<br>
			-Version 1.4<br>
			-Added New Quests<br>
			-Added New Enemies<br>
			-Added New Map Areas<br>
			-Added New Hair Styles<br>
			-Changes made to Enemy AI<br>
			-Changed the Levels of Enemies<br>
			-Minor Tweeks to Various Systems<br>
			-Added Skill Names on the Drop Down<br>
			-RunTime Error and Bug Fixes<p>

			01-28-08<br>
			-Version 1.3<br>
			-Changes made to Enemy AI<br>
			-Enlarged the Quest Que Window<br>
			-Minor Tweeks to Various Systems<br>
			-Lowered the EXP Given by Enemies<br>
			-Icon work added on several enemies<br>
			-Death Messages output to Victim only<br>
			-Leveling Up now Restores your Stm & Rei<br>
			-Redid Placement/Size of the OnScreen Text<br>
			-Will no longer Revert while in Battle Mode<br>
			-Enemies Attack 1 at a time Regardless of Level<br>
			-Moving out of view of Target will auto UnTarget<br>
			-Auto Switch to Battle Mode when Enter Spirit Form<br>
			-Added Simple icons for Class/Level Display<br>
			-Added Flashy Wings when you gain a Level<br>
			-Added a Popup Before Choosing Class<br>
			-Added Chat Bubbles when Talking<br>
			-Added New Hair Style: Toshiro<br>
			-Added New Quest Types<br>
			-Added New Quests<br>
			-Fixed Bug with OnScreen Text<br>
			-Fixed Bugs with Bow Combat<br>
			-Fixed Bug with a Quest<br>
			-Fixed some RunTime Errors<p>

			01-23-08<br>
			-Version 1.2<br>
			-Redid the Map<br>
			-Added New Quests<br>
			-Lots if Icon Works<br>
			-Doubled the Map Size<br>
			-Completely Disabled PVP<br>
			-Consolidated Damage Proc<br>
			-Finished Guard Breaker Skill<br>
			-Quest Updates Appear OnScreen<br>
			-Redid the Chain Combat System<br>
			-Redid Stat Point Distribution<br>
			-Made Changes to Base Stat Boosts<br>
			-Animated all current Enemy Types<br>
			-Added New Enemy Types (Unfinished Icons)<br>
			-Counter Step Target Ring Fixes<br>
			-Minor Tweeks to Various Systems<br>
			-ReAdded the Enter/Leave Body Effects<br>
			-Stat/Skill Buttons Glow when Points Remaining<br>
			-Fix for the Multiple Chat Bug<br>
			-Fixed The Spider Type Hollow's Name<p>

			01-15-08<br>
			-Version 1.1<br>
			-Minor Tweeks to Various Systems<br>
			-Combat System Enhancements Added (Counter Stepping)<br>
			-Displays Character Class Icon on Name/Hair Select Screen<br>
			-Cant Speed Step to Places you cant Normaly Walk to<br>
			-Quincy's STR Stat now Figures into Arrow Damage<br>
			-Expansions made to the Quest Systems<br>
			-Cant PVP Untill Level 6<br>
			-Skills Completed: (1st Level Only)<br>
				ShockWave<br>
				Power Shot<br>
				Spirit Blast<br>
				Restore Point<br>
				Spirit Charge<br>
			-Arrow Types Completed: (1st Level Only)<br>
				Paralysis Arrow<br>
				Homing Arrow<br>
				Spread Shot<br>
				Burst Arrow<p>

			01-14-08<br>
			-Version 1.0<br>
			-Original Release<p>

			"},"window=News;size=600x600")