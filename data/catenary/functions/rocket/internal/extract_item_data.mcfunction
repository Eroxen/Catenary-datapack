data modify storage catenary:calc spawn.original_item_tag set from storage catenary:calc spawn.item_tag
data modify storage catenary:calc spawn.pos1 set from storage catenary:calc spawn.item_tag.catenary.pos1
data modify storage catenary:calc spawn.sag set from storage catenary:calc spawn.item_tag.catenary.sag
data modify storage catenary:calc spawn.rope set from storage catenary:calc spawn.item_tag.catenary.rope
data modify storage catenary:calc spawn.decorations set from storage catenary:calc spawn.item_tag.catenary.decorations
execute if data storage catenary:calc spawn.decorations{type:"custom_spelling"} run function catenary:rocket/internal/preprocess/custom_spelling
data remove storage catenary:calc spawn.item_tag.catenary.pos1
data remove storage catenary:calc spawn.item_tag.catenary.bound
data remove storage catenary:calc spawn.item_tag.Enchantments

function catenary:catenary/api/spawn
execute if data storage catenary:calc spawn{error:"points_too_close"} run tellraw @s {"text":"These points are too close.","color":"red"}
execute if data storage catenary:calc spawn{error:"points_too_far"} run tellraw @s {"text":"These points are too far.","color":"red"}
execute if data storage catenary:calc spawn.error run data modify storage catenary:calc item_tag set from storage catenary:calc spawn.original_item_tag
execute if data storage catenary:calc spawn.error run loot give @s loot catenary:rocket