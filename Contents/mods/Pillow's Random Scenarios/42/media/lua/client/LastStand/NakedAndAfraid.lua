NakedAndAfraid = {}


NakedAndAfraid.Add = function()
	addChallenge(NakedAndAfraid);
end

NakedAndAfraid.OnGameStart = function()

    		
Events.OnGameStart.Add(NakedAndAfraid.OnNewGame);
Events.EveryTenMinutes.Add(NakedAndAfraid.EveryTenMinutes);
Events.EveryHours.Add(NakedAndAfraid.EveryHours);

end

NakedAndAfraid.DifficultyCheck = function()
	local pl = getPlayer();
	pillowmod = pl:getModData();

	if ModOptions and ModOptions.getInstance then
		pillowmod.alwaysdire = PillowModOptions.options.alwaysdire
		pillowmod.alwaysbrutal = PillowModOptions.options.alwaysbrutal
	end 

	--1in2 is dire, and 1in4 of those is brutal.
	if ZombRand(2)+1 == ZombRand(2)+1 
		then 
			pillowmod.direstart = true;
			pillowmod.brutalstart = false;
			if ZombRand(4)+1 == ZombRand(4)+1
			then pillowmod.brutalstart = true;
				pillowmod.direstart = false;
			else print("Normal Start selected");
				pillowmod.direstart = false;
				pillowmod.brutalstart = false;
			end
	end 

	--do override
	if pillowmod.alwaysdire == true
		then pillowmod.direstart = true;
			pillowmod.brutalstart = false;
	elseif pillowmod.alwaysbrutal == true
		then pillowmod.brutalstart = true;
			pillowmod.direstart = false;
	else end

	--play the sound
	if pillowmod.direstart 
	and pillowmod.soundplayed == nil 
	then
 		print("Dire Start selected");
		pl:playSound("Thunder");
		pillowmod.soundplayed = true;

	elseif pillowmod.brutalstart 
	and pillowmod.soundplayed == nil
	then
		print("Brutal Start selected");
		pl:playSound("PlayerDied");
		pillowmod.soundplayed = true;
	else end

end--end difficulty check

NakedAndAfraid.OnNewGame = function()

NakedAndAfraid.DifficultyCheck();

--moved this stuff from onGameStart. 
--
NakedAndAfraid.itemlist = {"Base.Spiffo","Base.Banana","Base.Hat_SantaHatGreen","Base.Scalpel","Base.Ham","Base.Glasses_Aviators","Base.Bleach"};
local pl = getPlayer();
local inv = pl:getInventory();
		--check if it's a new game
		print(pl:getHoursSurvived());
		if getPlayer():getHoursSurvived()<=1 then
			--initialize some scenario variables
			pillowmod.wasalarmed = false ;
			pillowmod.building = pl:getCurrentSquare():getRoom():getBuilding();
			--remove everything
			pl:clearWornItems();
		    pl:getInventory():clear();
		    inv:AddItem("Base.KeyRing");

		    if ZombRand(2) == 1 then
		    inv:AddItem(NakedAndAfraid.itemlist[ZombRand(7)]);
			else
			sq = getCell():getGridSquare(pl:getX()+2, pl:getY()-2, pl:getZ());
			sq:AddWorldInventoryItem(NakedAndAfraid.itemlist[ZombRand(7)], 0, 0, 0);
			end 
		  	--set stats 
			pl:getStats():setPanic(100); -- 0 to 100
			pl:getStats():setStress(100); -- 0 to 100
		else 
		end

end

NakedAndAfraid.BuildingAlarmCheck = function()
	pl = getPlayer();

	--check player's building since they could have left
	if pl:getCurrentSquare():getRoom() == nil
		then return
		else pillowmod.plbuilding = pl:getCurrentSquare():getRoom():getBuilding();
	end 

	--make sure player isn't outside nor the alarm has not been set and the current building is not the spawn building
	if (pl:getCurrentSquare():isOutside() == true 
		or pillowmod.wasalarmed == true )
		and (pillowmod.plbuilding ~= pillowmod.building)
		then return
		else 
			pillowmod.plbuilding:getDef():setAlarmed(true);
			pillowmod.wasalarmed = true;
			print("set alarm");
	end 
end--building alarm function

NakedAndAfraid.EveryTenMinutes = function()
	if pillowmod.brutalstart
		then NakedAndAfraid.BuildingAlarmCheck();
	else end 
end -- every 10 mins

NakedAndAfraid.EveryHours = function()
	if pillowmod.direstart
		then NakedAndAfraid.BuildingAlarmCheck();
	else end 
end --every hours.


NakedAndAfraid.OnInitWorld = function()
--SandboxVars = require "Sandbox/SixMonthsLater"

	--SandboxVars.StartMonth = 7;
	Events.OnGameStart.Add(NakedAndAfraid.OnGameStart);
	NakedAndAfraid.setSandBoxVars();

end

NakedAndAfraid.setSandBoxVars = function()

end



NakedAndAfraid.RemovePlayer = function(p)

end

NakedAndAfraid.AddPlayer = function(p)

end

