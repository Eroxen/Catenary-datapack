scoreboard players set #render.pool.total_weight catenary.calc 0
data modify storage catenary:calc temp set from storage catenary:calc render.settings.entries

function catenary:catenary/internal/render/provider/pool/calc_total_weight_loop

data modify storage catenary:calc render.settings.random_macro set value {min:0}
scoreboard players remove #render.pool.total_weight catenary.calc 1
execute store result storage catenary:calc render.settings.random_macro.max int 1 run scoreboard players get #render.pool.total_weight catenary.calc
scoreboard players add #render.pool.total_weight catenary.calc 1