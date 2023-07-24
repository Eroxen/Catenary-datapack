data modify entity @s Pos set from storage catenary:calc spawn.pos1
execute at @s positioned ~ ~-0.15 ~ unless entity @e[type=interaction,tag=catenary.anchor,distance=..0.01] run function catenary:anchor/api/spawn
execute at @s positioned ~ ~-0.15 ~ summon marker run function catenary:catenary/internal/spawn/end_point
data modify entity @s Pos set from storage catenary:calc spawn.pos2
execute at @s positioned ~ ~-0.15 ~ unless entity @e[type=interaction,tag=catenary.anchor,distance=..0.01] run function catenary:anchor/api/spawn
execute at @s positioned ~ ~-0.15 ~ summon marker run function catenary:catenary/internal/spawn/end_point

data modify storage catenary:calc 3dpath.point1 set from storage catenary:calc spawn.pos1
data modify storage catenary:calc 3dpath.point2 set from storage catenary:calc spawn.pos2
execute store result score 2dpath.sag catenary.calc run data get storage catenary:calc spawn.sag 1000
execute if score 2dpath.sag catenary.calc matches 1000..1030 run scoreboard players set 2dpath.sag catenary.calc 1010
execute if score 2dpath.sag catenary.calc matches 1030..1070 run scoreboard players set 2dpath.sag catenary.calc 1050
execute if score 2dpath.sag catenary.calc matches 1070..1200 run scoreboard players set 2dpath.sag catenary.calc 1100
execute unless score 2dpath.sag catenary.calc matches 1000..1200 run scoreboard players set 2dpath.sag catenary.calc 1050

execute store result score 2dpath.segment_length catenary.calc run data get storage catenary:calc spawn.rope.segment_length 1000

function catenary:3dpath/make
function catenary:3dpath/render/block/render

execute if data storage catenary:calc spawn.decorations run function catenary:catenary/internal/spawn/decorations