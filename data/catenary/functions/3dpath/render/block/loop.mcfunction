function catenary:3dpath/render/advance
tp @e[type=marker,tag=catenaty.render.marker.1,limit=1] @s
data modify entity @s Pos set from storage catenary:calc render.point
execute at @s run tp @s ~ ~ ~ facing entity @e[type=marker,tag=catenaty.render.marker.1,limit=1]
data modify storage catenary:calc render.EntityData.Pos set from storage catenary:calc render.centre
data modify storage catenary:calc render.EntityData.Rotation[1] set from entity @s Rotation[1]
execute if score #render.scaling_axis catenary.calc matches 0 store result storage catenary:calc render.EntityData.transformation.scale[0] float 0.001 run scoreboard players get #render.distance catenary.calc
execute if score #render.scaling_axis catenary.calc matches 1 store result storage catenary:calc render.EntityData.transformation.scale[1] float 0.001 run scoreboard players get #render.distance catenary.calc
execute if score #render.scaling_axis catenary.calc matches 2 store result storage catenary:calc render.EntityData.transformation.scale[2] float 0.001 run scoreboard players get #render.distance catenary.calc
execute store result storage catenary:calc render.EntityData.transformation.translation[2] float -0.0005 run scoreboard players get #render.distance catenary.calc
execute summon block_display run function catenary:3dpath/render/block/new_display

execute if data storage catenary:calc render.points[0] run function catenary:3dpath/render/block/loop