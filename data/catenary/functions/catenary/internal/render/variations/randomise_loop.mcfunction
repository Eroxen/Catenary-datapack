execute store result score #temp catenary.calc run data get storage catenary:calc render.variations.traverse_list[0].weight 1
scoreboard players operation math.random.value catenary.calc -= #temp catenary.calc
execute if score math.random.value catenary.calc matches 0.. run data remove storage catenary:calc render.variations.traverse_list[0]
execute if score math.random.value catenary.calc matches 0.. if data storage catenary:calc render.variations.traverse_list[0] run function catenary:catenary/internal/render/variations/randomise_loop