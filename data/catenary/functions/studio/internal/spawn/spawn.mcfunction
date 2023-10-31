data modify storage catenary:calc studio set value {data:{settings:{rope:{item:{Count:1b,id:"minecraft:chain"},sag:0,segment_length:0}}}}
data modify storage catenary:calc studio.data.pos1 set from storage catenary:calc spawn.pos1
data modify storage catenary:calc studio.data.pos2 set from storage catenary:calc spawn.pos2

data modify storage catenary:calc studio.data.invested_item_tag set from storage catenary:calc spawn.item_tag

### create rope ###
function catenary:studio/internal/to_spawn_data
data modify storage catenary:calc create_curve set value {}
data modify storage catenary:calc create_curve.sag set from storage catenary:calc spawn.sag
data modify storage catenary:calc create_curve.pos1 set from storage catenary:calc studio.data.pos1
data modify storage catenary:calc create_curve.pos2 set from storage catenary:calc studio.data.pos2
function catenary:curve/api/create
execute store result score #curve.sample_distance catenary.calc run data get storage catenary:calc spawn.rope.segment_length 1000
function catenary:curve/api/sample

function catenary:catenary/internal/render/rope

execute if data storage catenary:calc spawn.decorations run function catenary:catenary/internal/spawn/decorations

### save data to studio ###
data modify storage catenary:calc studio.data.curve set from storage catenary:calc curve
data modify storage catenary:calc studio.data.spawn set from storage catenary:calc spawn

data modify entity @s Pos set from storage catenary:calc studio.data.pos1
execute at @s run function catenary:studio/internal/spawn/anchor_offset

data modify entity @s Pos set from storage catenary:calc studio.data.pos2
execute at @s run function catenary:studio/internal/spawn/anchor_offset