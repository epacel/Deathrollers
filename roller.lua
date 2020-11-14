-------------------------------------------
-- Namespaces
-------------------------------------------
local _, core = ...;
core.Roller = {};

local Roller = core.Roller;

local lastRoll = "";

function splitString (inputstr, sep) --splits the given string: table value = index, key = string
	if sep == nil then
		sep = "%s"
	end
	local t={}
	local c = 0
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		t[c] = str
		c =  c + 1
	end
	return t
end

function isRoll (inputstr) --checks if the string given is from a roll
	local splitStr = splitString(inputstr)
	local r = table.getn(splitStr) - 2
	local findRoll = splitStr[r]
	if findRoll == "rolls" then
		return true
	else
		return false
	end
end

function Roller:QuickRoll()
	RandomRoll(1,9999);
end

-- main --

local lastRoll = ""

-- check for system messages and if roll store result
local frame=CreateFrame("Frame")
frame:RegisterEvent("CHAT_MSG_SYSTEM")
frame:SetScript("OnEvent",function(self,event,msg)
	if event=="CHAT_MSG_SYSTEM" then
		if isRoll (msg) == true then
			lastRoll = msg
		end
	end
end)

function Roller:Roll()
	if (lastRoll ~= "") then
		local r = splitString(lastRoll)
		local rollHighK = table.getn(r) - 1
		local rollHighV = r[rollHighK]
		--print(tonumber(rollHighV))
		RandomRoll(1, tonumber(rollHighV))
	else
		core:Print("There's nothing to roll against");
	end
end