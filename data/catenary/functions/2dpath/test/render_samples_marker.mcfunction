data modify storage catenary:calc 2dpath.render_pos set from entity @s Pos
execute store result score 2dpath.base_x catenary.calc run data get storage catenary:calc 2dpath.render_pos[0] 1000
execute store result score 2dpath.base_y catenary.calc run data get storage catenary:calc 2dpath.render_pos[1] 1000

data modify storage catenary:calc 2dpath.render set from storage catenary:calc 2dpath.samples

execute if data storage catenary:calc 2dpath.render[0] run function catenary:2dpath/test/render_samples_marker_loop

kill @s