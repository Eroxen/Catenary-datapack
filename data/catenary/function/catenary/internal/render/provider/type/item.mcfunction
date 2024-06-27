data modify storage catenary:calc render.entity merge value {type:"minecraft:item_display"}
data modify storage catenary:calc render.entity.data merge from storage catenary:calc render.default
data modify storage catenary:calc render.entity.data.item set from storage catenary:calc render.provider.item
execute if data storage catenary:calc render.provider.transformation run data modify storage catenary:calc render.entity.data.transformation merge from storage catenary:calc render.provider.transformation