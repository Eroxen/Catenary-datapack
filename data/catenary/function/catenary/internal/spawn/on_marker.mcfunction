data modify storage catenary:calc spawn_anchor set value {loot_table:"catenary:anchor/default"}
execute if data storage catenary:calc spawn.anchor_item run data modify storage catenary:calc spawn_anchor.loot_table set from storage catenary:calc spawn.anchor_item

data modify entity @s Pos set from storage catenary:calc spawn.pos1
execute at @s positioned ~ ~-0.15 ~ unless entity @e[type=interaction,tag=catenary.anchor,distance=..0.01] run function catenary:anchor/api/spawn
execute at @s positioned ~ ~-0.15 ~ summon marker run function catenary:catenary/internal/spawn/end_point
data modify entity @s Pos set from storage catenary:calc spawn.pos2
execute at @s positioned ~ ~-0.15 ~ unless entity @e[type=interaction,tag=catenary.anchor,distance=..0.01] run function catenary:anchor/api/spawn
execute at @s positioned ~ ~-0.15 ~ summon marker run function catenary:catenary/internal/spawn/end_point

data modify storage catenary:calc create_curve set value {}
data modify storage catenary:calc create_curve.sag set from storage catenary:calc spawn.sag
data modify storage catenary:calc create_curve.pos1 set from storage catenary:calc spawn.pos1
data modify storage catenary:calc create_curve.pos2 set from storage catenary:calc spawn.pos2
function catenary:curve/api/create
execute store result score #curve.sample_distance catenary.calc run data get storage catenary:calc spawn.rope.segment_length 1000
function catenary:curve/api/sample

function catenary:catenary/internal/render/rope

execute if data storage catenary:calc spawn.decorations run function catenary:catenary/internal/spawn/decorations
kill @s