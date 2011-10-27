local addon, ns = ...
local cfg = ns.cfg
local lib = ns.lib

oUF.colors.health={0.4, 0.13, 0.63}
oUF.colors.power["MANA"] = {0.16, 0.41, 0.80}
oUF.colors.power["RAGE"] = {0.8, 0.21, 0.31}

local initHeader = function(self)
	self.menu=lib.menu
	self:RegisterForClicks("AnyUp")
	self:SetAttribute("*type2", "menu")
	self:SetScript("OnEnter", UnitFrame_OnEnter)
	self:SetScript("OnLeave", UnitFrame_OnLeave)
	lib.gen_hpbar(self)
	lib.gen_hpstrings(self)
	--if self.mystyle=="player" or "target" then

	--end
end

local init=function(self)
	self:SetSize(self.width, self.height)
--	self:SetPoint("CENTER",UIParent,"CENTER",0,0)
	initHeader(self)
end
  --the player style
local function CreatePlayerStyle(self)
    self.width = 250
    self.height = 25
    self.scale = 0.8
    self.mystyle = "player"
	self.hptag=""
	self:SetPoint("CENTER",UIParent,"CENTER",-500,0)
    init(self)
	lib.gen_ppbar(self)
    self.Health.colorHealth = true
    self.Health.bg.multiplier = 0.2
    self.Power.colorPower = true
    self.Power.bg.multiplier = 0.2
    lib.gen_castbar(self)
end  
  
  --the target style
local function CreateTargetStyle(self)
    --style specific stuff
    self.width = 250
    self.height = 25
    self.scale = 0.8
    self.mystyle = "target"
	self:SetPoint("CENTER",UIParent,"CENTER",500,0)
    init(self)
	lib.gen_ppbar(self)
	self.Health.colorHealth=true
    self.Health.colorTapping = true
    self.Health.colorDisconnected = true
    self.Health.bg.multiplier = 0.2
    self.Power.colorPower = true
    self.Power.bg.multiplier = 0.2
    lib.gen_castbar(self)
    lib.createDebuffs(self)
	if(IsAddOnLoaded'oUF_BuffFilter') then
		self.Debuffs.CustomFilter=oUF_BuffFilter_Debuffs
	end
end  
  
  --the tot style
local function CreateToTStyle(self)
    --style specific stuff
    self.width = 150
    self.height = 25
    self.scale = 0.8
    self.mystyle = "tot"
	self:SetPoint("CENTER",UIParent,"CENTER",300,100)
    init(self)
    self.Health.colorTapping = true
    self.Health.colorDisconnected = true
    self.Health.colorHealth = true
    self.Health.bg.multiplier = 0.2
end 
  
  --the focus style
 --[[ local function CreateFocusStyle(self)
    --style specific stuff
    self.width = 180
    self.height = 25
    self.scale = 0.8
    self.mystyle = "focus"
    lib.init(self)
    lib.moveme(self)
    lib.gen_hpbar(self)
    lib.gen_hpstrings(self)
    lib.gen_ppbar(self)
    self.Health.colorDisconnected = true
    self.Health.colorClass = true
    self.Health.colorReaction = true
    self.Health.colorHealth = true
    self.Health.bg.multiplier = 0.3
    self.Power.colorPower = true
    self.Power.bg.multiplier = 0.3
    lib.gen_castbar(self)
    lib.gen_portrait(self)
    lib.createDebuffs(self)
  end  ]]
  
  --the pet style
 --[[ local function CreatePetStyle(self)
    --style specific stuff
    self.width = 180
    self.height = 25
    self.scale = 0.8
    self.mystyle = "pet"
    lib.init(self)
    lib.moveme(self)
    lib.gen_hpbar(self)
    lib.gen_hpstrings(self)
    lib.gen_ppbar(self)
    self.Health.colorDisconnected = true
    self.Health.colorClass = true
    self.Health.colorReaction = true
    self.Health.colorHealth = true
    self.Health.bg.multiplier = 0.3
    self.Power.colorPower = true
    self.Power.bg.multiplier = 0.3
    lib.gen_castbar(self)
    lib.gen_portrait(self)
    lib.createDebuffs(self)
  end  ]]


  --the party style
local function CreatePartyStyle(self)
    --style specific stuff
    self.width = 180
    self.height = 25
    self.mystyle = "party"
	self.hptag="[missinghp]"
	lib.gen_ppbar(self)
	initHeader(self)
    self.Health.colorDisconnected = true
    self.Health.colorHealth = true
    self.Health.bg.multiplier = 0.3
    self.Power.colorPower = true
    self.Power.bg.multiplier = 0.3
end  


local function CreateRaidStyle(self)
	self.width=85
	self.height=25
	self.mystyle="raid"
	self.hptag="[missinghp]"
	lib.gen_ppbar(self)
	initHeader(self)
	self.Health.colorDisconnected=true
	self.Health.colorHealth=true
	self.Health.bg.multiplier = 0.3
    self.Power.colorPower = true
    self.Power.bg.multiplier = 0.3
end


  -----------------------------
  -- SPAWN UNITS
  -----------------------------


if cfg.showplayer then
    oUF:RegisterStyle("oUF_KujataPlayer", CreatePlayerStyle)
    oUF:SetActiveStyle("oUF_KujataPlayer")
    oUF:Spawn("player")  
end
  
