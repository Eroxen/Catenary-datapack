## TODO: check if connection already exists between the two anchors


execute if predicate catenary:survival_or_adventure run function eroxified:api/item/decrement_mainhand

data modify storage catenary:calc spawn set value {}
data modify storage catenary:calc spawn.pos2 set from storage catenary:calc anchor_pos
execute store result score #temp catenary.calc run data get storage catenary:calc spawn.pos2[1] 1000
scoreboard players add #temp catenary.calc 150
execute store result storage catenary:calc spawn.pos2[1] double 0.001 run scoreboard players get #temp catenary.calc
data modify storage catenary:calc spawn.item_tag set from storage catenary:calc used_item.tag
function catenary:rocket/internal/extract_item_data