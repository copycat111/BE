# Supporting Systems

Last reviewed: 2026-02-14

## Scope
This document describes non-core gameplay systems: moderation, messaging, operational controls, telemetry, compatibility checks, and administrative tooling.

## Administrative and Moderation Controls
### Local GM controls
`Coding/GM.dm` provides in-server operations and moderation verbs.

Key functions:
- Ban/mute execution and data model (`datum/PlayerInfo`, `ExecuteBan`, `ExecuteMute`) at `Coding/GM.dm:8`, `Coding/GM.dm:34`, `Coding/GM.dm:41`
- Mute enforcement (`IsMuted`, `MuteExpire`) at `Coding/GM.dm:16`, `Coding/GM.dm:23`
- GM verbs for boot/reboot/shutdown/player limit/multikey/tp/edit at `Coding/GM.dm:48`

Persistent moderation lists (`MuteList`, `BanList`) are stored through `SaveConfig()` in `Coding/Main.dm:99`.

### Global moderation feeds
Remote global lists are loaded from HTTP endpoints:
- Global bans: `Coding/GlobalBan.dm:23`
- Global mutes: `Coding/GlobalMutes.dm:23`

Both modules:
- Parse remote text into in-memory lists
- Retry on failure and periodic refresh every 36000 ticks
- Apply checks against key, IP, computer ID, and wildcard IP ranges

## Communication Systems
### Chat channels and formatting
Primary chat verbs are in `Coding/Verbs.dm` (`Say`, `Role_Play`, chat mode switching).

Supported chat scopes:
- Global
- Zone
- Local (distance-based)
- Party

Channel behavior and UI selection are managed with `winset()` in `Coding/MenuVerbs.dm`.

### Private messaging and buddy list
`Coding/Topics.dm` handles PM link actions (`action=PrivateMessage`) and message routing.

`Coding/Messengar.dm` provides:
- Buddy list render/update (`UpdateBL`)
- New-message state (`NewMessages`)
- Mail icon flashing (`MailUpdate`)

### Spam and offensive filtering
`Coding/OffensiveFilter.dm` implements:
- Remote offensive word list loading (`LoadOffensiveWords`)
- Spam checks for repeat messages, rapid message windows, repeated letters, and link suppression
- Message normalization and replacement masking

`mob/proc/SpamGuard` at `Coding/OffensiveFilter.dm:119` is the main inbound guard path used by chat and PM sending.

## Subscriber/Entitlement System
Subscriber support lives in:
- `Coding/Subscribers.dm`
- `Coding/SubscriberVerbs.dm`

Capabilities include:
- Remote entitlement list load (`LoadSubs`) from HTTP
- Runtime entitlement activation/removal (`SubCheck`, `RemoveSub`)
- Subscriber cosmetic controls (font color/face, clothes dye)

Entitlement status affects:
- Verb availability
- Cosmetic persistence and expiration behavior

## Voting System
`Coding/Voting.dm` provides vote-based moderation (currently vote-mute).

Features:
- Vote object lifecycle and timed expiration
- One-start-per-hour limiter (`VoteLimit`)
- Vote history log rendering
- Auto-enforcement on successful/failed outcomes

## Compatibility and Version Enforcement
### Game version checks
In `Coding/Main.dm`:
- `RequiredVersion()` and `CheckCurrentVersion()` optionally query remote endpoints and can force server shutdown on out-of-date builds (`Coding/Main.dm:302`, `Coding/Main.dm:315`).

### BYOND client version checks
`Coding/VerifyByondVersion.dm` loads a required BYOND version and disconnects outdated clients (`Coding/VerifyByondVersion.dm:3`, `Coding/VerifyByondVersion.dm:13`).

## Telemetry, Logging, and Diagnostics
### CPU telemetry
`Coding/CpuLogger.dm` tracks:
- Peak CPU
- Average CPU
- Ticks over 100%
- Average player count

### Client identity log
`Coding/ClientLogger.dm` stores key/IP/computer ID history in:
- `ClientLog.sav` (count)
- `ClientLog.txt` (table body)

### In-game profiling/test tools
`Coding/TestVerbs.dm` includes:
- Datum and atom profilers (`Profile_Datums`, `Profile_Atoms`)
- Object/overlay/enemy counters
- Refresh verbs for remote list feeds
- Various diagnostics and utility tools restricted to trusted keys

## Scoreboards and Leaderboards
`Coding/Scoreboards.dm` tracks:
- Arena scores (top rounds)
- Overall scores (level/playtime/class)

Both are persisted through `SaveConfig()`.

## Configuration and Operational Data
World-operational state in `Coding/Vars.dm` + `Coding/Main.dm` includes:
- Runtime feature toggles (`EnableStartupProfilers`, `EnableStartupDiagnostics`, `EnableRemoteHttpChecks`)
- Capacity/multikey flags (`PlayerLimit`, `CanMultiKey`)
- Hub status text (`StatusNote`)
- Logged IP report data (`LoggedIPs`, `LoggedIPCount`)

## Operational Risks and Notes
- Remote dependencies use legacy HTTP endpoints (`angelfire.com` URLs) across moderation, subscriber, offensive-word, version, and BYOND checks.
- If remote checks are enabled and endpoints fail/lag, startup behavior can become inconsistent.
- Several support modules override shared lifecycle hooks (`world/New`, `mob/Login`), so include order and `..()` chains must remain intact.
- Some admin/test verbs are powerful (editing arbitrary vars, ftp download, forced actions) and should remain tightly restricted.

## Quick Module Index
- Moderation/admin: `Coding/GM.dm`, `Coding/GlobalBan.dm`, `Coding/GlobalMutes.dm`, `Coding/Voting.dm`
- Messaging/chat/filter: `Coding/Verbs.dm`, `Coding/MenuVerbs.dm`, `Coding/Topics.dm`, `Coding/Messengar.dm`, `Coding/OffensiveFilter.dm`
- Entitlements: `Coding/Subscribers.dm`, `Coding/SubscriberVerbs.dm`
- Logging/diagnostics: `Coding/CpuLogger.dm`, `Coding/ClientLogger.dm`, `Coding/TestVerbs.dm`
- Compatibility/versioning: `Coding/Main.dm`, `Coding/VerifyByondVersion.dm`
- Leaderboards: `Coding/Scoreboards.dm`
