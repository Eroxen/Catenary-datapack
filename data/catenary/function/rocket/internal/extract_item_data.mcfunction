data modify storage catenary:calc spawn.original_item_components set from storage catenary:calc spawn.item_components
data modify storage catenary:calc spawn.pos1 set from storage catenary:calc spawn.item_components.minecraft:custom_data.catenary.pos1
data modify storage catenary:calc spawn merge from storage catenary:calc spawn.item_components.minecraft:custom_data.catenary.settings
execute if data storage catenary:calc spawn.decorations{type:"spelling"} run function catenary:rocket/internal/preprocess/custom_spelling
data remove storage catenary:calc spawn.item_components.minecraft:custom_data.catenary.pos1
data remove storage catenary:calc spawn.item_components.minecraft:custom_data.catenary.bound
data remove storage catenary:calc spawn.item_components.minecraft:enchantment_glint_override

function catenary:catenary/api/spawn
execute if data storage catenary:calc spawn{error:"points_too_close"} run tellraw @s {"text":"These points are too close.","color":"red"}
execute if data storage catenary:calc spawn{error:"points_too_far"} run tellraw @s {"text":"These points are too far.","color":"red"}
execute if data storage catenary:calc spawn.error run data modify storage catenary:calc FireworksItem.components set from storage catenary:calc spawn.original_item_components
execute if data storage catenary:calc spawn.error run function catenary:rocket/internal/give_with_components with storage catenary:calc FireworksItem