if cfg.showtarget then
    oUF:RegisterStyle("oUF_KujataTarget", CreateTargetStyle)
    oUF:SetActiveStyle("oUF_KujataTarget")
    oUF:Spawn("target")  
end


if cfg.showtot then
    oUF:RegisterStyle("oUF_KujataToT", CreateToTStyle)
    oUF:SetActiveStyle("oUF_KujataToT")
    oUF:Spawn("targettarget")  
end
  
 --[[ if cfg.showfocus then
    oUF:RegisterStyle("oUF_SimpleFocus", CreateFocusStyle)
    oUF:SetActiveStyle("oUF_SimpleFocus")
    oUF:Spawn("focus")  
  end]]
  
  --[[if cfg.showpet then
    oUF:RegisterStyle("oUF_SimplePet", CreatePetStyle)
    oUF:SetActiveStyle("oUF_SimplePet")
    oUF:Spawn("pet")  
  end]]
  
if cfg.showparty then
    oUF:RegisterStyle("oUF_KujataParty", CreatePartyStyle)
    oUF:SetActiveStyle("oUF_KujataParty")


   local party = oUF:SpawnHeader(
		nil,
		nil,
		"custom [@raid1,exists] hide; [group:party,nogroup:raid] show; hide",
		"showPlayer",	true,
		"showSolo",		false,
		"showParty",	true,
		"showRaid",		false,
		"point",		"RIGHT",
		"yOffset",		0,
		"xOffset",		-5,
			"oUF-initialConfigFunction", [[
				self:SetHeight(25)
				self:SetWidth(85)
			]]
	)
	party:SetPoint("CENTER",UIParent,"CENTER",830,-485)
end

if cfg.showraid then
	CompactRaidFrameManager:UnregisterAllEvents()
	CompactRaidFrameManager.Show=CompactRaidFrameManager.Hide
	CompactRaidFrameManager:Hide()
	CompactRaidFrameContainer:UnregisterAllEvents()
	CompactRaidFrameContainer.Show=CompactRaidFrameContainer.Hide
	CompactRaidFrameContainer:Hide()
	
	--10
	oUF:RegisterStyle("oUF_KujataRaid10", CreateRaidStyle)
	oUF:SetActiveStyle("oUF_KujataRaid10")
	local raid10=oUF:SpawnHeader(
		"oUF_KujataRaid10",
		nil,
		"custom [@raid11,exists] hide; [@raid1,exists] show; hide",
		"showPlayer",			false,
		"showSolo",				false,
		"showParty",			false,
		"showRaid",				true,
		"point",				"RIGHT",
		"yOffset",				0,
		"xOffset",				-5,
		"columnSpacing",		17,
		"columnAnchorPoint",	"BOTTOM",
		"groupFilter",			"1,2,3,4,5,6,7,8",
		"groupBy",				"GROUP",
		"GroupingOrder",		"1,2,3,4,5,6,7,8",
		"sortMethod",			"NAME",
		"maxColumns",			8,
		"unitsPerColumn",		5,
			"oUF-initialConfigFunction", [[
				self:SetHeight(25)
				self:SetWidth(85)
			]]
	)
	raid10:SetPoint("CENTER",UIParent,"CENTER",830,-485)
	
	--25
	oUF:RegisterStyle("oUF_KujataRaid25", CreateRaidStyle)
	oUF:SetActiveStyle("oUF_KujataRaid25")
	local raid25=oUF:SpawnHeader(
		"oUF_KujataRaid25",
		nil,
		"custom [@raid26,exists] hide; [@raid11,exists] show; hide",
		"showPlayer",			false,
		"showSolo",				false,
		"showParty",			false,
		"showRaid",				true,
		"point",				"LEFT",
		"yOffset",				0,
		"xOffset",				10,
		"columnSpacing",		17,
		"columnAnchorPoint",	"TOP",
		"groupFilter",			"1,2,3,4,5,6,7,8",
		"groupBy",				"GROUP",
		"GroupingOrder",		"1,2,3,4,5,6,7,8",
		"sortMethod",			"NAME",
		"maxColumns",			8,
		"unitsPerColumn",		5,
			"oUF-initialConfigFunction", [[
				self:SetHeight(25)
				self:SetWidth(100)
			]]
	)
	raid25:SetPoint("CENTER",UIParent,"CENTER",830,-485)
	
	--40
	oUF:RegisterStyle("oUF_KujataRaid40", CreateRaidStyle)
	oUF:SetActiveStyle("oUF_KujataRaid40")
	local raid40=oUF:SpawnHeader(
		"oUF_KujataRaid40",
		nil,
		"custom [@raid26,exists] show; hide",
		"showPlayer",			false,
		"showSolo",				false,
		"showParty",			false,
		"showRaid",				true,
		"point",				"LEFT",
		"yOffset",				0,
		"xOffset",				10,
		"columnSpacing",		17,
		"columnAnchorPoint",	"TOP",
		"groupFilter",			"1,2,3,4,5,6,7,8",
		"groupBy",				"GROUP",
		"GroupingOrder",		"1,2,3,4,5,6,7,8",
		"sortMethod",			"NAME",
		"maxColumns",			8,
		"unitsPerColumn",		5,
			"oUF-initialConfigFunction", [[
				self:SetHeight(25)
				self:SetWidth(100)
			]]
	)
	raid40:SetPoint("CENTER",UIParent,"CENTER",830,-485)
end
	