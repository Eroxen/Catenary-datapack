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
#     - sag : integer between 0 and 3. The higher, the saggier the rope.
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
execute if score #curve.3d.y1 catenary.calc > #curve.3d.y2 catenary.calc run data modify storage catenary:calc curve.swapped_points set value 1b
data modify storage catenary:calc curve.pos1 set from storage catenary:calc create_curve.pos1
data modify storage catenary:calc curve.pos2 set from storage catenary:calc create_curve.pos2

### get relative distances ###
data modify storage flop:api input set from storage catenary:calc create_curve.pos1[0]
function flop:api/storage/read_as_compact
scoreboard players operation #curve.3d.x1 catenary.calc = input.compact flop
data modify storage flop:api input set from storage catenary:calc create_curve.pos1[1]
function flop:api/storage/read_as_compact
scoreboard players operation #curve.3d.y1 catenary.calc = input.compact flop
data modify storage flop:api input set from storage catenary:calc create_curve.pos1[2]
function flop:api/storage/read_as_compact
scoreboard players operation #curve.3d.z1 catenary.calc = input.compact flop
data modify storage flop:api input set from storage catenary:calc create_curve.pos2[0]
function flop:api/storage/read_as_compact
scoreboard players operation #curve.3d.x2 catenary.calc = input.compact flop
data modify storage flop:api input set from storage catenary:calc create_curve.pos2[1]
function flop:api/storage/read_as_compact
scoreboard players operation #curve.3d.y2 catenary.calc = input.compact flop
data modify storage flop:api input set from storage catenary:calc create_curve.pos2[2]
function flop:api/storage/read_as_compact
scoreboard players operation #curve.3d.z2 catenary.calc = input.compact flop

scoreboard players operation operand.a.compact flop = #curve.3d.y2 catenary.calc
scoreboard players operation operand.b.compact flop = #curve.3d.y1 catenary.calc
function flop:api/compact/subtract
scoreboard players operation #curve.2d.dy catenary.calc = output.compact flop
function flop:api/eroxifloat/write_to_float
data modify storage catenary:calc curve.2d.dy set from storage flop:api output
data modify storage catenary:calc curve.3d.dy set from storage flop:api output


scoreboard players operation operand.a.compact flop = #curve.3d.x2 catenary.calc
scoreboard players operation operand.b.compact flop = #curve.3d.x1 catenary.calc
function flop:api/compact/subtract
function flop:api/eroxifloat/write_to_float
data modify storage catenary:calc curve.3d.dx set from storage flop:api output
scoreboard players operation input.compact flop = output.compact flop
function flop:api/compact/square
scoreboard players operation #curve.3d.dx catenary.calc = output.compact flop

scoreboard players operation operand.a.compact flop = #curve.3d.z2 catenary.calc
scoreboard players operation operand.b.compact flop = #curve.3d.z1 catenary.calc
function flop:api/compact/subtract
function flop:api/eroxifloat/write_to_float
data modify storage catenary:calc curve.3d.dz set from storage flop:api output
scoreboard players operation input.compact flop = output.compact flop
function flop:api/compact/square
scoreboard players operation #curve.3d.dz catenary.calc = output.compact flop

scoreboard players operation operand.a.compact flop = #curve.3d.dx catenary.calc
scoreboard players operation operand.b.compact flop = #curve.3d.dz catenary.calc
function flop:api/compact/add
function flop:api/eroxifloat/write_to_float
scoreboard players operation input.compact flop = output.compact flop
function flop:api/compact/sqrt
scoreboard players operation #curve.2d.dx catenary.calc = output.compact flop
function flop:api/eroxifloat/write_to_float
data modify storage catenary:calc curve.2d.dx set from storage flop:api output

### get horizontal/vertical ratio (max allowed=1000) ###
scoreboard players operation operand.a.compact flop = #curve.2d.dy catenary.calc
scoreboard players operation operand.b.compact flop = #curve.2d.dx catenary.calc
function flop:api/compact/divide
function flop:api/eroxifloat/write_to_float
execute store result score #curve.2d.ratio catenary.calc run data get storage flop:api output 100



# if the slope is too steep, set the curve type to a straight line
execute if score #curve.2d.ratio catenary.calc matches 1001.. run data modify storage catenary:calc create_curve.sag set value 0

### get scaled numbers ###
execute store result score #curve.3d.x1 catenary.calc run data get storage catenary:calc create_curve.pos1[0] 1000
execute store result score #curve.3d.y1 catenary.calc run data get storage catenary:calc create_curve.pos1[1] 1000
execute store result score #curve.3d.z1 catenary.calc run data get storage catenary:calc create_curve.pos1[2] 1000
execute store result score #curve.3d.x2 catenary.calc run data get storage catenary:calc create_curve.pos2[0] 1000
execute store result score #curve.3d.y2 catenary.calc run data get storage catenary:calc create_curve.pos2[1] 1000
execute store result score #curve.3d.z2 catenary.calc run data get storage catenary:calc create_curve.pos2[2] 1000
execute store result score #curve.3d.dx catenary.calc run data get storage catenary:calc curve.3d.dx 1000
execute store result score #curve.3d.dy catenary.calc run data get storage catenary:calc curve.3d.dy 1000
execute store result score #curve.3d.dz catenary.calc run data get storage catenary:calc curve.3d.dz 1000
execute store result score #curve.2d.dx catenary.calc run data get storage catenary:calc curve.2d.dx 1000
execute store result score #curve.2d.dy catenary.calc run data get storage catenary:calc curve.2d.dy 1000




### create curve ###
## get sag ##
scoreboard players set #curve.sag catenary.calc 1100
execute store result score #curve.sag_i catenary.calc run data get storage catenary:calc create_curve.sag 1
execute if score #curve.sag_i catenary.calc matches ..0 run scoreboard players set #curve.sag catenary.calc 1000
execute if score #curve.sag_i catenary.calc matches 1 run scoreboard players set #curve.sag catenary.calc 1010
execute if score #curve.sag_i catenary.calc matches 2 run scoreboard players set #curve.sag catenary.calc 1050
execute if score #curve.sag_i catenary.calc matches 3.. run scoreboard players set #curve.sag catenary.calc 1100

execute if score #curve.sag catenary.calc matches 1000 run data modify storage catenary:calc curve.type set value "straight"
execute if data storage catenary:calc curve{type:"catenary"} run function catenary:curve/internal/2d/get_linspace