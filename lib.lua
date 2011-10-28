local addon, ns = ...
local cfg = ns.cfg
local lib = CreateFrame("Frame")  
    
local backdrop_tab = { 
    bgFile = cfg.backdrop_texture, 
    edgeFile = cfg.backdrop_edge_texture,
    tile = false,
    tileSize = 0, 
    edgeSize = 5, 
    insets = { 
		left = 5, 
		right = 5, 
		top = 5, 
		bottom = 5,
    },
}

lib.gen_backdrop = function(f)
    f:SetBackdrop(backdrop_tab);
    f:SetBackdropColor(0,0,0,0.7)
    f:SetBackdropBorderColor(0,0,0,1)
end
  
lib.menu = function(self)
    local unit = self.unit:sub(1, -2)
    local cunit = self.unit:gsub("(.)", string.upper, 1)
    if(unit == "party" or unit == "partypet") then
        ToggleDropDownMenu(1, nil, _G["PartyMemberFrame"..self.id.."DropDown"], "cursor", 0, 0)
    elseif(_G[cunit.."FrameDropDown"]) then
        ToggleDropDownMenu(1, nil, _G[cunit.."FrameDropDown"], "cursor", 0, 0)
    end
end

lib.moveme = function(f)
    f:SetMovable(true)
    f:SetUserPlaced(true)
	f:EnableMouse(true)
	f:RegisterForDrag("LeftButton","RightButton")
	f:SetScript("OnDragStart",function(self) self:StartMoving() end)
	f:SetScript("OnDragStop",function(self) self:StopMovingOrSizing() end)
end

lib.gen_fontstring = function(f, name, size, outline)
    local fs = f:CreateFontString(nil, "OVERLAY")
    fs:SetFont(name, size, outline)
    fs:SetShadowColor(0,0,0,1)
    return fs
end  

local dropdown=CreateFrame("Frame", addon.."DropDown",UIParent,"UIDropDownMenuTemplate")
UIDropDownMenu_Initialize(dropdown,function(self)
	local unit=self:GetParent().unit
	if not unit then return end
	local menu, name, id
	if UnitIsUnit(unit, "player") then
		menu="SELF"
	elseif UnitIsUnit(unit,"vehicle") then
		menu="VEHICLE"
	elseif UnitIsPlayer(unit) then
		id=UnitInRaid(unit)
		if id then
			menu = "RAID_PLAYER"
			name = GetRaidRosterInfo(id)
		elseif UnitInParty(unit) then
			menu = "PARTY"
		else
			menu = "PLAYER"
		end
	else
		menu = "TARGET"
		name = RAID_TARGET_ICON
	end
	if menu then
		UnitPopup_ShowMenu(self,menu,unit,name,id)
	end
end, "MENU")
	
lib.menu = function(self)
	dropdown:SetParent(self)
	ToggleDropDownMenu(1,nil,dropdown,"cursor",0,0)
end
  
do
	for k,v in pairs(UnitPopupMenus) do
		for x,y in pairs(UnitPopupMenus[k]) do
			if y=="SET_FOCUS" then
				table.remove(UnitPopupMenus[k],x)
			elseif y=="CLEAR_FOCUS" then
				table.remove(UnitPopupMenus[k],x)
			end
		end
	end
end

lib.gen_hpbar = function(f)
    local s = CreateFrame("StatusBar", nil, f)
    s:SetStatusBarTexture(cfg.statusbar_texture)
    s:SetHeight(f.height)
    s:SetWidth(f.width)
	--s:SetFrameLevel(0)
    s:SetPoint("CENTER",0,0)
	
    local h = CreateFrame("Frame", nil, s)
    h:SetFrameLevel(0)
    h:SetPoint("TOPLEFT",-5,5)
    h:SetPoint("BOTTOMRIGHT",5,-5)
    lib.gen_backdrop(h)

    local b = s:CreateTexture(nil, "BACKGROUND")
    b:SetTexture(cfg.statusbar_texture)
    b:SetAllPoints(s)
    f.Health = s
    f.Health.bg = b
