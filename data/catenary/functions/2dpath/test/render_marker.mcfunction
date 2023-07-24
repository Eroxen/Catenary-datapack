data modify storage catenary:calc 2dpath.render_pos set from entity @s Pos
execute store result score 2dpath.base_x catenary.calc run data get storage catenary:calc 2dpath.render_pos[0] 1000
execute store result score 2dpath.base_y catenary.calc run data get storage catenary:calc 2dpath.render_pos[1] 1000

data modify storage catenary:calc 2dpath.render_x set from storage catenary:calc 2dpath.x
data modify storage catenary:calc 2dpath.render_y set from storage catenary:calc 2dpath.y

execute if data storage catenary:calc 2dpath.render_x[0] run function catenary:2dpath/test/render_marker_loop

kill @s