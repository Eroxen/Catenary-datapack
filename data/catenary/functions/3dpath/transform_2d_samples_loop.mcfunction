execute store result score 2dpath.x catenary.calc run data get storage catenary:calc 2dpath.samples[0][0] 1000
execute store result score 3dpath.y catenary.calc run data get storage catenary:calc 2dpath.samples[0][1] 1000
data remove storage catenary:calc 2dpath.samples[0]

scoreboard players operation 3dpath.x catenary.calc = 2dpath.x catenary.calc
scoreboard players operation 3dpath.x catenary.calc *= 3dpath.dx catenary.calc
scoreboard players operation 3dpath.x catenary.calc += 3dpath.base_x catenary.calc
scoreboard players operation 3dpath.y catenary.calc += 3dpath.base_y catenary.calc
scoreboard players operation 3dpath.z catenary.calc = 2dpath.x catenary.calc
scoreboard players operation 3dpath.z catenary.calc *= 3dpath.dz catenary.calc
scoreboard players operation 3dpath.z catenary.calc += 3dpath.base_z catenary.calc

data modify storage catenary:calc 3dpath.samples append value [0d,0d,0d]
execute store result storage catenary:calc 3dpath.samples[-1][0] double 0.000001 run scoreboard players get 3dpath.x catenary.calc
execute store result storage catenary:calc 3dpath.samples[-1][1] double 0.001 run scoreboard players get 3dpath.y catenary.calc
execute store result storage catenary:calc 3dpath.samples[-1][2] double 0.000001 run scoreboard players get 3dpath.z catenary.calc

execute if data storage catenary:calc 2dpath.samples[0] run function catenary:3dpath/transform_2d_samples_loop