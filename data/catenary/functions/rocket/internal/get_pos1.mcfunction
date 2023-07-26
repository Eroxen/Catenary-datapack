data modify storage catenary:calc item_tag set from storage catenary:calc EntityData.FireworksItem.tag
data modify storage catenary:calc item_tag.catenary.pos1 set from storage catenary:calc EntityData.Pos

data modify storage catenary:calc item_tag.catenary.bound set value 1b
data modify storage catenary:calc item_tag.Enchantments set value [{id:"catenary:enchanted",lvl:1s}]

loot give @s loot catenary:rocket