### start ###
function catenary:catenary/internal/render/start
data modify storage catenary:calc render.EntityData set value {width:1,height:1,Tags:["catenary.render","catenary.render.rope"],Rotation:[0f,0f],transformation:{translation:[0f,0f,0f],scale:[1.0f,1.0f,1.0f]}}
execute if data storage catenary:calc spawn.decorations{type:"block"} run data modify storage catenary:calc render.EntityData.transformation.translation set value [-0.5f,-0.5f,-0.5f]

### get display settings ###
data modify storage catenary:calc render.EntityData merge from storage catenary:calc spawn.decorations.EntityData
scoreboard players set #render.placement catenary.calc 0
execute if data storage catenary:calc spawn.decorations{placement:"middle"} run scoreboard players set #render.placement catenary.calc 1

scoreboard players set #render.offset catenary.calc 0
execute if data storage catenary:calc spawn.decorations.offset store result score #render.offset catenary.calc run data get storage catenary:calc spawn.decorations.offset 1000

scoreboard players set #render.emit_light catenary.calc 0
execute if data storage catenary:calc spawn.decorations.emit_light run scoreboard players set #render.emit_light catenary.calc 1
execute if data storage catenary:calc spawn.decorations.emit_light store result score #light_level catenary.calc run data get storage catenary:calc spawn.decorations.emit_light.level 1

execute store success score #render.random_rotation catenary.calc if data storage catenary:calc spawn.decorations{random_rotation:1b}

data modify storage catenary:calc render.type set from storage catenary:calc spawn.decorations.type

### variations ###
scoreboard players set #render.variations catenary.calc 0
execute if data storage catenary:calc spawn.decorations.variations run scoreboard players set #render.variations catenary.calc 1
data modify storage catenary:calc render.variations set value {default:{}}
data modify storage catenary:calc render.variations.list set from storage catenary:calc spawn.decorations.variations
data modify storage catenary:calc render.variations.default.type set from storage catenary:calc spawn.decorations.type
execute if data storage catenary:calc spawn.decorations{type:"block"} run data modify storage catenary:calc render.variations.default.EntityData.transformation.translation set value [-0.5f,-0.5f,-0.5f]
data modify storage catenary:calc render.variations.default.EntityData set from storage catenary:calc spawn.decorations.EntityData
execute if score #render.variations catenary.calc matches 1 run function catenary:catenary/internal/render/variations/init

execute if score #render.placement catenary.calc matches 0 run data remove storage catenary:calc render.points[-1]

### enter loop ###
execute if data storage catenary:calc render.points[0] run function catenary:catenary/internal/render/decorations/loop

kill @s