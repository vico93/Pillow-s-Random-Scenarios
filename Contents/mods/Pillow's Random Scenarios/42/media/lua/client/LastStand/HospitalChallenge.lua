--require "PillowsRandomScenarios.lua"

HospitalChallenge = {}

HospitalChallenge.Add = function()
	addChallenge(HospitalChallenge);
end

HospitalChallenge.OnGameStart = function()

	Events.OnGameStart.Add(HospitalChallenge.OnNewGame);

end

HospitalChallenge.DifficultyCheck = function()
	local pl = getPlayer();
	pillowmod = pl:getModData();

	if ModOptions and ModOptions.getInstance then
		pillowmod.alwaysdire = PillowModOptions.options.alwaysdire
		pillowmod.alwaysbrutal = PillowModOptions.options.alwaysbrutal
	end

	--1in2 is dire, and 1in4 of those is brutal.
	if pillowmod.diffcheckdone == nil
		and ZombRand(2)+1 == ZombRand(2)+1
		then 
			pillowmod.direstart = true;
			pillowmod.brutalstart = false;
			pillowmod.diffcheckdone = true;
			if  ZombRand(4)+1 == ZombRand(4)+1
			then
			 	pillowmod.brutalstart = true;
				pillowmod.direstart = false;
				pillowmod.diffcheckdone = true;
			else 
				pillowmod.brutalstart = false;
			end
		else 
				pillowmod.direstart = false;
				pillowmod.brutalstart = false;
				pillowmod.diffcheckdone = true;
				print("Normal Start selected");
	end 

	--do override
	if pillowmod.alwaysdire == true
		then pillowmod.direstart = true;
			pillowmod.brutalstart = false;
	elseif pillowmod.alwaysbrutal == true
		then pillowmod.brutalstart = true;
			pillowmod.direstart = false;
	else end


	--change to do dire roll, then assign variables. This where override always dire/brutal.
	if pillowmod.direstart == true
		then
			--dire variables
			pillowmod.brutalstart = false;
			pillowmod.difficultymodifier = ZombRand(5,10);
			pillowmod.injurytimemodifier = ZombRand(10,20);
			pillowmod.drunkmodifier = 25;
	elseif  pillowmod.brutalstart == true
		then
			--brutal variables
			pillowmod.direstart = false;
			pillowmod.difficultymodifier = ZombRand(10,20);
			pillowmod.injurytimemodifier = ZombRand(10,30);
			pillowmod.drunkmodifier = 50;
	else
			--normal variables
			pillowmod.difficultymodifier = 0;
			pillowmod.injurytimemodifier = 0;
			pillowmod.drunkmodifier = 0;
	end



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


end -- end DifficultyCheck

