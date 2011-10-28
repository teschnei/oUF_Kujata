local addon, ns = ...
local cfg = CreateFrame("Frame")

--config variables
cfg.showplayer = true
cfg.showtarget = true
cfg.showtot = true
--cfg.showpet = true
--cfg.showfocus = true
cfg.showparty = true
cfg.showraid=true
cfg.allow_frame_movement = true
cfg.frames_locked = false 
  
cfg.statusbar_texture = "Interface\\AddOns\\oUF_Kujata\\media\\statusbar"
cfg.backdrop_texture = "Interface\\AddOns\\oUF_Kujata\\media\\backdrop"
cfg.backdrop_edge_texture = "Interface\\AddOns\\oUF_Kujata\\media\\backdrop_edge"
cfg.font = "FONTS\\FRIZQT__.ttf"   
  
ns.cfg = cfg