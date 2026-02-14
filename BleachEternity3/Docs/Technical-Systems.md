# Technical Systems

Last reviewed: 2026-02-14

## Scope
This document describes gameplay-critical runtime systems, their module boundaries, and how data and control flow between them.

## Source Topology
Primary source inclusion order is defined in `BleachEternity2.dme` (the `#include "Coding\*.dm"` block).

High-level runtime ownership is split across:
- Core runtime and lifecycle: `Coding/Main.dm`, `Coding/Vars.dm`, `Coding/Procs.dm`
- Combat and actions: `Coding/BattleSystem.dm`, `Coding/SkillProcs.dm`, `Coding/KidouProcs.dm`, `Coding/SpellProcs.dm`
- Data/content declarations: `Coding/Skills.dm`, `Coding/Kidous.dm`, `Coding/Spells.dm`, `Coding/Equipment.dm`, `Coding/Items.dm`
- Progression and world interaction: `Coding/QuestSystem.dm`, `Coding/QuestNPCs.dm`, `Coding/NPCs.dm`, `Coding/Enemy.dm`, `Coding/EnemySkills.dm`
- Player UX/UI: `Coding/HUD.dm`, `Coding/HUDlowCPU.dm`, `Coding/OnScreenText.dm`, `Coding/Inventory.dm`, `Coding/DragDrop.dm`, `Coding/MenuVerbs.dm`, `Coding/StatPanel.dm`
- Persistence: `Coding/Save.dm`

## Runtime Startup Model
### Boot chain
Main startup entrypoint is `world/New()` in `Coding/Main.dm:22`.

During startup, the server:
- Initializes logging and startup metrics (`Coding/Main.dm:23`, `Coding/Main.dm:25`)
- Builds content caches (`AllSpecials`, `ShikaiSkillNames`, `BankaiSkillNames`, `HollowTypes`) in `Coding/Main.dm:28`
- Loads persistent world config from `config.sav` in `Coding/Main.dm:37`
- Runs world preprocessing/setup (`BackgroundWorldSetup`, `SpawnFlowers`, stat/trait/pet/keyboard setup) in `Coding/Main.dm:57`
- Starts recurring loops (`TimeLoop`, `WorldLoop`) in `Coding/Main.dm:74`
- Optionally starts remote checks and startup profilers in `Coding/Main.dm:76`

Additional startup hooks also exist and chain via `..()`:
- `world/New()` in `Coding/ClientLogger.dm:23`
- `world/New()` in `Coding/VerifyByondVersion.dm:26`

Because multiple modules override `world/New`, include order in `BleachEternity2.dme` is a real behavior dependency.

### Global loop scheduler
Recurring global loops are driven by `spawn()` + sleep patterns:
- `TimeLoop()` every 10 ticks (`Coding/Main.dm:166`, `Coding/Main.dm:186`)
- `WorldLoop()` every 3000 ticks (`Coding/Main.dm:334`, `Coding/Main.dm:341`)
- `LogCPU()` every tick (`Coding/CpuLogger.dm:7`)

## Player Session Lifecycle
### Login path
Primary login handling is in `mob/Login()` at `Coding/Main.dm:198`.

Login sequence includes:
- Client identity logging and ban checks (`Coding/Main.dm:199`, `Coding/Main.dm:200`)
- Player config load and session flags (`Coding/Main.dm:247`)
- Window/macro/hotkey setup (`Coding/Main.dm:261`)
- Start per-player loops (`CoolDownSystem`, `SecondLoop`) at `Coding/Main.dm:276`

Additional login hook exists in `Coding/VerifyByondVersion.dm:30` and chains to main login via `..()`.

### Logout and client deletion
Cleanup and persistence occur in two places:
- `mob/Logout()` in `Coding/Main.dm:286`
- `client/Del()` in `Coding/Save.dm:2` (calls `Save`, `SaveLogonFile`, `SavePlayerConfig`, pet cleanup)

## Persistence Model
### Persistent stores
- World config: `config.sav` via `SaveConfig()` (`Coding/Main.dm:99`)
- Character save slot files: `Players/<ckey-prefix>/<ckey><slot>.sav` (`Coding/Save.dm:107`)
- Character backup copy: `PlayersBackup/...` (`Coding/Save.dm:210`)
- Per-account config: `Configs/<ckey>.txt` (`Coding/Save.dm:51`)
- Logon flags: `Logons/<ckey>.txt` (`Coding/Save.dm:39`)

### Character load and migration
`mob/proc/Load()` in `Coding/Save.dm:219` hydrates the full character state, then runs `SaveFixes()` (`Coding/Save.dm:371`) for version migration and data normalization.

### Save cadence
Saving occurs via:
- Manual save verb (`Coding/Save.dm:23`)
- Client teardown (`Coding/Save.dm:2`)
- Quest completion (`Coding/QuestSystem.dm:147`)
- Optional autosave proc exists (`Coding/Main.dm:348`) but login autostart call is commented (`Coding/Main.dm:283`).

## Combat and Simulation Systems
### Combat invocation path
Action entrypoints are mostly hidden verbs in `Coding/BattleSystem.dm`:
- `UseSkill`, `LowAttack`, `MidAttack`, `HighAttack`, `Defend`, targeting verbs (`Coding/BattleSystem.dm:29` onward)

Skill dispatch is dynamic:
- `UseSkillProc(Skill2Call)` resolves known skill object and calls `call(src,"[Skill2Call]")()` (`Coding/BattleSystem.dm:2`, `Coding/BattleSystem.dm:27`)

### Damage pipeline
Core damage logic is centralized in `mob/proc/Damage()` in `Coding/Procs.dm:790`.

