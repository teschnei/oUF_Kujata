local addon, ns = ...
local cfg = ns.cfg
local lib = ns.lib

oUF.colors.health={0.4, 0.13, 0.63}
oUF.colors.power["MANA"] = {0.16, 0.41, 0.80}
oUF.colors.power["RAGE"] = {0.8, 0.21, 0.31}

  --the player style
local function CreatePlayerStyle(self)
    --style specific stuff
    print("hi")
    self.width = 250
    self.height = 25
    self.scale = 0.8
    self.mystyle = "player"
    lib.init(self)
    lib.moveme(self)
    lib.gen_hpbar(self)
    lib.gen_hpstrings(self)
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
    lib.init(self)
    lib.moveme(self)
    lib.gen_hpbar(self)
    lib.gen_hpstrings(self)
    lib.gen_ppbar(self)
	self.Health.colorHealth=true
    self.Health.colorTapping = true
    self.Health.colorDisconnected = true
    self.Health.bg.multiplier = 0.2
    self.Power.colorPower = true
    self.Power.bg.multiplier = 0.2
    lib.gen_castbar(self)
    --lib.createBuffs(self)
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
    lib.init(self)
    lib.moveme(self)
    lib.gen_hpbar(self)
    lib.gen_hpstrings(self)
    --lib.gen_ppbar(self)
    self.Health.colorTapping = true
    self.Health.colorDisconnected = true
    self.Health.colorHealth = true
    self.Health.bg.multiplier = 0.2
    --self.Power.colorPower = true
    --self.Power.bg.multiplier = 0.2
    --lib.createDebuffs(self)
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
    self.scale = 0.8
    self.mystyle = "party"
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
  --  lib.gen_portrait(self)
    lib.createDebuffs(self)
end  


  -----------------------------
  -- SPAWN UNITS
  -----------------------------


if cfg.showplayer then
    oUF:RegisterStyle("oUF_KujataPlayer", CreatePlayerStyle)
    oUF:SetActiveStyle("oUF_KujataPlayer")
    oUF:Spawn("player", "oUF_Kujata_PlayerFrame")  
end
  
if cfg.showtarget then
    oUF:RegisterStyle("oUF_KujataTarget", CreateTargetStyle)
    oUF:SetActiveStyle("oUF_KujataTarget")
    oUF:Spawn("target", "oUF_Kujata_TargetFrame")  
end


if cfg.showtot then
    oUF:RegisterStyle("oUF_KujataToT", CreateToTStyle)
    oUF:SetActiveStyle("oUF_KujataToT")
    oUF:Spawn("targettarget", "oUF_Kujata_ToTFrame")  
end
  
 --[[ if cfg.showfocus then
    oUF:RegisterStyle("oUF_SimpleFocus", CreateFocusStyle)
    oUF:SetActiveStyle("oUF_SimpleFocus")
    oUF:Spawn("focus", "oUF_Simple_FocusFrame")  
  end]]
  
  --[[if cfg.showpet then
    oUF:RegisterStyle("oUF_SimplePet", CreatePetStyle)
    oUF:SetActiveStyle("oUF_SimplePet")
    oUF:Spawn("pet", "oUF_Simple_PetFrame")  
  end]]
  
if cfg.showparty then
    oUF:RegisterStyle("oUF_KujataParty", CreatePartyStyle)
    oUF:SetActiveStyle("oUF_KujataParty")


   local party = oUF:SpawnHeader("oUF_Party", nil, "raid,party,solo", "showParty", true, "showPlayer", true, "yOffset", -50)
   party:SetPoint("TOPLEFT", 70, -20)
end