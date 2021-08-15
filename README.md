# MULTIACC-SCRIPT-V1
animation scripts that utilizes multiple accounts.
these scripts was made when i was first starting out with lua, so the code will be EXTREMELY messy. for you clean freaks out there, viewer discretion is advised.

THIS IS NOT A REANIMATIONS SCRIPT! THIS UTILIZES ROBLOX ANIMATIONS!
EXTREMELY BUGGY!

this script was made by twokay
int !#5157/returning#9999/twokay#2222
you can dm me suggestions, but don't report bugs to me about this script, as this script is superseded by V2. use V2 instead!

these scripts, with the help of external programs, can allow you to control multiple accounts!

programs:
https://wearedevs.net/d/Multiple%20RBX%20Games --before you diss me about this being made by "wearedevs," understand that all this program does is create a new mutex for the current running roblox process. you can literally decompile this with ILSpy and you'll see that this isn't a "bitcoin miner."

http://mion.faireal.net/bes/ --this program is used to limit a program's cpu usage. this can be useful if you want to run 10+ alts with less difficulty, as roblox can get cpu-intensive, especially when you have 10 roblox clients running on one pc.

as for your exploits, make sure your exploit has autolaunch and internal ui enabled. 
autolaunch: needed so you can attach your exploit into your most recent launched roblox instance. trying to attach your exploit without autolaunch will most likely say that your exploit is already injected to one instance.
internal ui: this is so you can actually execute scripts with the built in editor on your specific roblox instance.

synapse x is recommended, as that's what i'll be using.

SCRIPT PREPARATIONS:
on the alt portion of the script, change the mainPlr variable from "xyzdrippy" to the username of your "main" account. THIS IS IMPORTANT!

STEP 1:
before running roblox, always make sure to run multiple rbx. if you close out all your roblox instances, relaunch multiple rbx.

STEP 2: 
join a server with the account that you want to use as the "main" controller. if you have autolaunch, your exploit will be already injected.

STEP 2.5 (OPTIONAL):
open battle encoder shirase, and throttle robloxplayerbeta.exe to your desired value. i recommend using the target feature so you won't have to manually limit each instance.

STEP 3:
join the same server with your alts.

STEP 4:
switch back to your "main" roblox instance, and toggle your internal ui. the default hotkey for synapse x is the insert button. paste the main portion of the script and execute it.

STEP 5:
go into each one of your alts, and do the same process, but instead use the alt portion of the script.

STEP 6:
if done correctly, you should be able to control your alts via commands.

commands: 

.form --have alts form around you
.unform --unforms
.reform --resets the formation
.spam "MAKE SURE TO ADD QUOTES BEFORE U USE PARAMS"
.unspam
.assign (name) (degree) --assigns position to assigned degree
.flingpos (name) (offset) --changes fling position. default is 0
.flingdis (name) (distance) --changes fling distance to desired value
.radius (distance) --changes distance to desired value
.timerot/.speed (speed) --changes rotation speed
.resetscript --resets script

DO NOT USE ANY OTHER COMMANDS, AS THEY ARE BUGGY LOL

KEYBINDS:

Q: float
E: looppunch
R: scream (broken)
