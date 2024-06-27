data modify storage catenary:calc FireworksItem set from entity @s SelectedItem
execute unless data storage catenary:calc FireworksItem.components.minecraft:custom_data.catenary.pos1 run return run function catenary:rocket/internal/anchor/get_pos1
function catenary:rocket/internal/anchor/get_pos2