end

lib.gen_hpstrings = function(f)
	local name, hpval
	if not f.hidename then
		name=lib.gen_fontstring(f.Health, cfg.font, 13, "THINOUTLINE")
		name:SetPoint("LEFT", f.Health, "LEFT", 2, 0)
		name:SetJustifyH("LEFT")
	end
    
	hpval = lib.gen_fontstring(f.Health, cfg.font, 13, "THINOUTLINE")
    hpval:SetPoint("RIGHT", f.Health, "RIGHT", -2, 0)
	if f.hidename then
		hpval:SetJustifyH("CENTER")
		hpval:SetPoint("LEFT",f.Health,"LEFT",2,0)
	else
		name:SetPoint("RIGHT", hpval, "LEFT", -5, 0)
    
		if f.nametag then
			f:Tag(name, f.nametag)
		else
			f:Tag(name, "[name]")
		end
	end
	if f.hptag then
		f:Tag(hpval,f.hptag)
	else
		f:Tag(hpval,"[ku:default]")
	end
end
  
lib.gen_ppbar = function(f)
    local s = CreateFrame("StatusBar", nil, f)
    s:SetStatusBarTexture(cfg.statusbar_texture)
    s:SetHeight(f.height/5)
    s:SetWidth(f.width)
    s:SetPoint("TOP",f,"BOTTOM",0,-3)

    local h = CreateFrame("Frame", nil, s)
    h:SetFrameLevel(0)
    h:SetPoint("TOPLEFT",-5,5)
    h:SetPoint("BOTTOMRIGHT",5,-5)
    lib.gen_backdrop(h)

    local b = s:CreateTexture(nil, "BACKGROUND")
    b:SetTexture(cfg.statusbar_texture)
    b:SetAllPoints(s)
    f.Power = s
    f.Power.bg = b
end
  

lib.gen_castbar = function(f)
    --statusbar
    local s = CreateFrame("StatusBar", nil, f)
    s:SetStatusBarTexture(cfg.statusbar_texture)
	s:SetStatusBarColor(1,0.8,0,1)
    s:SetHeight(f.height)
    s:SetWidth(f.width)
    s:SetPoint("CENTER",0,0)
    --helper
    local h = CreateFrame("Frame", nil, s)
    h:SetFrameLevel(0)
    h:SetPoint("TOPLEFT",-5,5)
    h:SetPoint("BOTTOMRIGHT",5,-5)
    --lib.gen_backdrop(h)
    --bg
    --[[local b = s:CreateTexture(nil, "BACKGROUND")
    b:SetTexture(cfg.statusbar_texture)
    b:SetAllPoints(s)]]
    f.Castbar = s
    --f.Castbar.bg = b
