### setup for 3d transformation ###
data modify storage flop:api operand.a set from storage catenary:calc curve.3d.dx
data modify storage flop:api operand.b set from storage catenary:calc curve.2d.dx
function flop:api/storage/divide
scoreboard players operation #curve.3d.dx.s catenary.calc = output.sign flop
scoreboard players operation #curve.3d.dx.e catenary.calc = output.exponent flop
scoreboard players operation #curve.3d.dx.m catenary.calc = output.mantissa flop

data modify storage flop:api operand.a set from storage catenary:calc curve.3d.dz
data modify storage flop:api operand.b set from storage catenary:calc curve.2d.dx
function flop:api/storage/divide
scoreboard players operation #curve.3d.dz.s catenary.calc = output.sign flop
scoreboard players operation #curve.3d.dz.e catenary.calc = output.exponent flop
scoreboard players operation #curve.3d.dz.m catenary.calc = output.mantissa flop

data modify storage flop:api input set from storage catenary:calc curve.pos1[0]
function flop:api/storage/read_as_eroxifloat
scoreboard players operation #curve.3d.base_x.s catenary.calc = input.sign flop
scoreboard players operation #curve.3d.base_x.e catenary.calc = input.exponent flop
scoreboard players operation #curve.3d.base_x.m catenary.calc = input.mantissa flop

data modify storage flop:api input set from storage catenary:calc curve.pos1[1]
function flop:api/storage/read_as_eroxifloat
scoreboard players operation #curve.3d.base_y.s catenary.calc = input.sign flop
scoreboard players operation #curve.3d.base_y.e catenary.calc = input.exponent flop
scoreboard players operation #curve.3d.base_y.m catenary.calc = input.mantissa flop

data modify storage flop:api input set from storage catenary:calc curve.pos1[2]
function flop:api/storage/read_as_eroxifloat
scoreboard players operation #curve.3d.base_z.s catenary.calc = input.sign flop
scoreboard players operation #curve.3d.base_z.e catenary.calc = input.exponent flop
scoreboard players operation #curve.3d.base_z.m catenary.calc = input.mantissa flop

data modify storage catenary:calc curve.3d.samples set value []


### correct for bias induced by limited amount of ratios ###
execute store result score #curve.2d.bias.x.1 catenary.calc run data get storage catenary:calc curve.2d.linspace[-1].x 1000
execute store result score #curve.2d.bias.y.actual.0 catenary.calc run data get storage catenary:calc curve.2d.linspace[0].y 1000
execute store result score #curve.2d.bias.y.actual.1 catenary.calc run data get storage catenary:calc curve.2d.linspace[-1].y 1000
scoreboard players operation #curve.2d.bias.y.actual.1 catenary.calc -= #curve.2d.bias.y.actual.0 catenary.calc
execute store result score #curve.2d.bias.y.desired.0 catenary.calc run data get storage catenary:calc curve.pos1[1] 1000
execute store result score #curve.2d.bias.y.desired.1 catenary.calc run data get storage catenary:calc curve.pos2[1] 1000
scoreboard players operation #curve.2d.bias.y.desired.1 catenary.calc -= #curve.2d.bias.y.desired.0 catenary.calc
scoreboard players operation #curve.2d.bias.y.x_shift catenary.calc = #curve.2d.bias.y.desired.1 catenary.calc
scoreboard players operation #curve.2d.bias.y.x_shift catenary.calc -= #curve.2d.bias.y.actual.1 catenary.calc
scoreboard players operation #curve.2d.bias.y.1 catenary.calc -= #curve.2d.bias.y.0 catenary.calc


### begin 2d sampling ###
execute store result score #curve.2d.length catenary.calc run data get storage catenary:calc curve.2d.linspace[-1].l_cum 1000
scoreboard players operation #curve.2d.samples catenary.calc = #curve.2d.length catenary.calc
scoreboard players operation #curve.2d.samples catenary.calc /= #curve.sample_distance catenary.calc
scoreboard players add #curve.2d.samples catenary.calc 1
execute if score #curve.sample_distance catenary.calc matches 0 run scoreboard players operation #curve.2d.samples catenary.calc = #curve.sample_count catenary.calc
execute if score #curve.sample_distance catenary.calc matches 0 run scoreboard players remove #curve.2d.samples catenary.calc 1

scoreboard players set #curve.2d.sample catenary.calc 0
scoreboard players set #curve.2d.sample.next catenary.calc 0
scoreboard players set #curve.2d.sample.dx.0 catenary.calc 0
scoreboard players set #curve.2d.sample.dy.0 catenary.calc 0
data modify storage catenary:calc curve.2d.sample set from storage catenary:calc curve.2d.linspace

function catenary:curve/internal/2d/sample_loop

data modify storage catenary:calc curve.samples set from storage catenary:calc curve.3d.samples