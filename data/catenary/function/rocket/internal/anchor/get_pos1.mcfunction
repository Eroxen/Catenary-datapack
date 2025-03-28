execute if predicate catenary:survival_or_adventure run function eroxified2:item/api/decrement_mainhand
data modify storage catenary:calc FireworksItem.components.minecraft:custom_data.catenary.pos1 set from storage catenary:calc anchor_pos
execute store result score #temp catenary.calc run data get storage catenary:calc FireworksItem.components.minecraft:custom_data.catenary.pos1[1] 1000
scoreboard players add #temp catenary.calc 150
execute store result storage catenary:calc FireworksItem.components.minecraft:custom_data.catenary.pos1[1] double 0.001 run scoreboard players get #temp catenary.calc

data modify storage catenary:calc FireworksItem.components.minecraft:custom_data.catenary.bound set value 1b

data modify storage catenary:calc FireworksItem.components.minecraft:max_stack_size set value 1
data modify storage catenary:calc FireworksItem.components.minecraft:max_damage set value 1
data modify storage catenary:calc FireworksItem.components.minecraft:damage set value 1

function catenary:rocket/internal/give_with_components with storage catenary:calc FireworksItem