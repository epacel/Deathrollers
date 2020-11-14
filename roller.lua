
-- functions --

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

-- slash command to make roll
SLASH_ROLL1 = "/dr"
SlashCmdList["ROLL"] = function()
	--r[table.getn(r)-2]
	local r = splitString(lastRoll)
	local rollHighK = table.getn(r) - 1
	local rollHighV = r[rollHighK]
	print(tonumber(rollHighV))
	--message(r)
	RandomRoll(1, tonumber(rollHighV))
end