It handles:
- PvP legality and target management
- Dodge, guard, counter, crit, elemental modifiers
- Status effect application
- Final STM reduction and death trigger via `DeathCheck()` (`Coding/Procs.dm:874`)

### Death and rewards
`DeathCheck()` in `Coding/Procs.dm:247` handles:
- Player death reset/respawn and PvP honor updates
- Enemy respawn behavior
- PvE reward distribution (drops, quest progress, EXP/gold, party split)

### Projectile subsystem
Projectile types and collision logic are in `Coding/BattleSystem.dm` (`obj/Projectile` block at `Coding/BattleSystem.dm:168`).

### Status effects subsystem
Status effect datums and lifecycle are in `Coding/StatusEffects.dm`:
- Registration and UI display (`Coding/StatusEffects.dm:1`)
- Add/remove/execute semantics (`Coding/StatusEffects.dm:46`, `Coding/StatusEffects.dm:52`, `Coding/StatusEffects.dm:111`)
- Per-second ticking via `StatusDuration()` (`Coding/StatusEffects.dm:149`)

## Skills, Kidou, and Spells Architecture
Data and behavior are intentionally split:
- Definition/metadata (costs, types, rank, descriptions): `Coding/Skills.dm`, `Coding/Kidous.dm`, `Coding/Spells.dm`
- Runtime behavior procs: `Coding/SkillProcs.dm`, `Coding/KidouProcs.dm`, `Coding/SpellProcs.dm`
- Tree loading and point allocation UX: `Coding/SkillTree.dm`

This model depends on name-based dispatch (`call(src,"[SkillName]")`) and consistent naming across definition and implementation modules.

## AI and Entity Systems
### Enemy AI
Enemy base and AI loop are in `Coding/Enemy.dm`:
- Spawn/init and scaling (`Coding/Enemy.dm:49`, `Coding/Enemy.dm:69`)
- Behavior loop (`EnemyAI`) with target checks, movement, melee/skill action selection (`Coding/Enemy.dm:87`)

Enemy abilities are defined in `Coding/EnemySkills.dm`.

### Pet AI and gambits
- Pet actor and AI loop: `Coding/Pets.dm` (`ActivateAI` at `Coding/Pets.dm:33`)
- Gambit condition/action DSL: `Coding/Gambits.dm`

Pet decision flow:
1. Resolve target (`datum/Gambits/Targets`)
2. Resolve variable (`datum/Gambits/Variables`)
3. Apply operator and variable type
4. Execute action (`Attack`, `UseSkill`, `UseItem`, movement)

## Progression and World Systems
### Quest system
Quest state and objectives are in `Coding/QuestSystem.dm`.

Core behaviors:
- Quest add/complete/abandon (`Coding/QuestSystem.dm:103`, `Coding/QuestSystem.dm:128`, `Coding/QuestSystem.dm:164`)
- HUD tracking (`Coding/QuestSystem.dm:198`)
- Quest marker and map-location support (`Coding/QuestSystem.dm:185`, `Coding/QuestSystem.dm:229`)

### Party, duel, and arena
- Party creation/invite/HUD: `Coding/Party.dm`
- Duel challenge object and pairing: `Coding/PVP.dm`
- Arena rounds and progression loop: `Coding/Arena.dm`

## UI/HUD Systems
### HUD architecture
Main HUD composition is in `mob/proc/HUD()` (`Coding/HUD.dm:629`).

The UI stack combines:
- Traditional screen objects (`client.screen` additions)
- Low-CPU text datum overlays (`Coding/HUDlowCPU.dm`)
- On-screen text/dialog overlay framework (`Coding/OnScreenText.dm`)

### Per-player runtime loops that update UI and state
- `SecondLoop()` in `Coding/StatPanel.dm:94` drives regen, status updates, quest timers, and party HUD refresh once per second
- `CoolDownSystem()` in `Coding/HUD.dm:589` updates cooldowns every tick

### Inventory and drag/drop
- Inventory display and equipment slots: `Coding/Inventory.dm`
- Drag-and-drop equip/hotkey wiring: `Coding/DragDrop.dm`

## Performance-Critical Patterns and Risks
Observed architecture-level hotspots:
- High frequency `spawn()` loops across global, player, enemy, and pet systems (`Coding/Main.dm`, `Coding/StatPanel.dm`, `Coding/HUD.dm`, `Coding/Enemy.dm`, `Coding/Pets.dm`)
- Name-based dynamic dispatch for skills/spells/kidou (`Coding/BattleSystem.dm:27`) can hide missing-proc failures until runtime
- Screen-object-heavy UI construction (HUD and dialog systems) can create large `New()` counts if called repeatedly (`Coding/HUD.dm`, `Coding/OnScreenText.dm`)
- Multiple `world/New` and `mob/Login` overrides across modules require strict `..()` chaining correctness and stable include order (`Coding/Main.dm`, `Coding/ClientLogger.dm`, `Coding/VerifyByondVersion.dm`)

## Suggested Reading Order for New Contributors
1. `Coding/Vars.dm`
2. `Coding/Main.dm`
3. `Coding/Save.dm`
4. `Coding/Procs.dm`
5. `Coding/BattleSystem.dm`
6. `Coding/SkillProcs.dm`, `Coding/KidouProcs.dm`, `Coding/SpellProcs.dm`
7. `Coding/HUD.dm`, `Coding/HUDlowCPU.dm`, `Coding/OnScreenText.dm`
8. `Coding/QuestSystem.dm`, `Coding/Party.dm`, `Coding/Arena.dm`, `Coding/PVP.dm`
