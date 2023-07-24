data modify storage catenary:calc used_item set from entity @s SelectedItem
execute unless data storage catenary:calc used_item.tag.catenary.pos1 run function catenary:rocket/internal/anchor/get_pos1
execute if data storage catenary:calc used_item.tag.catenary.pos1 run function catenary:rocket/internal/anchor/get_pos2