data modify storage catenary:calc render.EntityData set value {width:1,height:1,Tags:["catenary.render","catenary.render.rope"],Rotation:[0f,0f],transformation:{translation:[0f,0f,0f],scale:[1.0f,1.0f,1.0f]}}
execute if data storage catenary:calc spawn.decorations{type:"block"} run data modify storage catenary:calc render.EntityData.transformation.translation set value [-0.5f,-0.5f,-0.5f]
data modify storage catenary:calc render.EntityData merge from storage catenary:calc spawn.decorations.EntityData

execute if data storage catenary:calc render.variations[0].EntityData run data modify storage catenary:calc render.EntityData merge from storage catenary:calc render.variations[0].EntityData

data modify storage catenary:calc render.variations append from storage catenary:calc render.variations[0]
data remove storage catenary:calc render.variations[0]