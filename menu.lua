-------------------------------------------
-- Namespaces
-------------------------------------------
local _, core = ...;
core.Menu = {};

local Menu = core.Menu;
--local UIMenu;

--------------------------------------
-- Defaults (usually a database!)
--------------------------------------
local defaults = {
	theme = {
		r = 0, 
		g = 0.8, -- 204/255
		b = 1,
		hex = "00ccff"
	}
}

-------------------------------------------
-- Menu functions
-------------------------------------------
function Menu:Toggle()
    local m = UIMenu or Menu:CreateMenu();
    m:SetShown(not m:IsShown());
end

function Menu:GetThemeColor()
	local c = defaults.theme;
	return c.r, c.g, c.b, c.hex;
end

function Menu:CreateButton( point, relativeFrame, relativePoint, yOffset, text)
    local btn = CreateFrame("Button", nil, UIMenu, "GameMenuButtonTemplate");
    btn:SetPoint(point, relativeFrame,relativePoint,0,yOffset);
    btn:SetSize(80,35);
    btn:SetText(text);
    btn:SetNormalFontObject("GameFontNormal");
    btn:SetHighlightFontObject("GameFontHighlight");
    return btn;
end

function Menu:SetResult()
    if (UIMenu ~= nil) then
        local r = core.Roller:GetRollAmount(lastRoll);
        UIMenu.result:SetText(r);
    end
end

function Menu:CreateMenu()
    UIMenu = CreateFrame("Frame", "DeathrollersFrame", UIParent, "BasicFrameTemplateWithInset");
    UIMenu:SetSize(150, 230);
    UIMenu:SetPoint("CENTER");
    UIMenu:SetMovable(true);
    UIMenu:EnableMouse(true);
    UIMenu:RegisterForDrag("LeftButton");
    UIMenu:SetScript("OnDragStart", UIMenu.StartMoving);
    UIMenu:SetScript("OnDragStop", UIMenu.StopMovingOrSizing);

    -- Title
    UIMenu.title = UIMenu:CreateFontString(nill, "OVERLAY", "GameFontHighlight");
    UIMenu.title:SetPoint("LEFT", UIMenu.TitleBg, "LEFT", 5, 0);
    UIMenu.title:SetText("Deathrollers");

    -- Edit box
    UIMenu.amountEb = CreateFrame("EditBox",nil,UIMenu,"InputBoxTemplate");
    UIMenu.amountEb:SetWidth(80);
    UIMenu.amountEb:SetHeight(24);
    UIMenu.amountEb:SetFontObject(GameFontNormal);
    UIMenu.amountEb:SetPoint("CENTER", UIMenu, "TOP", 0, -50);
    UIMenu.amountEb:ClearFocus(self);
    UIMenu.amountEb:SetAutoFocus(false);
    UIMenu.amountEb:Insert("9999");

    -- Buttons
    UIMenu.startBtn = self:CreateButton("CENTER", UIMenu.amountEb, "TOP", -50, "Start")
    UIMenu.startBtn:SetScript("OnClick",function()
        local amount = tonumber(UIMenu.amountEb:GetText():lower());
        if (amount ~= nil) then
            RandomRoll(1, amount);
        else
            print("You can only roll numbers!");
        end
    end)

    UIMenu.rollBtn = self:CreateButton("TOP", UIMenu.startBtn, "BOTTOM", -10, "Roll")
    UIMenu.rollBtn:SetScript("OnClick",function()
        core.Roller.Roll();
        --print(lastRoll);
    end)

    -- Result label text
    UIMenu.resultLbl = UIMenu:CreateFontString(nill, "OVERLAY");
    UIMenu.resultLbl:SetFontObject("GameFontNormal");
    UIMenu.resultLbl:SetPoint("CENTER", UIMenu.rollBtn, "TOP", 0, -60);
    UIMenu.resultLbl:SetText("Result:");

    -- Result text
    UIMenu.result = UIMenu:CreateFontString(nill, "OVERLAY");
    UIMenu.result:SetFontObject("NumberFontNormalYellow");
    UIMenu.result:SetPoint("CENTER", UIMenu.resultLbl, "TOP", 0, -30);
    UIMenu.result:SetText("0");

    UIMenu:Hide();
    return UIMenu;
end