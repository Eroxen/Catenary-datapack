data modify storage catenary:calc render.EntityData set value {width:1,height:1,Tags:["catenary.render","catenary.render.rope"],Rotation:[0f,0f],transformation:{translation:[0f,0f,0f],scale:[1.0f,1.0f,1.0f]}}
data modify storage catenary:calc render.EntityData merge from storage catenary:calc render.variations.default.EntityData
data modify storage catenary:calc render.type set from storage catenary:calc render.variations.default.type

execute if score #render.variations.randomise catenary.calc matches 1 run function catenary:catenary/internal/render/variations/randomise
execute if score #render.variations.randomise catenary.calc matches 0 run function catenary:catenary/internal/render/variations/step