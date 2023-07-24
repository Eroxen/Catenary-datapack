#scoreboard players set 2dpath.dx catenary.calc 15000
#scoreboard players set 2dpath.dy catenary.calc 15000
#scoreboard players set 2dpath.sag catenary.calc 1100
scoreboard players set 2dpath.l catenary.calc 0

data modify storage catenary:calc 2dpath set value {}
scoreboard players operation 2dpath.ratio catenary.calc = 2dpath.dy catenary.calc
scoreboard players operation 2dpath.ratio catenary.calc *= 100 catenary.calc
scoreboard players operation 2dpath.ratio catenary.calc /= 2dpath.dx catenary.calc
execute if score 2dpath.sag catenary.calc matches 1100 run function catenary:2dpath/get_params/generated_1_1/0_1000
execute if score 2dpath.sag catenary.calc matches 1050 run function catenary:2dpath/get_params/generated_1_05/0_1000
execute if score 2dpath.sag catenary.calc matches 1010 run function catenary:2dpath/get_params/generated_1_01/0_1000
execute store result score 2dpath.a catenary.calc run data get storage catenary:calc 2dpath.params.a 1000
execute store result score 2dpath.b catenary.calc run data get storage catenary:calc 2dpath.params.b 1000
execute store result score 2dpath.c catenary.calc run data get storage catenary:calc 2dpath.params.c 1000
scoreboard players operation 2dpath.a catenary.calc *= 2dpath.dx catenary.calc
scoreboard players operation 2dpath.b catenary.calc *= 2dpath.dx catenary.calc
scoreboard players operation 2dpath.c catenary.calc *= 2dpath.dx catenary.calc
scoreboard players operation 2dpath.a catenary.calc /= 1000 catenary.calc
scoreboard players operation 2dpath.b catenary.calc /= 1000 catenary.calc
scoreboard players operation 2dpath.c catenary.calc /= 1000 catenary.calc

data modify storage catenary:calc 2dpath.x set value []
scoreboard players set 2dpath.linspace.i catenary.calc -1
scoreboard players set 2dpath.linspace.max_i catenary.calc 500
execute if score 2dpath.linspace.i catenary.calc < 2dpath.linspace.max_i catenary.calc run function catenary:2dpath/linspace_loop
data modify storage catenary:calc 2dpath.y set value []
data modify storage catenary:calc 2dpath.l set value []
data modify storage catenary:calc 2dpath.l_cum set value []
scoreboard players set 2dpath.prev_x catenary.calc 0
scoreboard players set 2dpath.prev_y catenary.calc 0
data modify storage catenary:calc 2dpath.eval set from storage catenary:calc 2dpath.x
execute if data storage catenary:calc 2dpath.eval[0] run function catenary:2dpath/eval_catenary_loop