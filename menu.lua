-------------------------------------------
-- Namespaces
-------------------------------------------
local _, core = ...;
core.Menu = {};

local Menu = core.Menu;
local UIMenu;

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

function Menu:CreateMenu()
    UIMenu = CreateFrame("Frame", "DeathrollersFrame", UIParent, "BasicFrameTemplateWithInset");
    UIMenu:SetSize(200, 200);
    UIMenu:SetPoint("CENTER");

    -- Title
    UIMenu.title = UIMenu:CreateFontString(nill, "OVERLAY", "GameFontHighlight");
    UIMenu.title:SetPoint("LEFT", UIMenu.TitleBg, "LEFT", 5, 0);
    UIMenu.title:SetText("Deathrollers");

    -- Buttons
    UIMenu.startBtn = self:CreateButton("CENTER", UIMenu, "TOP", -60, "Start")

    UIMenu.rollBtn = self:CreateButton("TOP", UIMenu.startBtn, "BOTTOM", -10, "Roll")

    -- Result label text
    UIMenu.resultLbl = UIMenu:CreateFontString(nill, "OVERLAY");
    UIMenu.resultLbl:SetFontObject("GameFontNormal");
    UIMenu.resultLbl:SetPoint("CENTER", UIMenu, "TOP", 0, -140);
    UIMenu.resultLbl:SetText("Result:");

    -- Result text
    UIMenu.result = UIMenu:CreateFontString(nill, "OVERLAY");
    UIMenu.result:SetFontObject("NumberFontNormalYellow");
    UIMenu.result:SetPoint("CENTER", UIMenu, "TOP", 0, -160);
    UIMenu.result:SetText("0");

    UIMenu:Hide();
    return UIMenu;
end
