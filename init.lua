local _, core = ...; -- Namespace

-------------------------------------------
-- Custom Slash Command
-------------------------------------------
core.commands = {
    ["menu"] = core.Menu.Toggle,

    ["help"] = function()
        print(" ");
        core:Print("List of slash commands:");
		core:Print("|cff00cc66/dr help|r - shows help info");
		core:Print("|cff00cc66/dr menu|r - shows deathrollers menu");
		core:Print("|cff00cc66/drm|r - also shows deathrollers menu");
		core:Print("|cff00cc66/qr |r - quick roll between 1 - 9999");
		core:Print("|cff00cc66/dr |r - quick deathroll from the last roll");
        print(" ");
    end,

    ["roll"] = core.Roller.Roll,
};

local function HandleSlashCommands(str)	
	if (#str == 0) then	
		-- User just entered "/dr" with no additional args.
		core.commands.roll();
		return;		
	end	
	
	local args = {};
	for _, arg in ipairs({ string.split(' ', str) }) do
		if (#arg > 0) then
			table.insert(args, arg);
		end
	end
	
	local path = core.commands; -- required for updating found table.
	
	for id, arg in ipairs(args) do
		if (#arg > 0) then -- if string length is greater than 0.
			arg = arg:lower();			
			if (path[arg]) then
				if (type(path[arg]) == "function") then				
					-- all remaining args passed to our function!
					path[arg](select(id + 1, unpack(args))); 
					return;					
				elseif (type(path[arg]) == "table") then				
					path = path[arg]; -- another sub-table found!
				end
			else
				-- does not exist!
				core.commands.help();
				return;
			end
		end
	end
end


function core:Print(...)
    local hex = select(4, self.Menu:GetThemeColor());
    local prefix = string.format("|cff%s%s|r", hex:upper(), "Deathrollers:");
    DEFAULT_CHAT_FRAME:AddMessage(string.join(" ", prefix, ...));
end

function core:init(event, name)
    if (name ~= "Deathrollers") then return end

    SLASH_RELOADUI1 = '/rl'; -- new slash command for reloading UI
    SlashCmdList.RELOADUI = ReloadUI;

    SLASH_FRAMESTK1 = "/fs"; -- new slash command for showing framestack tool
	SlashCmdList.FRAMESTK = function()
		LoadAddOn("Blizzard_DebugTools");
		FrameStackTooltip_Toggle();
	end

	SLASH_QUICKROLL1 = "/qr";
    SlashCmdList.QUICKROLL = core.Roller.QuickRoll;

    SLASH_DEATHROLLERS1 = "/dr";
	SlashCmdList.DEATHROLLERS = HandleSlashCommands;
	
	SLASH_MENU1 = "/drm";
	SlashCmdList.MENU = core.Menu.Toggle;

    core:Print("Ready to roll", UnitName("player").."!");
    core:Print("|cff00cc66/dr help|r - shows deathrollers help info");
end

local events = CreateFrame("Frame");
events:RegisterEvent("ADDON_LOADED");
events:SetScript("OnEvent", core.init);