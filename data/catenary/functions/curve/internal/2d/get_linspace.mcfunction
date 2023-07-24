### TODO: move to curve
data modify storage catenary:calc 2dpath set value {}
scoreboard players operation 2dpath.ratio catenary.calc = #curve.2d.ratio catenary.calc
execute if score #curve.sag catenary.calc matches 1100 run function catenary:2dpath/get_params/generated_1_1/0_1000
execute if score #curve.sag catenary.calc matches 1050 run function catenary:2dpath/get_params/generated_1_05/0_1000
execute if score #curve.sag catenary.calc matches 1010 run function catenary:2dpath/get_params/generated_1_01/0_1000
execute store result score #curve.2d.a catenary.calc run data get storage catenary:calc 2dpath.params.a 1000
execute store result score #curve.2d.b catenary.calc run data get storage catenary:calc 2dpath.params.b 1000
execute store result score #curve.2d.c catenary.calc run data get storage catenary:calc 2dpath.params.c 1000
### END TODO

scoreboard players operation #curve.2d.a catenary.calc *= #curve.2d.dx catenary.calc
scoreboard players operation #curve.2d.b catenary.calc *= #curve.2d.dx catenary.calc
scoreboard players operation #curve.2d.c catenary.calc *= #curve.2d.dx catenary.calc
scoreboard players operation #curve.2d.a catenary.calc /= 1000 catenary.calc
scoreboard players operation #curve.2d.b catenary.calc /= 1000 catenary.calc
scoreboard players operation #curve.2d.c catenary.calc /= 1000 catenary.calc

scoreboard players set #curve.2d.x_prev catenary.calc 0
scoreboard players set #curve.2d.y_prev catenary.calc 0
scoreboard players set #curve.2d.l_cum catenary.calc 0

data modify storage catenary:calc curve.2d.linspace set value []
scoreboard players set #curve.2d.i catenary.calc -1
scoreboard players set #curve.2d.i_max catenary.calc 30
scoreboard players operation #curve.2d.i_max catenary.calc *= #curve.2d.dx catenary.calc
scoreboard players operation #curve.2d.i_max catenary.calc /= 1000 catenary.calc
execute if score #curve.2d.i_max catenary.calc matches ..500 run scoreboard players set #curve.2d.i_max catenary.calc 500
execute if score #curve.2d.i_max catenary.calc matches 3000.. run scoreboard players set #curve.2d.i_max catenary.calc 3000
function catenary:curve/internal/2d/make_linspace_loop