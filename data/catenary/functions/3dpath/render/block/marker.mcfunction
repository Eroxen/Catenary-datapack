function catenary:3dpath/render/start
data modify entity @s Pos set from storage catenary:calc render.point
data modify storage catenary:calc EntityData set value {Tags:["catenaty.render.marker.1"]}
data modify storage catenary:calc EntityData.Pos set from storage catenary:calc render.points[-1]
execute summon marker run data modify entity @s {} merge from storage catenary:calc EntityData
execute at @s run tp @s ~ ~ ~ facing entity @e[type=marker,tag=catenaty.render.marker.1,limit=1]

execute store result score 3dpath.dx catenary.calc run data get storage catenary:calc 3dpath.dx 1000
execute store result score 3dpath.dz catenary.calc run data get storage catenary:calc 3dpath.dz 1000
execute store result storage eroxified:api math.input float 0.001 run scoreboard players get 3dpath.dx catenary.calc
function eroxified:api/math/trig/arcsin
execute store result score render.angle catenary.calc run data get storage eroxified:api math.output -1000
execute if score 3dpath.dz catenary.calc matches ..-1 run scoreboard players operation render.angle catenary.calc *= -1 catenary.calc
execute if score 3dpath.dz catenary.calc matches ..-1 run scoreboard players add render.angle catenary.calc 180000
scoreboard players add render.angle catenary.calc 90000
execute if score render.angle catenary.calc matches 180001.. run scoreboard players remove render.angle catenary.calc 360000
execute if score render.angle catenary.calc matches ..-180001 run scoreboard players add render.angle catenary.calc 360000
data modify storage catenary:calc render.EntityData set value {Tags:["catenary.render","catenary.render.block"],Rotation:[0f,0f],transformation:{translation:[-0.5f,-0.5f,-0.5f],scale:[1.0f,1.0f,1.0f]}}
data modify storage catenary:calc render.EntityData.block_state set from storage catenary:calc spawn.rope.block_state
execute if data storage catenary:calc spawn.rope.transformation run data modify storage catenary:calc render.EntityData.transformation merge from storage catenary:calc spawn.rope.transformation
scoreboard players set #render.scaling_axis catenary.calc 2
execute if data storage catenary:calc spawn.rope.scaling_axis store result score #render.scaling_axis catenary.calc run data get storage catenary:calc spawn.rope.scaling_axis 1
scoreboard players add render.angle catenary.calc 90000
execute store result score render.angle catenary.calc run data get entity @s Rotation[0] 10000
scoreboard players add render.angle catenary.calc 1800000
execute store result storage catenary:calc render.EntityData.Rotation[0] float 0.0001 run scoreboard players get render.angle catenary.calc


execute if data storage catenary:calc render.points[0] run function catenary:3dpath/render/block/loop

kill @e[type=marker,tag=catenaty.render.marker.1]
kill @s