NakedAndAfraid.Render = function()

end

NakedAndAfraid.spawns = {
{xcell = 41, ycell = 17, x = 242, y = 115, z = 0}, -- Valley Station,  vacant store ID:87
{xcell = 39, ycell = 23, x = 159, y = 12, z = 0}, -- West Point,  vacant store  ID:115
{xcell = 38, ycell = 23, x = 259, y = 136, z = 0}, -- West Point,  vacant store ID:157
{xcell = 35, ycell = 31, x = 109, y = 164, z = 0}, -- Muldraugh,  vacant storefront ID:229
{xcell = 35, ycell = 33, x = 112, y = 6, z = 0}, -- Muldraugh,  vacant store  ID:249
{xcell = 35, ycell = 33, x = 122, y = 138, z = 0}, -- Muldraugh,  abandoned restaraunt ID:258
{xcell = 35, ycell = 33, x = 127, y = 247, z = 0}, -- Muldraugh,  vacant store ID:263
{xcell = 35, ycell = 34, x = 110, y = 117, z = 0}, -- Muldraugh,  vacant store ID:269
{xcell = 35, ycell = 34, x = 109, y = 150, z = 0}, -- Muldraugh,  vacant store 1 ID:273
{xcell = 35, ycell = 34, x = 109, y = 158, z = 0}, -- Muldraugh,  vacant store 2 ID:274
{xcell = 39, ycell = 29, x = 59, y = 103, z = 0}, -- Dixie, vacant trailer
{xcell = 19, ycell = 17, x = 111, y = 217, z = 0}, -- Riverside, vacant house
{xcell = 26, ycell = 38, x = 249, y = 156, z = 0}, -- Rosewood, vacant house
{xcell = 38, ycell = 22, x = 222, y = 281, z = 0}, -- Westpointe, vacant house
{xcell = 36, ycell = 33, x = 111, y = 120, z = 0}, -- muldraugh, vacant house
{xcell = 36, ycell = 30, x = 285, y = 237, z = 0} -- Muldraugh, abandoned station
{xcell = 11, ycell = 21, x = 71, y = 171, z = 0}, -- Creepy camp near the Sanatorium
{xcell = 13, ycell = 21, x = 162, y = 223, z = 5}, -- Sunderland Hills Sanatorium
{xcell = 14, ycell = 20, x = 7, y = 288, z = 0}, -- Vacant house near Sunderland Hills Sanatorium
{xcell = 13, ycell = 20, x = 204, y = 125, z = 0}, -- Vacant house near Sunderland Hills Sanatorium 2
{xcell = 13, ycell = 20, x = 25, y = 286, z = 0}, -- Vacant house near Sunderland Hills Sanatorium 3
{xcell = 12, ycell = 20, x = 229, y = 222, z = -1}, -- Abandoned factory near Sunderland Hills Sanatorium
{xcell = 9, ycell = 30, x = 181, y = 103, z = 0}, -- Boarding school
{xcell = 11, ycell = 27, x = 163, y = 95, z = 0}, -- Coalfield, crossroads
{xcell = 7, ycell = 20, x = 152, y = 227, z = 0}, -- Brandenburg, house half-ravaged by the tornado
{xcell = 7, ycell = 21, x = 134, y = 105, z = 0}, -- Brandenburg, lab destroyed by the tornado
{xcell = 9, ycell = 44, x = 216, y = 202, z = 0}, -- Abandoned house near Irvington
{xcell = 8, ycell = 46, x = 205, y = 284, z = 0}, -- Abandoned train stop near Irvington
{xcell = 19, ycell = 48, x = 50, y = 176, z = 0}, -- Tents east of Irvington
{xcell = 1, ycell = 31, x = 276, y = 124, z = 0}, -- Abandoned Ekron Train Station
{xcell = 27, ycell = 49, x = 18, y = 202, z = 0}, -- Survivor camps near the lakes
{xcell = 12, ycell = 41, x = 213, y = 6, z = -1}, -- Cult farm, basement
{xcell = 12, ycell = 40, x = 240, y = 143, z = 0} -- Cult farm, stables
}



local spawnselection = ZombRand(33)+1;
local xcell = NakedAndAfraid.spawns[spawnselection].xcell;
local ycell = NakedAndAfraid.spawns[spawnselection].ycell;
local x = NakedAndAfraid.spawns[spawnselection].x;
local y = NakedAndAfraid.spawns[spawnselection].y;
local z = NakedAndAfraid.spawns[spawnselection].z;


NakedAndAfraid.id = "NakedAndAfraid";
NakedAndAfraid.image = "media/lua/client/LastStand/NakedAndAfraid.png";
NakedAndAfraid.gameMode = "NakedAndAfraid";
NakedAndAfraid.world = "Muldraugh, KY";
NakedAndAfraid.xcell = xcell;
NakedAndAfraid.ycell = ycell;
NakedAndAfraid.x = x;
NakedAndAfraid.y = y;
NakedAndAfraid.z = z;
NakedAndAfraid.enableSandbox = true;

Events.OnChallengeQuery.Add(NakedAndAfraid.Add)

