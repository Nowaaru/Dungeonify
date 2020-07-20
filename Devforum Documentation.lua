--[[


So I made a thing that took me like, ~~4~~ ~~8~~ ~~12~~ **14** hours to make (question mark?) and I've tried this time and time again and failed miserably so I sat down, turned off my lights, skipped dinner, breakfast and lunch, and I worked on this.
<sub><sub>it would've taken a lot less time to make but i was being considerate because making this was pretty hard so i made this for others to enjoy so they dont have to endure the suffering i had to go through</sub></sub>


..big mistake.

It do dis ting:
![](https://puu.sh/FQ9Lh/4b7f430cc6.gif)
And dis udder ting (loops):
![](https://cdn.discordapp.com/attachments/704481943437181028/715815112711209000/unknown.png)
it do dis (1530 blocks and ZERO collision), does it very fast too:
![](https://puu.sh/FQauq/47b277770c.png)
it also go hie:
![](https://puu.sh/FQyvH/3781a3a4c9.png)

* * *
<h1>Notable Features</h1>

<ul>
	<li>Literally cannot collide with anything.</li>
	<li>Super fast. Super super fast. Could be even faster via """"""multithreading"""""" but I couldn't figure it out.
		<ul>
			<li>13 seconds with one Heartbeat yielding function per iteration. for 1,302 pieces.</li>
			<li>0.5 seconds with no yielding function for 203 pieces (very dangerous, please keep the yielding function) </li>
		</ul> 
	</li>
	<li> Supports a piece of any size as long as the bounding box size is accurate.
	<li> Based off of Attachments (in all honesty, they're just parts), The module will look for objects named "Snap" with a number following it.
	<li> Automatically walls off unbranched places.</li>
	<li> Follows quotas. If there needs to be a specific quota of pieces met, it will keep refreshing the dungeon until the quota is met.</li>
	<li> Modular, use require in order to use.
	<li> Supplies it's own errors and assertions. If you manage to fish out a natural error, then colour me surprised. </li>
	<li> Supports restrictions. Be sure to impose loose restrictions otherwise it will take more time to make it just right. </li>
	<li> Supports custom hitboxes. (i think, probably just a side-effect of my bad coding hehe) </li>
	<li> Fuzzy. Custom properties are not case sensitive and is not required to be plural. </li>
	<li> Supports heights. </li>
</ul>

* * *
<h1>Warnings</h1>

* Attachments are **strictly** named. Weird names like Snap0.4 or SnapA will not work.
* If you wish to support walling off for a piece, have the name being correspondant to the joint with the word wall following, i.e. "Snap4" and "Snap4Wall", "Snap82" and "Snap82Wall." 
* Attempts to pass an impossible quota/restriction pair will error.
* Attempts to pass an impossible restriction or quota via MaxPieces or MinPieces will error.
* Attempts to pass an impossible quota via MaxPieces or MinPieces will also error.
* Addends are not mandatory, however they are added to the Part-Statistic measurings. If you want an addend to be necessary, put in the Quota.
* Long loops are bound to be a thing. The stricter the quota and restriction, the longer it will take to get a satisfactory map.
* Every piece has to be modeled and it **must** have a primary part that signifies where it's going to be connected from.

* * *
<h1>Acknowledgements / Credits</h1>

* @InfinityDesign for helping me come up with grid-based solution (which in the end, i didn't use)
* @megukoo for support.
* @eLunate for help and being mean.
* @EgoMoose for his RotatedRegion3 module.

* * *
If you find any bugs or anything that could be potentially harmful to a game, please let me know. I'll get on it fast since I have an abundance of free time.
]]--