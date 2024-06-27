data modify storage catenary:calc curve.2d.linspace append value {}

### get next x ###
scoreboard players add #curve.2d.i catenary.calc 1
scoreboard players operation #curve.2d.x catenary.calc = #curve.2d.i catenary.calc
scoreboard players operation #curve.2d.x catenary.calc *= #curve.2d.dx catenary.calc
scoreboard players operation #curve.2d.x catenary.calc /= #curve.2d.i_max catenary.calc

execute store result storage catenary:calc curve.2d.linspace[-1].x float 0.001 run scoreboard players get #curve.2d.x catenary.calc

### get next y ###
scoreboard players operation #curve.temp catenary.calc = #curve.2d.x catenary.calc
scoreboard players operation #curve.temp catenary.calc -= #curve.2d.c catenary.calc
scoreboard players operation #curve.temp catenary.calc *= 10000 catenary.calc
scoreboard players operation #curve.temp catenary.calc /= #curve.2d.b catenary.calc
scoreboard players operation math.input catenary.calc = #curve.temp catenary.calc
scoreboard players operation math.input catenary.calc /= 10 catenary.calc
function catenary:math/cosh/start
execute store result score #curve.2d.y catenary.calc run data get storage catenary:calc math.output 10000
scoreboard players operation #curve.2d.y catenary.calc *= #curve.2d.b catenary.calc
scoreboard players operation #curve.2d.y catenary.calc /= 10000 catenary.calc
scoreboard players operation #curve.2d.y catenary.calc += #curve.2d.a catenary.calc

execute store result storage catenary:calc curve.2d.linspace[-1].y float 0.001 run scoreboard players get #curve.2d.y catenary.calc

### get length / distance ###
scoreboard players operation #curve.2d.l catenary.calc = #curve.2d.x catenary.calc
scoreboard players operation #curve.2d.l catenary.calc -= #curve.2d.x_prev catenary.calc
scoreboard players operation #curve.2d.l catenary.calc *= #curve.2d.l catenary.calc
scoreboard players operation #curve.temp catenary.calc = #curve.2d.y catenary.calc
scoreboard players operation #curve.temp catenary.calc -= #curve.2d.y_prev catenary.calc
scoreboard players operation #curve.temp catenary.calc *= #curve.temp catenary.calc
scoreboard players operation #curve.2d.l catenary.calc += #curve.temp catenary.calc
execute store result storage flop:api input float 1 run scoreboard players get #curve.2d.l catenary.calc
function flop:api/storage/sqrt
execute store result score #curve.2d.l catenary.calc run data get storage flop:api output 1000

# cumulative length
scoreboard players operation #curve.2d.l_cum catenary.calc += #curve.2d.l catenary.calc
execute store result storage catenary:calc curve.2d.linspace[-1].l_cum float 0.000001 run scoreboard players get #curve.2d.l_cum catenary.calc

### continue loop ###
scoreboard players operation #curve.2d.x_prev catenary.calc = #curve.2d.x catenary.calc
scoreboard players operation #curve.2d.y_prev catenary.calc = #curve.2d.y catenary.calc
execute if score #curve.2d.i catenary.calc < #curve.2d.i_max catenary.calc run function catenary:curve/internal/2d/make_linspace_loop