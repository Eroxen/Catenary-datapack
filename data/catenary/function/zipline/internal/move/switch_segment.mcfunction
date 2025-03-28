execute store result score #zipline.max_rope_pos_i catenary.calc run data get storage catenary:calc zipline.data.max_rope_pos_i 1
execute store result score #zipline.rope_pos_i catenary.calc run data get storage catenary:calc zipline.data.rope_pos_i 1
scoreboard players operation #zipline.rope_pos_i catenary.calc += #zipline.momentum catenary.calc

execute if score #zipline.rope_pos_i catenary.calc matches ..-1 run return run function catenary:zipline/internal/move/finish
execute if score #zipline.rope_pos_i catenary.calc matches 0 if score #zipline.rope_pos_f catenary.calc matches ..-1 run return run function catenary:zipline/internal/move/finish
execute if score #zipline.rope_pos_i catenary.calc > #zipline.max_rope_pos_i catenary.calc run return run function catenary:zipline/internal/move/finish
execute if score #zipline.rope_pos_i catenary.calc = #zipline.max_rope_pos_i catenary.calc if score #zipline.rope_pos_f catenary.calc matches 1.. run return run function catenary:zipline/internal/move/finish


execute store result storage catenary:calc zipline.data.rope_pos_i int 1 run scoreboard players get #zipline.rope_pos_i catenary.calc
function catenary:zipline/internal/get_segment