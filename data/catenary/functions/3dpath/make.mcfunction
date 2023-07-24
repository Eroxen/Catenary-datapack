# point 1 must be below or at the same height as point 2
execute store result score 3dpath.y1 catenary.calc run data get storage catenary:calc 3dpath.point1[1] 1000
execute store result score 3dpath.y2 catenary.calc run data get storage catenary:calc 3dpath.point2[1] 1000
execute if score 3dpath.y1 catenary.calc > 3dpath.y2 catenary.calc run data modify storage catenary:calc temp set from storage catenary:calc 3dpath.point1
execute if score 3dpath.y1 catenary.calc > 3dpath.y2 catenary.calc run data modify storage catenary:calc 3dpath.point1 set from storage catenary:calc 3dpath.point2
execute if score 3dpath.y1 catenary.calc > 3dpath.y2 catenary.calc run data modify storage catenary:calc 3dpath.point2 set from storage catenary:calc temp

execute store result score 3dpath.x1 catenary.calc run data get storage catenary:calc 3dpath.point1[0] 1000
execute store result score 3dpath.y1 catenary.calc run data get storage catenary:calc 3dpath.point1[1] 1000
execute store result score 3dpath.z1 catenary.calc run data get storage catenary:calc 3dpath.point1[2] 1000
execute store result score 3dpath.x2 catenary.calc run data get storage catenary:calc 3dpath.point2[0] 1000
execute store result score 3dpath.y2 catenary.calc run data get storage catenary:calc 3dpath.point2[1] 1000
execute store result score 3dpath.z2 catenary.calc run data get storage catenary:calc 3dpath.point2[2] 1000

scoreboard players operation 2dpath.dy catenary.calc = 3dpath.y2 catenary.calc
scoreboard players operation 2dpath.dy catenary.calc -= 3dpath.y1 catenary.calc

scoreboard players operation 3dpath.dx catenary.calc = 3dpath.x2 catenary.calc
scoreboard players operation 3dpath.dx catenary.calc -= 3dpath.x1 catenary.calc
scoreboard players operation 3dpath.dx catenary.calc *= 3dpath.dx catenary.calc
scoreboard players operation 3dpath.dz catenary.calc = 3dpath.z2 catenary.calc
scoreboard players operation 3dpath.dz catenary.calc -= 3dpath.z1 catenary.calc
scoreboard players operation 3dpath.dz catenary.calc *= 3dpath.dz catenary.calc
scoreboard players operation 2dpath.dx catenary.calc = 3dpath.dx catenary.calc
scoreboard players operation 2dpath.dx catenary.calc += 3dpath.dz catenary.calc
execute store result storage eroxified:api math.input float 0.000001 run scoreboard players get 2dpath.dx catenary.calc
function eroxified:api/math/float/sqrt
execute store result score 2dpath.dx catenary.calc run data get storage eroxified:api math.output 1000


scoreboard players operation 3dpath.dx catenary.calc = 3dpath.x2 catenary.calc
scoreboard players operation 3dpath.dx catenary.calc -= 3dpath.x1 catenary.calc
scoreboard players operation 3dpath.dx catenary.calc *= 1000 catenary.calc
scoreboard players operation 3dpath.dx catenary.calc /= 2dpath.dx catenary.calc

scoreboard players operation 3dpath.dz catenary.calc = 3dpath.z2 catenary.calc
scoreboard players operation 3dpath.dz catenary.calc -= 3dpath.z1 catenary.calc
scoreboard players operation 3dpath.dz catenary.calc *= 1000 catenary.calc
scoreboard players operation 3dpath.dz catenary.calc /= 2dpath.dx catenary.calc

execute store result storage catenary:calc 3dpath.dx float 0.001 run scoreboard players get 3dpath.dx catenary.calc
execute store result storage catenary:calc 3dpath.dz float 0.001 run scoreboard players get 3dpath.dz catenary.calc

########

function catenary:2dpath/calculate
data modify storage catenary:calc 3dpath.2dpath set from storage catenary:calc 2dpath

function catenary:3dpath/sample