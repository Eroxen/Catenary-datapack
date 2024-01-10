execute store success score #render.variations.randomise catenary.calc if data storage catenary:calc render.variations.list[].weight

### randomisation ###
execute unless score #render.variations.randomise catenary.calc matches 1 run return 0
scoreboard players set #render.variations.total_weight catenary.calc 0
data modify storage catenary:calc render.variations.traverse_list set from storage catenary:calc render.variations.list
function catenary:catenary/internal/render/variations/calc_total_weight_loop
data modify storage catenary:calc render.variations.random_macro set value {min:0}
scoreboard players remove #render.variations.total_weight catenary.calc 1
execute store result storage catenary:calc render.variations.random_macro.max int 1 run scoreboard players get #render.variations.total_weight catenary.calc
scoreboard players add #render.variations.total_weight catenary.calc 1