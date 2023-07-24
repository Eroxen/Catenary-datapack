function catenary:3dpath/render/start
data remove storage catenary:calc render.points[-1]
data modify entity @s Pos set from storage catenary:calc render.point

data modify storage catenary:calc render.EntityData set value {Tags:["catenary.render","catenary.render.block"],Rotation:[0f,0f],transformation:{translation:[-0.5f,-0.5f,-0.5f],scale:[1.0f,1.0f,1.0f]}}
data modify storage catenary:calc render.EntityData.block_state set from storage catenary:calc spawn.decorations.block_state
data modify storage catenary:calc render.EntityData.transformation merge from storage catenary:calc spawn.decorations.transformation

execute if data storage catenary:calc render.points[0] run function catenary:3dpath/render/decorations/loop

kill @s