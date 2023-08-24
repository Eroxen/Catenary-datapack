function eroxified:api/math/random/uniform

data modify storage catenary:calc render.variations.traverse_list set from storage catenary:calc render.variations.list
function catenary:catenary/internal/render/variations/randomise_loop


execute if data storage catenary:calc render.variations.traverse_list[0].EntityData run data modify storage catenary:calc render.EntityData merge from storage catenary:calc render.variations.traverse_list[0].EntityData
execute if data storage catenary:calc render.variations.traverse_list[0].type run data modify storage catenary:calc render.type set from storage catenary:calc render.variations.traverse_list[0].type