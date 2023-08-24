execute if data storage catenary:calc render.variations.list[0].EntityData run data modify storage catenary:calc render.EntityData merge from storage catenary:calc render.variations.list[0].EntityData
execute if data storage catenary:calc render.variations.list[0].type run data modify storage catenary:calc render.type set from storage catenary:calc render.variations.list[0].type

data modify storage catenary:calc render.variations.list append from storage catenary:calc render.variations.list[0]
data remove storage catenary:calc render.variations.list[0]