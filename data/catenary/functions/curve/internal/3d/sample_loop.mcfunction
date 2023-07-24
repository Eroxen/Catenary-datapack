scoreboard players operation #curve.3d.x catenary.calc = #curve.3d.dx catenary.calc
scoreboard players operation #curve.3d.x catenary.calc *= #curve.3d.sample catenary.calc
scoreboard players operation #curve.3d.x catenary.calc /= #curve.3d.samples catenary.calc
scoreboard players operation #curve.3d.x catenary.calc += #curve.3d.x1 catenary.calc
scoreboard players operation #curve.3d.y catenary.calc = #curve.3d.dy catenary.calc
scoreboard players operation #curve.3d.y catenary.calc *= #curve.3d.sample catenary.calc
scoreboard players operation #curve.3d.y catenary.calc /= #curve.3d.samples catenary.calc
scoreboard players operation #curve.3d.y catenary.calc += #curve.3d.y1 catenary.calc
scoreboard players operation #curve.3d.z catenary.calc = #curve.3d.dz catenary.calc
scoreboard players operation #curve.3d.z catenary.calc *= #curve.3d.sample catenary.calc
scoreboard players operation #curve.3d.z catenary.calc /= #curve.3d.samples catenary.calc
scoreboard players operation #curve.3d.z catenary.calc += #curve.3d.z1 catenary.calc

data modify storage catenary:calc curve.3d.samples append value {pos:[0d,0d,0d]}
execute store result storage catenary:calc curve.3d.samples[-1].pos[0] double 0.001 run scoreboard players get #curve.3d.x catenary.calc
execute store result storage catenary:calc curve.3d.samples[-1].pos[1] double 0.001 run scoreboard players get #curve.3d.y catenary.calc
execute store result storage catenary:calc curve.3d.samples[-1].pos[2] double 0.001 run scoreboard players get #curve.3d.z catenary.calc
execute store result storage catenary:calc curve.3d.samples[-1].distance float 0.001 run scoreboard players get #curve.3d.sample.distance catenary.calc

scoreboard players add #curve.3d.sample catenary.calc 1

execute if score #curve.3d.sample catenary.calc <= #curve.3d.samples catenary.calc run function catenary:curve/internal/3d/sample_loop