end
--[[lib.gen_castbar = function(f)
    local s = CreateFrame("StatusBar", "oUF_SimpleCastbar"..f.mystyle, f)
    s:SetHeight(f.height)
    s:SetWidth(f.width)
    if f.mystyle == "player" then
        lib.moveme(s)
        s:SetPoint("CENTER",UIParent,0,-50)
    elseif f.mystyle == "target" then
        lib.moveme(s)
        s:SetPoint("CENTER",UIParent,0,0)
    else
        s:SetPoint("BOTTOM",f,"TOP",0,5)
    end
    s:SetStatusBarTexture(cfg.statusbar_texture)
    s:SetStatusBarColor(1,0.8,0,1)
    --helper
    local h = CreateFrame("Frame", nil, s)
    h:SetFrameLevel(0)
    h:SetPoint("TOPLEFT",-5,5)
    h:SetPoint("BOTTOMRIGHT",5,-5)
    lib.gen_backdrop(h)
    
    local b = s:CreateTexture(nil, "BACKGROUND")
    b:SetTexture(cfg.statusbar_texture)
    b:SetAllPoints(s)
    b:SetVertexColor(1*0.3,0.8*0.3,0,0.7)  
    
    local txt = lib.gen_fontstring(s, cfg.font, 13, "THINOUTLINE")
    txt:SetPoint("LEFT", 2, 0)
    txt:SetJustifyH("LEFT")
    --time
    local t = lib.gen_fontstring(s, cfg.font, 13, "THINOUTLINE")
    t:SetPoint("RIGHT", -2, 0)
    txt:SetPoint("RIGHT", t, "LEFT", -5, 0)
    
    --icon
    local i = s:CreateTexture(nil, "ARTWORK")
    i:SetWidth(f.height)
    i:SetHeight(f.height)
    i:SetPoint("RIGHT", s, "LEFT", -5, 0)
    i:SetTexCoord(0.1, 0.9, 0.1, 0.9)
    
    --helper2 for icon
    local h2 = CreateFrame("Frame", nil, s)
    h2:SetFrameLevel(0)
    h2:SetPoint("TOPLEFT",i,"TOPLEFT",-5,5)
    h2:SetPoint("BOTTOMRIGHT",i,"BOTTOMRIGHT",5,-5)
    lib.gen_backdrop(h2)
    
    if f.mystyle == "player" then
        --latency only for player unit
        local z = s:CreateTexture(nil,"OVERLAY")
        z:SetTexture(cfg.statusbar_texture)
        z:SetVertexColor(0.6,0,0,0.6)
        z:SetPoint("TOPRIGHT")
        z:SetPoint("BOTTOMRIGHT")
        s.SafeZone = z
    end
    
    f.Castbar = s
    f.Castbar.Text = txt
    f.Castbar.Time = t
    f.Castbar.Icon = i
end
  ]]

lib.PostCreateIcon = function(self, button)
    button.cd:SetReverse()
    button.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
    button.icon:SetDrawLayer("BACKGROUND")
    --count
    button.count:ClearAllPoints()
    button.count:SetJustifyH("RIGHT")
    button.count:SetPoint("TOPRIGHT", 2, 2)
    button.count:SetTextColor(0.7,0.7,0.7)
    --helper
    local h = CreateFrame("Frame", nil, button)
    h:SetFrameLevel(0)
    h:SetPoint("TOPLEFT",-5,5)
    h:SetPoint("BOTTOMRIGHT",5,-5)
    lib.gen_backdrop(h)
end
  
lib.createBuffs = function(f)
    b = CreateFrame("Frame", nil, f)
    b.size = 20
    if f.mystyle == "target" then
        b.num = 40
    elseif f.mystyle == "player" then
        b.num = 10
        b.onlyShowPlayer = true
    else
        b.num = 5
    end
    b.spacing = 5
    b.onlyShowPlayer = false
    b:SetHeight((b.size+b.spacing)*4)
    b:SetWidth(f.width)
    b:SetPoint("BOTTOMLEFT", f, "TOPLEFT", 0, 5)
    b.initialAnchor = "BOTTOMLEFT"
    b["growth-x"] = "RIGHT"
    b["growth-y"] = "UP"
    b.PostCreateIcon = lib.PostCreateIcon
    f.Buffs = b
end


lib.createDebuffs = function(f)
    b = CreateFrame("Frame", nil, f)
    b.size = 20
    if f.mystyle == "target" then
      b.num = 40
    elseif f.mystyle == "player" then
      b.num = 10
    else
      b.num = 5
    end
    b.spacing = 5
    b.onlyShowPlayer = false
    b:SetHeight((b.size+b.spacing)*4)
    b:SetWidth(f.width)
    b:SetPoint("TOPLEFT", f.Power, "BOTTOMLEFT", 0, -5)
    b.initialAnchor = "TOPLEFT"
    b["growth-x"] = "RIGHT"
    b["growth-y"] = "DOWN"
    b.PostCreateIcon = lib.PostCreateIcon
    f.Debuffs = b
end

  ns.lib = lib