data modify storage catenary:calc item_tag set from storage catenary:calc used_item.tag
execute if predicate catenary:survival_or_adventure run function eroxified2:item/api/decrement_mainhand
data modify storage catenary:calc item_tag.catenary.pos1 set from storage catenary:calc anchor_pos
execute store result score #temp catenary.calc run data get storage catenary:calc item_tag.catenary.pos1[1] 1000
scoreboard players add #temp catenary.calc 150
execute store result storage catenary:calc item_tag.catenary.pos1[1] double 0.001 run scoreboard players get #temp catenary.calc

data modify storage catenary:calc item_tag.catenary.bound set value 1b
data modify storage catenary:calc item_tag.Enchantments set value [{id:"catenary:enchanted",lvl:1s}]

loot give @s loot catenary:rocket