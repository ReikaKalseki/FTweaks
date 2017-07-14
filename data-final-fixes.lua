for name, spill in pairs(data.raw["simple-entity"]) do
	if string.find(name, "chemical-spill", 1, true) then
		spill.collision_mask = {}
	end
end