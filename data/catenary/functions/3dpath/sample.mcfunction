function catenary:2dpath/sample
data modify storage catenary:calc 3dpath.2dpath set from storage catenary:calc 2dpath

execute store result score 3dpath.dx catenary.calc run data get storage catenary:calc 3dpath.dx 1000
execute store result score 3dpath.dy catenary.calc run data get storage catenary:calc 3dpath.dy 1000
execute store result score 3dpath.base_x catenary.calc run data get storage catenary:calc 3dpath.point1[0] 1000000
execute store result score 3dpath.base_y catenary.calc run data get storage catenary:calc 3dpath.point1[1] 1000
execute store result score 3dpath.base_z catenary.calc run data get storage catenary:calc 3dpath.point1[2] 1000000

data modify storage catenary:calc 3dpath.samples set value []
execute if data storage catenary:calc 2dpath.samples[0] run function catenary:3dpath/transform_2d_samples_loop