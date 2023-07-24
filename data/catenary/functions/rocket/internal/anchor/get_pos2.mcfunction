## TODO: check if connection already exists between the two anchors


execute if predicate catenary:survival_or_adventure run function eroxified:api/item/decrement_mainhand

data modify storage catenary:calc spawn set value {}
data modify storage catenary:calc spawn.pos1 set from storage catenary:calc used_item.tag.catenary.pos1
data modify storage catenary:calc spawn.pos2 set from storage catenary:calc anchor_pos
execute store result score #temp catenary.calc run data get storage catenary:calc spawn.pos2[1] 1000
scoreboard players add #temp catenary.calc 150
execute store result storage catenary:calc spawn.pos2[1] double 0.001 run scoreboard players get #temp catenary.calc
data modify storage catenary:calc spawn.sag set from storage catenary:calc used_item.tag.catenary.sag
data modify storage catenary:calc spawn.rope set from storage catenary:calc used_item.tag.catenary.rope
data modify storage catenary:calc spawn.decorations set from storage catenary:calc used_item.tag.catenary.decorations
function catenary:catenary/api/spawn
execute if data storage catenary:calc spawn.error run tellraw @s {"storage":"catenary:calc","nbt":"spawn.error","color":"red"}