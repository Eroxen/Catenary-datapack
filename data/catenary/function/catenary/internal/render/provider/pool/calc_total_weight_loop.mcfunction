execute store result score #temp catenary.calc run data get storage catenary:calc temp[0].weight 1

scoreboard players operation #render.pool.total_weight catenary.calc += #temp catenary.calc

data remove storage catenary:calc temp[0]
execute if data storage catenary:calc temp[0] run function catenary:catenary/internal/render/provider/pool/calc_total_weight_loop