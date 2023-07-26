### start ###
function catenary:catenary/internal/render/start
data modify storage catenary:calc render.EntityData set value {width:1,height:1,Tags:["catenary.render","catenary.render.rope"],Rotation:[0f,0f],transformation:{translation:[-0.5f,-0.5f,-0.5f],scale:[1.0f,1.0f,1.0f]},block_state:{Name:"minecraft:jigsaw",Properties:{orientation:"south_up"}}}

### get horizontal rotation ###
data modify entity @s Pos set from storage catenary:calc render.point.pos
data modify storage catenary:calc EntityData set value {Tags:["catenaty.render.marker.1"]}
data modify storage catenary:calc EntityData.Pos set from storage catenary:calc render.points[-1].pos
execute summon marker run data modify entity @s {} merge from storage catenary:calc EntityData
execute at @s run tp @s ~ ~ ~ facing entity @e[type=marker,tag=catenaty.render.marker.1,limit=1]
execute store result score #render.angle catenary.calc run data get entity @s Rotation[0] 10000
scoreboard players add #render.angle catenary.calc 1800000
execute store result storage catenary:calc render.EntityData.Rotation[0] float 0.0001 run scoreboard players get #render.angle catenary.calc

### get display settings ###
data modify storage catenary:calc render.EntityData merge from storage catenary:calc spawn.rope.EntityData
scoreboard players set #render.scaling_axis catenary.calc 2
execute if data storage catenary:calc spawn.rope.scaling_axis store result score #render.scaling_axis catenary.calc run data get storage catenary:calc spawn.rope.scaling_axis 1

### enter loop ###
execute if data storage catenary:calc render.points[0] run function catenary:catenary/internal/render/rope/loop

kill @e[type=marker,tag=catenaty.render.marker.1]
kill @s