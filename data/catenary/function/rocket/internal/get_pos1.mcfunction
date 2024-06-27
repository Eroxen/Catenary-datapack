data modify storage catenary:calc FireworksItem.components.minecraft:custom_data.catenary.pos1 set from storage catenary:calc EntityData.Pos

data modify storage catenary:calc FireworksItem.components.minecraft:custom_data.catenary.bound set value 1b
data modify storage catenary:calc FireworksItem.components.minecraft:enchantment_glint_override set value true

function catenary:rocket/internal/give_with_components with storage catenary:calc FireworksItem