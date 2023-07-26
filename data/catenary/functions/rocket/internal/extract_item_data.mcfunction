data modify storage catenary:calc spawn.pos1 set from storage catenary:calc spawn.item_tag.catenary.pos1
data modify storage catenary:calc spawn.sag set from storage catenary:calc spawn.item_tag.catenary.sag
data modify storage catenary:calc spawn.rope set from storage catenary:calc spawn.item_tag.catenary.rope
data modify storage catenary:calc spawn.decorations set from storage catenary:calc spawn.item_tag.catenary.decorations
data remove storage catenary:calc spawn.item_tag.catenary.pos1
data remove storage catenary:calc spawn.item_tag.catenary.bound
data remove storage catenary:calc spawn.item_tag.Enchantments

function catenary:catenary/api/spawn
execute if data storage catenary:calc spawn{error:"points_too_close"} run tellraw @s {"text":"These points are too close.","color":"red"}
execute if data storage catenary:calc spawn{error:"points_too_far"} run tellraw @s {"text":"These points are too far.","color":"red"}