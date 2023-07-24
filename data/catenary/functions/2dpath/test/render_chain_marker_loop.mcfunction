execute at @s run function catenary:test/point1

execute store result score 2dpath.x catenary.calc run data get storage catenary:calc 2dpath.render[0][0] 1000
execute store result score 2dpath.y catenary.calc run data get storage catenary:calc 2dpath.render[0][1] 1000
data remove storage catenary:calc 2dpath.render[0]
scoreboard players operation 2dpath.x catenary.calc += 2dpath.base_x catenary.calc
scoreboard players operation 2dpath.y catenary.calc += 2dpath.base_y catenary.calc

execute store result storage catenary:calc 2dpath.render_pos[0] double 0.001 run scoreboard players get 2dpath.x catenary.calc
execute store result storage catenary:calc 2dpath.render_pos[1] double 0.001 run scoreboard players get 2dpath.y catenary.calc

data modify entity @s Pos set from storage catenary:calc 2dpath.render_pos
execute at @s run function catenary:test/point2
function catenary:test/connect_points
data modify entity @e[type=block_display,tag=catenary.test.connecting_line,limit=1,sort=nearest] Tags set value ["catenary.render_chain"]

execute if data storage catenary:calc 2dpath.render[0] run function catenary:2dpath/test/render_chain_marker_loop