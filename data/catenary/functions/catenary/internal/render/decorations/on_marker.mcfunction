### start ###
function catenary:catenary/internal/render/start
data modify storage catenary:calc render.EntityData set value {Tags:["catenary.render","catenary.render.rope"],Rotation:[0f,0f],transformation:{translation:[0f,0f,0f],scale:[1.0f,1.0f,1.0f]}}
execute if data storage catenary:calc spawn.decorations{type:"block"} run data modify storage catenary:calc render.EntityData.transformation.translation set value [-0.5f,-0.5f,-0.5f]

### get display settings ###
data modify storage catenary:calc render.EntityData merge from storage catenary:calc spawn.decorations.EntityData
scoreboard players set #render.placement catenary.calc 0
execute if data storage catenary:calc spawn.decorations{placement:"middle"} run scoreboard players set #render.placement catenary.calc 1

scoreboard players set #render.emit_light catenary.calc 0
scoreboard players set #render.emit_light.offset catenary.calc 0
execute if data storage catenary:calc spawn.decorations.emit_light run scoreboard players set #render.emit_light catenary.calc 1
execute if data storage catenary:calc spawn.decorations.emit_light store result score #light_level catenary.calc run data get storage catenary:calc spawn.decorations.emit_light.level 1
execute if data storage catenary:calc spawn.decorations.emit_light.offset store result score #render.emit_light.offset catenary.calc run data get storage catenary:calc spawn.decorations.emit_light.offset 1000

data modify storage catenary:calc render.type set from storage catenary:calc spawn.decorations.type

scoreboard players set #render.variations catenary.calc 0
execute if data storage catenary:calc spawn.decorations.variations run scoreboard players set #render.variations catenary.calc 1
data modify storage catenary:calc render.variations set from storage catenary:calc spawn.decorations.variations

execute if score #render.placement catenary.calc matches 0 run data remove storage catenary:calc render.points[-1]

### enter loop ###
execute if data storage catenary:calc render.points[0] run function catenary:catenary/internal/render/decorations/loop

kill @s