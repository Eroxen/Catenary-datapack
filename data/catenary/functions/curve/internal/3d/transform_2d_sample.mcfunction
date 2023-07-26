execute store result score #curve.2d.x catenary.calc run data get storage catenary:calc curve.2d.sampled.x 1000
execute store result score #curve.3d.y catenary.calc run data get storage catenary:calc curve.2d.sampled.y 1000

scoreboard players operation #curve.3d.x catenary.calc = #curve.2d.x catenary.calc
scoreboard players operation #curve.3d.x catenary.calc *= #curve.3d.dx catenary.calc
scoreboard players operation #curve.3d.x catenary.calc += #curve.3d.base_x catenary.calc
scoreboard players operation #curve.3d.y catenary.calc += #curve.3d.base_y catenary.calc
scoreboard players operation #curve.3d.z catenary.calc = #curve.2d.x catenary.calc
scoreboard players operation #curve.3d.z catenary.calc *= #curve.3d.dz catenary.calc
scoreboard players operation #curve.3d.z catenary.calc += #curve.3d.base_z catenary.calc

execute unless data storage catenary:calc curve{swapped_points:1b} run data modify storage catenary:calc curve.3d.samples append value {pos:[0d,0d,0d]}
execute unless data storage catenary:calc curve{swapped_points:1b} store result storage catenary:calc curve.3d.samples[-1].pos[0] double 0.000001 run scoreboard players get #curve.3d.x catenary.calc
execute unless data storage catenary:calc curve{swapped_points:1b} store result storage catenary:calc curve.3d.samples[-1].pos[1] double 0.001 run scoreboard players get #curve.3d.y catenary.calc
execute unless data storage catenary:calc curve{swapped_points:1b} store result storage catenary:calc curve.3d.samples[-1].pos[2] double 0.000001 run scoreboard players get #curve.3d.z catenary.calc
execute unless data storage catenary:calc curve{swapped_points:1b} run data modify storage catenary:calc curve.3d.samples[-1].distance set from storage catenary:calc curve.2d.sampled.distance

execute if data storage catenary:calc curve{swapped_points:1b} run data modify storage catenary:calc curve.3d.samples prepend value {pos:[0d,0d,0d],distance:0f}
execute if data storage catenary:calc curve{swapped_points:1b} store result storage catenary:calc curve.3d.samples[0].pos[0] double 0.000001 run scoreboard players get #curve.3d.x catenary.calc
execute if data storage catenary:calc curve{swapped_points:1b} store result storage catenary:calc curve.3d.samples[0].pos[1] double 0.001 run scoreboard players get #curve.3d.y catenary.calc
execute if data storage catenary:calc curve{swapped_points:1b} store result storage catenary:calc curve.3d.samples[0].pos[2] double 0.000001 run scoreboard players get #curve.3d.z catenary.calc
execute if data storage catenary:calc curve{swapped_points:1b} run data modify storage catenary:calc curve.3d.samples[1].distance set from storage catenary:calc curve.2d.sampled.distance