HospitalChallenge.ApplyInjuries = function() 
	local pl = getPlayer();
	--random injury
	local injury = ZombRand(8)+1;
	damage = pillowmod.difficultymodifier + 20;
	injurytime = 25+ pillowmod.injurytimemodifier;
		if injury == 1 then
			pl:getBodyDamage():getBodyPart(BodyPartType.LowerLeg_R):AddDamage(damage);
	        pl:getBodyDamage():getBodyPart(BodyPartType.LowerLeg_R):setFractureTime(injurytime);
	        pl:getBodyDamage():getBodyPart(BodyPartType.LowerLeg_R):setSplint(true, .8);
	        pl:getBodyDamage():getBodyPart(BodyPartType.LowerLeg_R):setBandaged(true, 5, true, "Base.AlcoholBandage");
	    elseif injury == 2 then
	    	pl:getBodyDamage():getBodyPart(BodyPartType.LowerLeg_L):AddDamage(damage);
	        pl:getBodyDamage():getBodyPart(BodyPartType.LowerLeg_L):setFractureTime(injurytime);
	        pl:getBodyDamage():getBodyPart(BodyPartType.LowerLeg_L):setSplint(true, .8);
	        pl:getBodyDamage():getBodyPart(BodyPartType.LowerLeg_L):setBandaged(true, 5, true, "Base.AlcoholBandage");
	    elseif injury == 3 then
	    	pl:getBodyDamage():getBodyPart(BodyPartType.UpperLeg_R):AddDamage(damage);
	        pl:getBodyDamage():getBodyPart(BodyPartType.UpperLeg_R):setFractureTime(injurytime);
	        pl:getBodyDamage():getBodyPart(BodyPartType.UpperLeg_R):setSplint(true, .8);
	        pl:getBodyDamage():getBodyPart(BodyPartType.UpperLeg_R):setBandaged(true, 5, true, "Base.AlcoholBandage");
	    elseif injury == 4 then
	    	pl:getBodyDamage():getBodyPart(BodyPartType.UpperLeg_L):AddDamage(damage);
	        pl:getBodyDamage():getBodyPart(BodyPartType.UpperLeg_L):setFractureTime(injurytime);
	        pl:getBodyDamage():getBodyPart(BodyPartType.UpperLeg_L):setSplint(true, .8);
	        pl:getBodyDamage():getBodyPart(BodyPartType.UpperLeg_L):setBandaged(true, 5, true, "Base.AlcoholBandage");
		elseif injury == 5 then
	    	pl:getBodyDamage():getBodyPart(BodyPartType.UpperArm_L):AddDamage(damage);
	        pl:getBodyDamage():getBodyPart(BodyPartType.UpperArm_L):setFractureTime(injurytime);
	        pl:getBodyDamage():getBodyPart(BodyPartType.UpperArm_L):setSplint(true, .8);
	        pl:getBodyDamage():getBodyPart(BodyPartType.UpperArm_L):setBandaged(true, 5, true, "Base.AlcoholBandage");
	    elseif injury == 6 then
	    	pl:getBodyDamage():getBodyPart(BodyPartType.LowerArm_L):AddDamage(damage);
	        pl:getBodyDamage():getBodyPart(BodyPartType.LowerArm_L):setFractureTime(injurytime);
	        pl:getBodyDamage():getBodyPart(BodyPartType.LowerArm_L):setSplint(true, .8);
	        pl:getBodyDamage():getBodyPart(BodyPartType.LowerArm_L):setBandaged(true, 5, true, "Base.AlcoholBandage");
	    elseif injury == 7 then
	    	pl:getBodyDamage():getBodyPart(BodyPartType.UpperArm_R):AddDamage(damage);
	        pl:getBodyDamage():getBodyPart(BodyPartType.UpperArm_R):setFractureTime(injurytime);
	        pl:getBodyDamage():getBodyPart(BodyPartType.UpperArm_R):setSplint(true, .8);
	        pl:getBodyDamage():getBodyPart(BodyPartType.UpperArm_R):setBandaged(true, 5, true, "Base.AlcoholBandage");
		else 
			pl:getBodyDamage():getBodyPart(BodyPartType.LowerArm_R):AddDamage(damage);
	        pl:getBodyDamage():getBodyPart(BodyPartType.LowerArm_R):setFractureTime(injurytime);
	        pl:getBodyDamage():getBodyPart(BodyPartType.LowerArm_R):setSplint(true, .8);
	        pl:getBodyDamage():getBodyPart(BodyPartType.LowerArm_R):setBandaged(true, 5, true, "Base.AlcoholBandage");
	    end 
end --end ApplyInjuries

HospitalChallenge.MakeItSpicy = function()
	local pl = getPlayer();
	pillowmod = pl:getModData();
	plbuilding = pl:getCurrentSquare():getRoom():getBuilding();	
	tile = plbuilding:getRandomRoom():getRandomSquare();

	spice = ZombRand(3) +1;
	if pillowmod.spiceadded == nil
			then 
		if spice == 1 then
			plbuilding:getDef():setAlarmed(true);	
			print("Spice is an alarm.");
		elseif spice == 2 then
			tile:explode();
			print("Spice is a fire.");
		else
			local x = pl:getX() + 12;
			local y = pl:getY() + 12;
			local z = pl:getZ();
			addZombiesInOutfit(x, y, z, 12, nil, 0);
			addSound(getPlayer(), getPlayer():getX(), getPlayer():getY(), 0, 500, 500); 
			print("Spice is a horde.");
		end 
		pillowmod.spiceadded = true
	end 

end -- end make it spicy

HospitalChallenge.OnNewGame = function()
--moved this stuff from onGameStart. 
		--check if it's a new game
		local pl = getPlayer();
		pillowmod = pl:getModData();
		--check if it's a new game
		print(pl:getHoursSurvived());
		if pillowmod.startconditionsset == nil
			and getPlayer():getHoursSurvived()<=1 then
			HospitalChallenge.DifficultyCheck();
			local inv = pl:getInventory();

			--remove all clothes and give player a hospital gown
			pl:clearWornItems();

			local itemsToRemove = {}
			local items = inv:getItems()
			for i=0, items:size()-1 do
				local item = items:get(i)
				local type = item:getFullType()
				if type ~= "Base.Key1" and not item:IsMap() and type ~= "Base.IDcard" and type ~= "Base.IDcard_Female" and type ~= "Base.IDcard_Male" and type ~= "Base.IDcard_Stolen" then
					table.insert(itemsToRemove, item)
				end
			end
			for _, item in ipairs(itemsToRemove) do
				inv:Remove(item)
			end

			clothes = inv:AddItem("Base.HospitalGown");
			-- inv:AddItem("Base.KeyRing");
			pl:setWornItem(clothes:getBodyLocation(), clothes);

			--set stats 
			pl:getStats():set(CharacterStat.INTOXICATION, 50+pillowmod.drunkmodifier);
			pl:getStats():set(CharacterStat.THIRST, 0.25);
			pl:getStats():set(CharacterStat.HUNGER, 0.25);
			pl:getStats():set(CharacterStat.FATIGUE, 0.25); -- from 0 to 1

			HospitalChallenge.ApplyInjuries();
			if pillowmod.brutalstart then
				HospitalChallenge.MakeItSpicy();
			else end 
			pillowmod.startconditionsset = true;

		else 
		end 
