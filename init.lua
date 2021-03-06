
if minetest.get_mapgen_setting('mg_name') == "singlenode" then
	local mg = {
		nodes = {
			grass = minetest.get_content_id("kl_nodes:dirt_with_grass"),
			dirt = minetest.get_content_id("kl_nodes:dirt")
		},
		size = 256,
		depth = 20,
	}

	local data = {}

	minetest.register_on_generated(function(minp, maxp, blockseed)
		local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
		local area = VoxelArea:new{MinEdge = emin, MaxEdge = emax}
		vm:get_data(data)

		for z = 0, 79 do
			for y = 0, 79 do
				for x = 0, 79 do
					local pos = {
						x = minp.x + x,
						y = minp.y + y,
						z = minp.z + z
					}

					local posi = area:index(pos.x, pos.y, pos.z)

					if (pos.x >= -mg.size and pos.x <= mg.size) and (pos.z >= -mg.size and pos.z <= mg.size) and (pos.y >= -mg.depth and pos.y <= 0) then
						if pos.y == 0 then
							data[posi] = mg.nodes.grass
						else
							data[posi] = mg.nodes.dirt
						end
					end
				end
			end
		end

		vm:set_data(data)
		vm:write_to_map()
	end)
end
