local numFormat = function(n)
	if n>1E9 then
		return (floor((n/1E9)*10)/10).."b"
	elseif n>1E6 then
		return (floor((n/1E6)*10)/10).."m"
	elseif n>1E3 then
		return (floor((n/1E3)*10)/10).."k"
	else
		return n
	end
end

oUF.Tags["ku:missinghp"] = function(unit)
	if not UnitIsConnected(unit) then
		return "D/C"
	end
	if UnitIsDead(unit) then
		return "Dead"
	end
	if UnitIsGhost(unit) then
		return "Ghost"
	end
	local min, max = UnitHealth(unit), UnitHealthMax(unit)
	if min == max and max > 0 then
		return ""
	end
	return numFormat(max-min)
end
oUF.TagEvents["ku:missinghp"] =  "UNIT_HEALTH UNIT_MAXHEALTH UNIT_CONNECTION"

oUF.Tags["ku:default"] = function(unit)
	if not UnitIsConnected(unit) then
		return "D/C"
	end
	if UnitIsDead(unit) then
		return "Dead"
	end
	if UnitIsGhost(unit) then
		return "Ghost"
	end
	local min, max = UnitHealth(unit),UnitHealthMax(unit)
	local per = 0
	if max > 0 then
		per = floor(min/max*100)
	end
	local abs = numFormat(min)
	return abs.."/"..per.."%"
end
oUF.TagEvents["ku:default"]="UNIT_HEALTH UNIT_MAXHEALTH UNIT_CONNECTION"

oUF.Tags["ku:raid"] = function(unit)
	if not UnitIsConnected(unit) then
		return "D/C"
	end
	if UnitIsDead(unit) then
		return "Dead"
	end
	if UnitIsGhost(unit) then
		return "Ghost"
	end
	local min, max = UnitHealth(unit), UnitHealthMax(unit)
	if min == max and max > 0 then
		return UnitName(unit)
	end
	return "-"..numFormat(max-min)
end
oUF.TagEvents["ku:missinghp"] =  "UNIT_NAME_UPDATE UNIT_HEALTH UNIT_MAXHEALTH UNIT_CONNECTION"