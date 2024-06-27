### get total distance ###
execute unless data storage catenary:calc curve{swapped_points:1b} store result score #curve.3d.x1 catenary.calc run data get storage catenary:calc curve.pos1[0] 1000
execute unless data storage catenary:calc curve{swapped_points:1b} store result score #curve.3d.y1 catenary.calc run data get storage catenary:calc curve.pos1[1] 1000
execute unless data storage catenary:calc curve{swapped_points:1b} store result score #curve.3d.z1 catenary.calc run data get storage catenary:calc curve.pos1[2] 1000
execute unless data storage catenary:calc curve{swapped_points:1b} store result score #curve.3d.x2 catenary.calc run data get storage catenary:calc curve.pos2[0] 1000
execute unless data storage catenary:calc curve{swapped_points:1b} store result score #curve.3d.y2 catenary.calc run data get storage catenary:calc curve.pos2[1] 1000
execute unless data storage catenary:calc curve{swapped_points:1b} store result score #curve.3d.z2 catenary.calc run data get storage catenary:calc curve.pos2[2] 1000
execute if data storage catenary:calc curve{swapped_points:1b} store result score #curve.3d.x1 catenary.calc run data get storage catenary:calc curve.pos2[0] 1000
execute if data storage catenary:calc curve{swapped_points:1b} store result score #curve.3d.y1 catenary.calc run data get storage catenary:calc curve.pos2[1] 1000
execute if data storage catenary:calc curve{swapped_points:1b} store result score #curve.3d.z1 catenary.calc run data get storage catenary:calc curve.pos2[2] 1000
execute if data storage catenary:calc curve{swapped_points:1b} store result score #curve.3d.x2 catenary.calc run data get storage catenary:calc curve.pos1[0] 1000
execute if data storage catenary:calc curve{swapped_points:1b} store result score #curve.3d.y2 catenary.calc run data get storage catenary:calc curve.pos1[1] 1000
execute if data storage catenary:calc curve{swapped_points:1b} store result score #curve.3d.z2 catenary.calc run data get storage catenary:calc curve.pos1[2] 1000
scoreboard players operation #curve.3d.dx catenary.calc = #curve.3d.x2 catenary.calc
scoreboard players operation #curve.3d.dx catenary.calc -= #curve.3d.x1 catenary.calc
scoreboard players operation #curve.3d.dy catenary.calc = #curve.3d.y2 catenary.calc
scoreboard players operation #curve.3d.dy catenary.calc -= #curve.3d.y1 catenary.calc
scoreboard players operation #curve.3d.dz catenary.calc = #curve.3d.z2 catenary.calc
scoreboard players operation #curve.3d.dz catenary.calc -= #curve.3d.z1 catenary.calc

scoreboard players operation #curve.3d.length catenary.calc = #curve.3d.dx catenary.calc
scoreboard players operation #curve.3d.length catenary.calc *= #curve.3d.length catenary.calc
scoreboard players operation #curve.temp catenary.calc = #curve.3d.dy catenary.calc
scoreboard players operation #curve.temp catenary.calc *= #curve.temp catenary.calc
scoreboard players operation #curve.3d.length catenary.calc += #curve.temp catenary.calc
scoreboard players operation #curve.temp catenary.calc = #curve.3d.dz catenary.calc
scoreboard players operation #curve.temp catenary.calc *= #curve.temp catenary.calc
scoreboard players operation #curve.3d.length catenary.calc += #curve.temp catenary.calc
execute store result storage flop:api input float 0.000001 run scoreboard players get #curve.3d.length catenary.calc
function flop:api/storage/sqrt
execute store result score #curve.3d.length catenary.calc run data get storage flop:api output 1000
scoreboard players operation #curve.3d.samples catenary.calc = #curve.3d.length catenary.calc
scoreboard players operation #curve.3d.samples catenary.calc /= #curve.sample_distance catenary.calc
scoreboard players add #curve.3d.samples catenary.calc 1
execute if score #curve.sample_distance catenary.calc matches 0 run scoreboard players operation #curve.3d.samples catenary.calc = #curve.sample_count catenary.calc
execute if score #curve.sample_distance catenary.calc matches 0 run scoreboard players remove #curve.3d.samples catenary.calc 1

scoreboard players operation #curve.3d.sample.distance catenary.calc = #curve.3d.length catenary.calc
scoreboard players operation #curve.3d.sample.distance catenary.calc /= #curve.3d.samples catenary.calc

data modify storage catenary:calc curve.3d.samples set value []
scoreboard players set #curve.3d.sample catenary.calc 0
function catenary:curve/internal/3d/sample_loop

data modify storage catenary:calc curve.samples set from storage catenary:calc curve.3d.samples