-- Position and size
local Health = CreateFrame("StatusBar", nil, self)
Health:SetHeight(20)
Health:SetPoint('TOP')
Health:SetPoint('LEFT')
Health:SetPoint('RIGHT')

-- Add a background
local Background = Health:CreateTexture(nil, 'BACKGROUND')
Background:SetAllPoints(Health)
Background:SetTexture(1, 1, 1, .5)

-- Options
Health.frequentUpdates = true
Health.colorTapping = true
Health.colorDisconnected = true
Health.colorHappiness = true
Health.colorClass = true
Health.colorReaction = true
Health.colorHealth = true

-- Make the background darker.
Background.multiplier = .5

-- Register it with oUF
self.Health = Health
self.Health.bg = Background