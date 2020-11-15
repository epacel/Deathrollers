-------------------------------------------
-- Namespaces
-------------------------------------------
local _, core = ...;
core.Roller = {};

local Roller = core.Roller;

lastRoll = "";

function splitString (str, sep) --splits the given string: table value = index, key = string
	if sep == nil then
		sep = "%s"
	end
	local t={}
	local c = 0
	for s in string.gmatch(str, "([^"..sep.."]+)") do
		t[c] = s
		c =  c + 1
	end
	return t
end

function isRoll (str) --checks if the string given is from a roll
	local splitStr = splitString(str)
	local r = table.getn(splitStr) - 2
	local findRoll = splitStr[r]
	if findRoll == "rolls" then
		return true
	else
		return false
	end
end

function Roller:GetRollAmount(str)
	local r = splitString(str);
	local rollHighK = table.getn(r) - 1;
	local rollHighV = r[rollHighK];
	return rollHighV;
end

function Roller:QuickRoll()
	RandomRoll(1,9999);
end

-- main --
-- check for system messages and if roll store result
local frame=CreateFrame("Frame")
frame:RegisterEvent("CHAT_MSG_SYSTEM")
frame:SetScript("OnEvent",function(self,event,msg)
	if event=="CHAT_MSG_SYSTEM" then
		if isRoll (msg) == true then
			lastRoll = msg
			core.Menu.SetResult()
		end
	end
end)

function Roller:Roll()
	if (lastRoll ~= "") then
		local high = core.Roller:GetRollAmount(lastRoll);
		RandomRoll(1, tonumber(high))
	else
		core:Print("There's nothing to roll against");
	end
end