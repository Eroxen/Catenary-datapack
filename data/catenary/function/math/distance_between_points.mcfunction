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

data modify storage flop:api input set from storage catenary:calc math.point1[0]
function flop:api/storage/read_as_eroxifloat
scoreboard players operation operand.a.sign flop = input.sign flop
scoreboard players operation operand.a.exponent flop = input.exponent flop
scoreboard players operation operand.a.mantissa flop = input.mantissa flop
data modify storage flop:api input set from storage catenary:calc math.point2[0]
function flop:api/storage/read_as_eroxifloat
scoreboard players operation operand.b.sign flop = input.sign flop
scoreboard players operation operand.b.exponent flop = input.exponent flop
scoreboard players operation operand.b.mantissa flop = input.mantissa flop
function flop:api/eroxifloat/subtract
scoreboard players operation input.sign flop = output.sign flop
scoreboard players operation input.exponent flop = output.exponent flop
scoreboard players operation input.mantissa flop = output.mantissa flop
function flop:api/eroxifloat/square
scoreboard players operation #math.distance.1.s catenary.calc = output.sign flop
scoreboard players operation #math.distance.1.e catenary.calc = output.exponent flop
scoreboard players operation #math.distance.1.m catenary.calc = output.mantissa flop

data modify storage flop:api input set from storage catenary:calc math.point1[1]
function flop:api/storage/read_as_eroxifloat
scoreboard players operation operand.a.sign flop = input.sign flop
scoreboard players operation operand.a.exponent flop = input.exponent flop
scoreboard players operation operand.a.mantissa flop = input.mantissa flop
data modify storage flop:api input set from storage catenary:calc math.point2[1]
function flop:api/storage/read_as_eroxifloat
scoreboard players operation operand.b.sign flop = input.sign flop
scoreboard players operation operand.b.exponent flop = input.exponent flop
scoreboard players operation operand.b.mantissa flop = input.mantissa flop
function flop:api/eroxifloat/subtract
scoreboard players operation input.sign flop = output.sign flop
scoreboard players operation input.exponent flop = output.exponent flop
scoreboard players operation input.mantissa flop = output.mantissa flop
function flop:api/eroxifloat/square
scoreboard players operation #math.distance.2.s catenary.calc = output.sign flop
scoreboard players operation #math.distance.2.e catenary.calc = output.exponent flop
scoreboard players operation #math.distance.2.m catenary.calc = output.mantissa flop

data modify storage flop:api input set from storage catenary:calc math.point1[2]
function flop:api/storage/read_as_eroxifloat
scoreboard players operation operand.a.sign flop = input.sign flop
scoreboard players operation operand.a.exponent flop = input.exponent flop
scoreboard players operation operand.a.mantissa flop = input.mantissa flop
data modify storage flop:api input set from storage catenary:calc math.point2[2]
function flop:api/storage/read_as_eroxifloat
scoreboard players operation operand.b.sign flop = input.sign flop
scoreboard players operation operand.b.exponent flop = input.exponent flop
scoreboard players operation operand.b.mantissa flop = input.mantissa flop
function flop:api/eroxifloat/subtract
scoreboard players operation input.sign flop = output.sign flop
scoreboard players operation input.exponent flop = output.exponent flop
scoreboard players operation input.mantissa flop = output.mantissa flop
function flop:api/eroxifloat/square


scoreboard players operation operand.a.sign flop = output.sign flop
scoreboard players operation operand.a.exponent flop = output.exponent flop
scoreboard players operation operand.a.mantissa flop = output.mantissa flop
scoreboard players operation operand.b.sign flop = #math.distance.1.s catenary.calc
scoreboard players operation operand.b.exponent flop = #math.distance.1.e catenary.calc
scoreboard players operation operand.b.mantissa flop = #math.distance.1.m catenary.calc
function flop:api/eroxifloat/add
scoreboard players operation operand.a.sign flop = output.sign flop
scoreboard players operation operand.a.exponent flop = output.exponent flop
scoreboard players operation operand.a.mantissa flop = output.mantissa flop
scoreboard players operation operand.b.sign flop = #math.distance.2.s catenary.calc
scoreboard players operation operand.b.exponent flop = #math.distance.2.e catenary.calc
scoreboard players operation operand.b.mantissa flop = #math.distance.2.m catenary.calc
function flop:api/eroxifloat/add
scoreboard players operation input.sign flop = output.sign flop
scoreboard players operation input.exponent flop = output.exponent flop
scoreboard players operation input.mantissa flop = output.mantissa flop
function flop:api/eroxifloat/sqrt
function flop:api/eroxifloat/write_to_double

execute store result score #math.distance catenary.calc run data get storage flop:api output 1000