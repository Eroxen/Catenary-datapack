data modify storage catenary:calc curve.2d.sampled set from storage catenary:calc curve.2d.sample[0]

execute store result score #curve.2d.sample.dx.1 catenary.calc run data get storage catenary:calc curve.2d.sample[0].x 1000
execute store result score #curve.2d.sample.dy.1 catenary.calc run data get storage catenary:calc curve.2d.sample[0].y 1000
scoreboard players operation #curve.2d.sample.dx.0 catenary.calc -= #curve.2d.sample.dx.1 catenary.calc
scoreboard players operation #curve.2d.sample.dy.0 catenary.calc -= #curve.2d.sample.dy.1 catenary.calc
scoreboard players operation #curve.2d.sample.dx.0 catenary.calc *= #curve.2d.sample.dx.0 catenary.calc
scoreboard players operation #curve.2d.sample.dy.0 catenary.calc *= #curve.2d.sample.dy.0 catenary.calc
scoreboard players operation #curve.2d.sample.dx.0 catenary.calc += #curve.2d.sample.dy.0 catenary.calc
execute store result storage eroxified:api math.input float 0.000001 run scoreboard players get #curve.2d.sample.dx.0 catenary.calc
function eroxified:api/math/float/sqrt
data modify storage catenary:calc curve.2d.sampled.distance set from storage eroxified:api math.output
scoreboard players operation #curve.2d.sample.dx.0 catenary.calc = #curve.2d.sample.dx.1 catenary.calc
scoreboard players operation #curve.2d.sample.dy.0 catenary.calc = #curve.2d.sample.dy.1 catenary.calc

scoreboard players add #curve.2d.sample catenary.calc 1

scoreboard players operation #curve.2d.sample.next catenary.calc = #curve.2d.length catenary.calc
scoreboard players operation #curve.2d.sample.next catenary.calc *= #curve.2d.sample catenary.calc
scoreboard players operation #curve.2d.sample.next catenary.calc /= #curve.2d.samples catenary.calc

function catenary:curve/internal/3d/transform_2d_sample