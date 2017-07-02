for name, spill in pairs(data.raw["simple-entity"]) do
	log(serpent.block(name))
	if string.find(name, "chemical-spill") then
		spill.collision_mask = {}
		log(serpent.block("--FOUND"))
	end
end