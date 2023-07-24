execute store result score 2dpath.x catenary.calc run data get storage catenary:calc 2dpath.eval[0] 1000
data remove storage catenary:calc 2dpath.eval[0]

scoreboard players operation 2dpath.lx catenary.calc = 2dpath.x catenary.calc
scoreboard players operation 2dpath.lx catenary.calc -= 2dpath.prev_x catenary.calc
scoreboard players operation 2dpath.lx catenary.calc *= 2dpath.lx catenary.calc
scoreboard players operation 2dpath.prev_x catenary.calc = 2dpath.x catenary.calc


scoreboard players operation 2dpath.x catenary.calc -= 2dpath.c catenary.calc
scoreboard players operation 2dpath.x catenary.calc *= 1000 catenary.calc
scoreboard players operation 2dpath.x catenary.calc /= 2dpath.b catenary.calc
execute store result storage eroxified:api math.input float 0.001 run scoreboard players get 2dpath.x catenary.calc
function eroxified:api/math/trig/cosh
execute store result score 2dpath.x catenary.calc run data get storage eroxified:api math.output 1000
scoreboard players operation 2dpath.x catenary.calc *= 2dpath.b catenary.calc
scoreboard players operation 2dpath.x catenary.calc /= 1000 catenary.calc
scoreboard players operation 2dpath.x catenary.calc += 2dpath.a catenary.calc

data modify storage catenary:calc 2dpath.y append value 0f
execute store result storage catenary:calc 2dpath.y[-1] float 0.001 run scoreboard players get 2dpath.x catenary.calc


scoreboard players operation 2dpath.ly catenary.calc = 2dpath.x catenary.calc
scoreboard players operation 2dpath.ly catenary.calc -= 2dpath.prev_y catenary.calc
scoreboard players operation 2dpath.ly catenary.calc *= 2dpath.ly catenary.calc
scoreboard players operation 2dpath.prev_y catenary.calc = 2dpath.x catenary.calc


scoreboard players operation 2dpath.lx catenary.calc += 2dpath.ly catenary.calc
execute store result storage eroxified:api math.input float 1 run scoreboard players get 2dpath.lx catenary.calc
function eroxified:api/math/float/sqrt
execute store result storage eroxified:api math.output float 0.0000001 run data get storage eroxified:api math.output 10000
data modify storage catenary:calc 2dpath.l append from storage eroxified:api math.output
execute store result score 2dpath.lx catenary.calc run data get storage eroxified:api math.output 1000
scoreboard players operation 2dpath.l catenary.calc += 2dpath.lx catenary.calc
data modify storage catenary:calc 2dpath.l_cum append value 0f
execute store result storage catenary:calc 2dpath.l_cum[-1] float 0.001 run scoreboard players get 2dpath.l catenary.calc

execute if data storage catenary:calc 2dpath.eval[0] run function catenary:2dpath/eval_catenary_loop