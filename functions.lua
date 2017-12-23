function increaseStackSize(name, amt)
	local item = data.raw.item[name]
	if not item then
		item = data.raw.tool[name]
	end
	item.stack_size = math.max(item.stack_size, amt)
end