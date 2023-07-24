data modify storage catenary:calc spawn set value {}
data modify storage catenary:calc spawn.pos1 set from storage catenary:calc EntityData.FireworksItem.tag.catenary.pos1
data modify storage catenary:calc spawn.pos2 set from storage catenary:calc EntityData.Pos
data modify storage catenary:calc spawn.sag set from storage catenary:calc EntityData.FireworksItem.tag.catenary.sag
data modify storage catenary:calc spawn.rope set from storage catenary:calc EntityData.FireworksItem.tag.catenary.rope
data modify storage catenary:calc spawn.decorations set from storage catenary:calc EntityData.FireworksItem.tag.catenary.decorations
function catenary:catenary/api/spawn
execute if data storage catenary:calc spawn.error run tellraw @s {"storage":"catenary:calc","nbt":"spawn.error","color":"red"}