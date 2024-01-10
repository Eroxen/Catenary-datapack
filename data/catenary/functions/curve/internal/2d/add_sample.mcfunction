data modify storage catenary:calc curve.2d.sampled set from storage catenary:calc curve.2d.sample[0]

execute store result score #curve.2d.sample.dx.1 catenary.calc run data get storage catenary:calc curve.2d.sample[0].x 1000
execute store result score #curve.2d.sample.dy.1 catenary.calc run data get storage catenary:calc curve.2d.sample[0].y 1000
## correct for bias ##
scoreboard players operation #curve.2d.bias.add catenary.calc = #curve.2d.sample.dx.1 catenary.calc
scoreboard players operation #curve.2d.bias.add catenary.calc *= #curve.2d.bias.y.x_shift catenary.calc
scoreboard players operation #curve.2d.bias.add catenary.calc /= #curve.2d.bias.x.1 catenary.calc
scoreboard players operation #curve.2d.bias.add catenary.calc -= #curve.2d.bias.y.actual.0 catenary.calc
scoreboard players operation #curve.2d.sample.dy.1 catenary.calc += #curve.2d.bias.add catenary.calc
execute store result storage catenary:calc curve.2d.sampled.y double 0.001 run scoreboard players get #curve.2d.sample.dy.1 catenary.calc

scoreboard players operation #curve.2d.sample.dx.0 catenary.calc -= #curve.2d.sample.dx.1 catenary.calc
scoreboard players operation #curve.2d.sample.dy.0 catenary.calc -= #curve.2d.sample.dy.1 catenary.calc
scoreboard players operation #curve.2d.sample.dx.0 catenary.calc *= #curve.2d.sample.dx.0 catenary.calc
scoreboard players operation #curve.2d.sample.dy.0 catenary.calc *= #curve.2d.sample.dy.0 catenary.calc
scoreboard players operation #curve.2d.sample.dx.0 catenary.calc += #curve.2d.sample.dy.0 catenary.calc
execute store result storage flop:api input float 0.000001 run scoreboard players get #curve.2d.sample.dx.0 catenary.calc
function flop:api/storage/sqrt
data modify storage catenary:calc curve.2d.sampled.distance set from storage flop:api output
scoreboard players operation #curve.2d.sample.dx.0 catenary.calc = #curve.2d.sample.dx.1 catenary.calc
scoreboard players operation #curve.2d.sample.dy.0 catenary.calc = #curve.2d.sample.dy.1 catenary.calc

scoreboard players add #curve.2d.sample catenary.calc 1

scoreboard players operation #curve.2d.sample.next catenary.calc = #curve.2d.length catenary.calc
scoreboard players operation #curve.2d.sample.next catenary.calc *= #curve.2d.sample catenary.calc
scoreboard players operation #curve.2d.sample.next catenary.calc /= #curve.2d.samples catenary.calc

function catenary:curve/internal/3d/transform_2d_sample