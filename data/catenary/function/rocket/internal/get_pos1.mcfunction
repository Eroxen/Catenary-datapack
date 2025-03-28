data modify storage catenary:calc FireworksItem.components.minecraft:custom_data.catenary.pos1 set from storage catenary:calc EntityData.Pos

data modify storage catenary:calc FireworksItem.components.minecraft:custom_data.catenary.bound set value 1b

data modify storage catenary:calc FireworksItem.components.minecraft:max_stack_size set value 1
data modify storage catenary:calc FireworksItem.components.minecraft:max_damage set value 1
data modify storage catenary:calc FireworksItem.components.minecraft:damage set value 1

function catenary:rocket/internal/give_with_components with storage catenary:calc FireworksItem