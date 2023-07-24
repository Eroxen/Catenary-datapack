scoreboard players add 2dpath.linspace.i catenary.calc 1

scoreboard players operation 2dpath.x catenary.calc = 2dpath.linspace.i catenary.calc
scoreboard players operation 2dpath.x catenary.calc *= 2dpath.dx catenary.calc
scoreboard players operation 2dpath.x catenary.calc /= 2dpath.linspace.max_i catenary.calc

data modify storage catenary:calc 2dpath.x append value 0f
execute store result storage catenary:calc 2dpath.x[-1] float 0.001 run scoreboard players get 2dpath.x catenary.calc

execute if score 2dpath.linspace.i catenary.calc < 2dpath.linspace.max_i catenary.calc run function catenary:2dpath/linspace_loop