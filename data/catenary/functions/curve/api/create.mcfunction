#####################################################################
# curve/api/spawn.mcfunction
# written by Eroxen
#
# Creates a curve object in storage
#
# Storage input :
# - catenary:calc :
#   - create_curve :
#     - pos1 : begin point
#     - pos2 : end point
#     - sag : rope length = distance between points * sag
#
# Storage output :
# - catenary:calc :
#   - curve : curve object
#####################################################################
data modify storage catenary:calc curve set value {type:"catenary"}

### point 1 must be below or at the same height as point 2 ###
execute store result score #curve.3d.y1 catenary.calc run data get storage catenary:calc create_curve.pos1[1] 1000
execute store result score #curve.3d.y2 catenary.calc run data get storage catenary:calc create_curve.pos2[1] 1000
execute if score #curve.3d.y1 catenary.calc > #curve.3d.y2 catenary.calc run data modify storage catenary:calc temp set from storage catenary:calc create_curve.pos1
execute if score #curve.3d.y1 catenary.calc > #curve.3d.y2 catenary.calc run data modify storage catenary:calc create_curve.pos1 set from storage catenary:calc create_curve.pos2
execute if score #curve.3d.y1 catenary.calc > #curve.3d.y2 catenary.calc run data modify storage catenary:calc create_curve.pos2 set from storage catenary:calc temp
data modify storage catenary:calc curve.pos1 set from storage catenary:calc create_curve.pos1
data modify storage catenary:calc curve.pos2 set from storage catenary:calc create_curve.pos2

### get relative distances ###
execute store result score #curve.3d.x1 catenary.calc run data get storage catenary:calc create_curve.pos1[0] 1000
execute store result score #curve.3d.y1 catenary.calc run data get storage catenary:calc create_curve.pos1[1] 1000
execute store result score #curve.3d.z1 catenary.calc run data get storage catenary:calc create_curve.pos1[2] 1000
execute store result score #curve.3d.x2 catenary.calc run data get storage catenary:calc create_curve.pos2[0] 1000
execute store result score #curve.3d.y2 catenary.calc run data get storage catenary:calc create_curve.pos2[1] 1000
execute store result score #curve.3d.z2 catenary.calc run data get storage catenary:calc create_curve.pos2[2] 1000

scoreboard players operation #curve.2d.dy catenary.calc = #curve.3d.y2 catenary.calc
scoreboard players operation #curve.2d.dy catenary.calc -= #curve.3d.y1 catenary.calc
execute store result storage catenary:calc curve.2d.dy float 0.001 run scoreboard players get #curve.2d.dy catenary.calc
execute store result storage catenary:calc curve.3d.dy float 0.001 run scoreboard players get #curve.2d.dy catenary.calc

scoreboard players operation #curve.3d.dx catenary.calc = #curve.3d.x2 catenary.calc
scoreboard players operation #curve.3d.dx catenary.calc -= #curve.3d.x1 catenary.calc
execute store result storage catenary:calc curve.3d.dx float 0.001 run scoreboard players get #curve.3d.dx catenary.calc
scoreboard players operation #curve.3d.dx catenary.calc *= #curve.3d.dx catenary.calc
scoreboard players operation #curve.3d.dz catenary.calc = #curve.3d.z2 catenary.calc
scoreboard players operation #curve.3d.dz catenary.calc -= #curve.3d.z1 catenary.calc
execute store result storage catenary:calc curve.3d.dz float 0.001 run scoreboard players get #curve.3d.dz catenary.calc
scoreboard players operation #curve.3d.dz catenary.calc *= #curve.3d.dz catenary.calc
scoreboard players operation #curve.2d.dx catenary.calc = #curve.3d.dx catenary.calc
scoreboard players operation #curve.2d.dx catenary.calc += #curve.3d.dz catenary.calc
execute store result storage eroxified:api math.input float 0.000001 run scoreboard players get #curve.2d.dx catenary.calc
function eroxified:api/math/float/sqrt
execute store result score #curve.2d.dx catenary.calc run data get storage eroxified:api math.output 1000
execute store result storage catenary:calc curve.2d.dx float 0.001 run scoreboard players get #curve.2d.dx catenary.calc

### get horizontal/vertical ratio (max allowed=1000) ###
scoreboard players operation #curve.2d.ratio catenary.calc = #curve.2d.dy catenary.calc
scoreboard players operation #curve.2d.ratio catenary.calc *= 100 catenary.calc
scoreboard players operation #curve.2d.ratio catenary.calc /= #curve.2d.dx catenary.calc
# if the slope is too steep, set the curve type to a straight line
execute if score #curve.2d.ratio catenary.calc matches 1001.. run data modify storage catenary:calc create_curve.sag set value 1.0f

### create curve ###
## get sag ##
execute store result score #curve.sag catenary.calc run data get storage catenary:calc create_curve.sag 1000
execute if score #curve.sag catenary.calc matches 990..1005 run scoreboard players set #curve.sag catenary.calc 1000
execute if score #curve.sag catenary.calc matches 1005..1030 run scoreboard players set #curve.sag catenary.calc 1010
execute if score #curve.sag catenary.calc matches 1030..1070 run scoreboard players set #curve.sag catenary.calc 1050
execute if score #curve.sag catenary.calc matches 1070..1200 run scoreboard players set #curve.sag catenary.calc 1100
execute unless score #curve.sag catenary.calc matches 1000..1100 run scoreboard players set #curve.sag catenary.calc 1050

execute if score #curve.sag catenary.calc matches 1000 run data modify storage catenary:calc curve.type set value "straight"
execute if data storage catenary:calc curve{type:"catenary"} run function catenary:curve/internal/2d/get_linspace