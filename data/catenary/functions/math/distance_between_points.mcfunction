#####################################################################
# math/distance_between_points.mcfunction
# written by Eroxen
#
# Returns 1000 * the Euclidian distance between 2 points
#
# Storage input :
# - catenary:calc :
#   - math :
#     - point1 : point 1
#     - point2 : point 2
#
# Scoreboard output :
# - catenary.calc :
#   - #math.distance : distance
#####################################################################

execute store result score #math.temp.1 catenary.calc run data get storage catenary:calc math.point1[0] 1000
execute store result score #math.temp.2 catenary.calc run data get storage catenary:calc math.point2[0] 1000
scoreboard players operation #math.temp.1 catenary.calc -= #math.temp.2 catenary.calc
execute store result storage eroxified:api math.input float 0.001 run scoreboard players get #math.temp.1 catenary.calc
function eroxified:api/math/float/square
execute store result score #math.distance catenary.calc run data get storage eroxified:api math.output 1000

execute store result score #math.temp.1 catenary.calc run data get storage catenary:calc math.point1[1] 1000
execute store result score #math.temp.2 catenary.calc run data get storage catenary:calc math.point2[1] 1000
scoreboard players operation #math.temp.1 catenary.calc -= #math.temp.2 catenary.calc
execute store result storage eroxified:api math.input float 0.001 run scoreboard players get #math.temp.1 catenary.calc
function eroxified:api/math/float/square
execute store result score #math.temp.1 catenary.calc run data get storage eroxified:api math.output 1000
scoreboard players operation #math.distance catenary.calc += #math.temp.1 catenary.calc

execute store result score #math.temp.1 catenary.calc run data get storage catenary:calc math.point1[2] 1000
execute store result score #math.temp.2 catenary.calc run data get storage catenary:calc math.point2[2] 1000
scoreboard players operation #math.temp.1 catenary.calc -= #math.temp.2 catenary.calc
execute store result storage eroxified:api math.input float 0.001 run scoreboard players get #math.temp.1 catenary.calc
function eroxified:api/math/float/square
execute store result score #math.temp.1 catenary.calc run data get storage eroxified:api math.output 1000
scoreboard players operation #math.distance catenary.calc += #math.temp.1 catenary.calc

execute store result storage eroxified:api math.input float 0.001 run scoreboard players get #math.distance catenary.calc
function eroxified:api/math/float/sqrt
execute store result score #math.distance catenary.calc run data get storage eroxified:api math.output 1000