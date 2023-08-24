execute store success score #render.variations.randomise catenary.calc if data storage catenary:calc render.variations.list[].weight

execute if score #render.variations.randomise catenary.calc matches 1 run scoreboard players set #render.variations.total_weight catenary.calc 0
execute if score #render.variations.randomise catenary.calc matches 1 run data modify storage catenary:calc render.variations.traverse_list set from storage catenary:calc render.variations.list
execute if score #render.variations.randomise catenary.calc matches 1 run function catenary:catenary/internal/render/variations/calc_total_weight_loop
execute if score #render.variations.randomise catenary.calc matches 1 run scoreboard players set math.random.min eroxified.api 0
execute if score #render.variations.randomise catenary.calc matches 1 run scoreboard players operation math.random.max eroxified.api = #render.variations.total_weight catenary.calc
execute if score #render.variations.randomise catenary.calc matches 1 run scoreboard players remove math.random.max eroxified.api 1