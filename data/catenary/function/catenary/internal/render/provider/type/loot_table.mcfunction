data modify storage catenary:calc render.entity merge value {type:"minecraft:item_display"}
data modify storage catenary:calc render.entity.init.insert_loot_table set from storage catenary:calc render.provider.name
execute if data storage catenary:calc render.provider.transformation run data modify storage catenary:calc render.entity.data.transformation merge from storage catenary:calc render.provider.transformation