end

HospitalChallenge.OnCreatePlayer = function()

end

HospitalChallenge.OnInitWorld = function()
	
	Events.OnGameStart.Add(HospitalChallenge.setSandBoxVars);

	Events.OnGameStart.Add(HospitalChallenge.OnGameStart);

end

HospitalChallenge.setSandBoxVars = function()

end


HospitalChallenge.RemovePlayer = function(p)

end

HospitalChallenge.AddPlayer = function(p)

end

HospitalChallenge.Render = function()

--~ 	getTextManager():DrawStringRight(UIFont.Small, getCore():getOffscreenWidth() - 20, 20, "Zombies left : " .. (EightMonthsLater.zombiesSpawned - EightMonthsLater.deadZombie), 1, 1, 1, 0.8);

--~ 	getTextManager():DrawStringRight(UIFont.Small, (getCore():getOffscreenWidth()*0.9), 40, "Next wave : " .. tonumber(((60*60) - EightMonthsLater.waveTime)), 1, 1, 1, 0.8);
end

HospitalChallenge.spawns = {
	{worldX = 36, worldY = 33, posX = 63, posY = 145, posZ = 0}, --  Muldraugh, cortman medical, exam room 1
	{worldX = 36, worldY = 33, posX = 62, posY = 141, posZ = 0}, --  Muldraugh, cortman medical, exam room 2
	{worldX = 5, worldY = 19, posX = 225, posY = 48, posZ = 0}, -- Brandenburg,  medical center, exam room 1
	{worldX = 5, worldY = 19, posX = 225, posY = 44, posZ = 0}, -- Brandenburg,  medical center, exam room 2
	{worldX = 6, worldY = 19, posX = 276, posY = 202, posZ = 0}, -- Brandenburg,  dentist office, exam room
	{worldX = 1, worldY = 32, posX = 127, posY = 192, posZ = 0}, -- Ekron,  medical center, exam room 1
	{worldX = 1, worldY = 32, posX = 133, posY = 191, posZ = 0}, -- Ekron,  medical center, exam room 2
	{worldX = 7, worldY = 47, posX = 129, posY = 253, posZ = 0}, -- Irvington,  school, nurse office
	{worldX = 39, worldY = 23, posX = 167, posY = 16, posZ = 0}, --  West Point, dr office, exam room
	{worldX = 39, worldY = 22, posX = 186, posY = 284, posZ = 0}, --  West Point, dentist office, exam room 1
	{worldX = 39, worldY = 22, posX = 178, posY = 283, posZ = 0}, --  West Point, dentist office, exam room 2
	{worldX = 33, worldY = 42, posX = 264, posY = 151, posZ = 0}, -- March Ridge, dr office, exam room 1
	{worldX = 33, worldY = 42, posX = 269, posY = 158, posZ = 0}, -- March Ridge, dr office, exam room 2
	{worldX = 26, worldY = 38, posX = 284, posY = 125, posZ = 0}, -- Rosewood, Rosewood Medical, exam room 1
	{worldX = 26, worldY = 38, posX = 283, posY = 130, posZ = 0}, -- Rosewood, Rosewood Medical, exam room 2
	{worldX = 26, worldY = 38, posX = 292, posY = 121, posZ = 0}, -- Rosewood, Rosewood Medical, exam room 3
	{worldX = 24, worldY = 27, posX = 97, posY = 292, posZ = 0}, --  Fallas Lake, dr office, exam room
	{worldX = 21, worldY = 18, posX = 152, posY = 50, posZ = 0}, --  Riverside, school, nurse office
	{worldX = 18, worldY = 31, posX = 99, posY = 279, posZ = 0}, --   Doe Valley, dr office storage
	{worldX = 18, worldY = 31, posX = 103, posY = 280, posZ = 0} --  Doe Valley, dr office exam room
}

local spawnselection = ZombRand(6)+1;
local xcell = HospitalChallenge.spawns[spawnselection].worldX;
local ycell = HospitalChallenge.spawns[spawnselection].worldY;
local x = HospitalChallenge.spawns[spawnselection].posX;
local y = HospitalChallenge.spawns[spawnselection].posY;
local z = HospitalChallenge.spawns[spawnselection].posZ;

HospitalChallenge.id = "HospitalChallenge";
HospitalChallenge.image = "media/lua/client/LastStand/HospitalChallenge.png";
HospitalChallenge.gameMode = "HospitalChallenge";
HospitalChallenge.world = "Muldraugh, KY";
HospitalChallenge.xcell = xcell;
HospitalChallenge.ycell = ycell;
HospitalChallenge.x = x;
HospitalChallenge.y = y;
HospitalChallenge.z = z;
HospitalChallenge.enableSandbox = true;

Events.OnChallengeQuery.Add(HospitalChallenge.Add)

