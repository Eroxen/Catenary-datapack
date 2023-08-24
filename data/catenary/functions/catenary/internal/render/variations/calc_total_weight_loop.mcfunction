execute store result score #temp catenary.calc run data get storage catenary:calc render.variations.traverse_list[0].weight 1

scoreboard players operation #render.variations.total_weight catenary.calc += #temp catenary.calc

data remove storage catenary:calc render.variations.traverse_list[0]
execute if data storage catenary:calc render.variations.traverse_list[0] run function catenary:catenary/internal/render/variations/calc_total_weight_loop