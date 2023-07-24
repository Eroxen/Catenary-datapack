data modify storage catenary:calc 2dpath.samples append value [0f,0f]
data modify storage catenary:calc 2dpath.samples[-1][0] set from storage catenary:calc 2dpath.sample.x[0]
data modify storage catenary:calc 2dpath.samples[-1][1] set from storage catenary:calc 2dpath.sample.y[0]

execute store result score #2dpath.sample.dx.1 catenary.calc run data get storage catenary:calc 2dpath.sample.x[0] 1000
execute store result score #2dpath.sample.dy.1 catenary.calc run data get storage catenary:calc 2dpath.sample.y[0] 1000
scoreboard players operation #2dpath.sample.dx.0 catenary.calc -= #2dpath.sample.dx.1 catenary.calc
scoreboard players operation #2dpath.sample.dy.0 catenary.calc -= #2dpath.sample.dy.1 catenary.calc
scoreboard players operation #2dpath.sample.dx.0 catenary.calc *= #2dpath.sample.dx.0 catenary.calc
scoreboard players operation #2dpath.sample.dy.0 catenary.calc *= #2dpath.sample.dy.0 catenary.calc
scoreboard players operation #2dpath.sample.dx.0 catenary.calc += #2dpath.sample.dy.0 catenary.calc
execute store result storage eroxified:api math.input float 0.000001 run scoreboard players get #2dpath.sample.dx.0 catenary.calc
function eroxified:api/math/float/sqrt
data modify storage catenary:calc 2dpath.samples_d append from storage eroxified:api math.output
scoreboard players operation #2dpath.sample.dx.0 catenary.calc = #2dpath.sample.dx.1 catenary.calc
scoreboard players operation #2dpath.sample.dy.0 catenary.calc = #2dpath.sample.dy.1 catenary.calc

scoreboard players add 2dpath.sample catenary.calc 1

scoreboard players operation 2dpath.next_sample catenary.calc = 2dpath.l catenary.calc
scoreboard players operation 2dpath.next_sample catenary.calc *= 2dpath.sample catenary.calc
scoreboard players operation 2dpath.next_sample catenary.calc /= 2dpath.samples catenary.calc