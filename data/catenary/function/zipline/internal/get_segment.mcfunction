execute store result score #zipline.rope_pos_i catenary.calc run data get storage catenary:calc zipline.data.rope_pos_i 1
execute store result score #zipline.max_rope_pos_i catenary.calc run data get storage catenary:calc zipline.data.max_rope_pos_i 1
execute store result score #zipline.rope_pos_f catenary.calc run data get storage catenary:calc zipline.data.rope_pos_f 1000
execute store result score #zipline.speed catenary.calc run data get storage catenary:calc zipline.data.speed 1000

execute if data storage catenary:calc zipline.data.trajectory{swapped_points:1b} run scoreboard players operation #temp catenary.calc = #zipline.max_rope_pos_i catenary.calc
execute if data storage catenary:calc zipline.data.trajectory{swapped_points:1b} run scoreboard players operation #temp catenary.calc -= #zipline.rope_pos_i catenary.calc
execute if data storage catenary:calc zipline.data.trajectory{swapped_points:1b} run scoreboard players operation #zipline.rope_pos_i catenary.calc = #temp catenary.calc
execute if data storage catenary:calc zipline.data.trajectory{swapped_points:1b} if score #zipline.rope_pos_i catenary.calc matches 1.. run scoreboard players remove #zipline.rope_pos_i catenary.calc 1
execute if score #zipline.rope_pos_i catenary.calc >= #zipline.max_rope_pos_i catenary.calc if score #zipline.rope_pos_f catenary.calc matches 0 run scoreboard players remove #zipline.rope_pos_i catenary.calc 1
data modify storage catenary:calc macro set value {i:0,j:0}
execute unless data storage catenary:calc zipline.data.trajectory{swapped_points:1b} store result storage catenary:calc macro.i int 1 run scoreboard players get #zipline.rope_pos_i catenary.calc
execute if data storage catenary:calc zipline.data.trajectory{swapped_points:1b} store result storage catenary:calc macro.j int 1 run scoreboard players get #zipline.rope_pos_i catenary.calc
scoreboard players add #zipline.rope_pos_i catenary.calc 1
execute unless data storage catenary:calc zipline.data.trajectory{swapped_points:1b} store result storage catenary:calc macro.j int 1 run scoreboard players get #zipline.rope_pos_i catenary.calc
execute if data storage catenary:calc zipline.data.trajectory{swapped_points:1b} store result storage catenary:calc macro.i int 1 run scoreboard players get #zipline.rope_pos_i catenary.calc
# tellraw @a {"nbt": "macro", "storage": "catenary:calc"}

data modify storage catenary:calc zipline.data.segment set value {}
function catenary:zipline/internal/get_segment_macro with storage catenary:calc macro

execute store result score #curve.3d.x1 catenary.calc run data get storage catenary:calc zipline.data.segment.pos2[0] 1000
execute store result score #curve.3d.y1 catenary.calc run data get storage catenary:calc zipline.data.segment.pos2[1] 1000
execute store result score #curve.3d.z1 catenary.calc run data get storage catenary:calc zipline.data.segment.pos2[2] 1000
execute store result score #curve.3d.x2 catenary.calc run data get storage catenary:calc zipline.data.segment.pos1[0] 1000
execute store result score #curve.3d.y2 catenary.calc run data get storage catenary:calc zipline.data.segment.pos1[1] 1000
execute store result score #curve.3d.z2 catenary.calc run data get storage catenary:calc zipline.data.segment.pos1[2] 1000
scoreboard players operation #curve.3d.dx catenary.calc = #curve.3d.x2 catenary.calc
scoreboard players operation #curve.3d.dx catenary.calc -= #curve.3d.x1 catenary.calc
scoreboard players operation #curve.3d.dy catenary.calc = #curve.3d.y2 catenary.calc
scoreboard players operation #curve.3d.dy catenary.calc -= #curve.3d.y1 catenary.calc
scoreboard players operation #curve.3d.dz catenary.calc = #curve.3d.z2 catenary.calc
scoreboard players operation #curve.3d.dz catenary.calc -= #curve.3d.z1 catenary.calc

scoreboard players operation #curve.3d.dx catenary.calc *= #curve.3d.dx catenary.calc
scoreboard players operation #curve.3d.dz catenary.calc *= #curve.3d.dz catenary.calc
scoreboard players operation #curve.3d.dx catenary.calc += #curve.3d.dz catenary.calc
execute store result storage flop:api input float 0.000001 run scoreboard players get #curve.3d.dx catenary.calc
function flop:api/storage/sqrt
execute store result score #curve.3d.dx catenary.calc run data get storage flop:api output 1000

scoreboard players operation #zipline.slope catenary.calc = #curve.3d.dy catenary.calc
scoreboard players operation #zipline.slope catenary.calc *= 1000 catenary.calc
scoreboard players operation #zipline.slope catenary.calc /= #curve.3d.dx catenary.calc
execute store result storage catenary:calc zipline.data.segment.slope float 0.001 run scoreboard players get #zipline.slope catenary.calc