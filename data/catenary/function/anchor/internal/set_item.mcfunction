execute if data storage catenary:calc spawn_anchor.display.loot_table run function catenary:anchor/internal/set_item_loot_table with storage catenary:calc spawn_anchor.display
execute if data storage catenary:calc spawn_anchor.display.item run data modify entity @s item set from storage catenary:calc spawn_anchor.display.item

execute if data entity @s item.components.minecraft:custom_data.transformation run data modify entity @s transformation merge from entity @s item.components.minecraft:custom_data.transformation
data remove entity @s item.components.minecraft:custom_data.transformation