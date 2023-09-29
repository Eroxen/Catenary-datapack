execute unless data storage catenary:calc curve{swapped_points:1b} run data modify storage catenary:calc curve.3d.samples append value {pos:[0d,0d,0d]}
execute if data storage catenary:calc curve{swapped_points:1b} run data modify storage catenary:calc curve.3d.samples prepend value {pos:[0d,0d,0d],distance:0f}
execute unless data storage catenary:calc curve{swapped_points:1b} run data modify storage catenary:calc curve.3d.samples[-1].distance set from storage catenary:calc curve.2d.sampled.distance
execute if data storage catenary:calc curve{swapped_points:1b} run data modify storage catenary:calc curve.3d.samples[1].distance set from storage catenary:calc curve.2d.sampled.distance

### x ###
data modify storage flop:api input set from storage catenary:calc curve.2d.sampled.x
function flop:api/storage/read_as_eroxifloat
scoreboard players operation operand.a.sign flop = input.sign flop
scoreboard players operation operand.a.exponent flop = input.exponent flop
scoreboard players operation operand.a.mantissa flop = input.mantissa flop
scoreboard players operation operand.b.sign flop = #curve.3d.dx.s catenary.calc
scoreboard players operation operand.b.exponent flop = #curve.3d.dx.e catenary.calc
scoreboard players operation operand.b.mantissa flop = #curve.3d.dx.m catenary.calc
function flop:api/eroxifloat/multiply
scoreboard players operation operand.a.sign flop = output.sign flop
scoreboard players operation operand.a.exponent flop = output.exponent flop
scoreboard players operation operand.a.mantissa flop = output.mantissa flop
scoreboard players operation operand.b.sign flop = #curve.3d.base_x.s catenary.calc
scoreboard players operation operand.b.exponent flop = #curve.3d.base_x.e catenary.calc
scoreboard players operation operand.b.mantissa flop = #curve.3d.base_x.m catenary.calc
function flop:api/eroxifloat/add
function flop:api/eroxifloat/write_to_double

execute unless data storage catenary:calc curve{swapped_points:1b} run data modify storage catenary:calc curve.3d.samples[-1].pos[0] set from storage flop:api output
execute if data storage catenary:calc curve{swapped_points:1b} run data modify storage catenary:calc curve.3d.samples[0].pos[0] set from storage flop:api output


### y ###
data modify storage flop:api input set from storage catenary:calc curve.2d.sampled.y
function flop:api/storage/read_as_eroxifloat
scoreboard players operation operand.a.sign flop = input.sign flop
scoreboard players operation operand.a.exponent flop = input.exponent flop
scoreboard players operation operand.a.mantissa flop = input.mantissa flop
scoreboard players operation operand.b.sign flop = #curve.3d.base_y.s catenary.calc
scoreboard players operation operand.b.exponent flop = #curve.3d.base_y.e catenary.calc
scoreboard players operation operand.b.mantissa flop = #curve.3d.base_y.m catenary.calc
function flop:api/eroxifloat/add
function flop:api/eroxifloat/write_to_double

execute unless data storage catenary:calc curve{swapped_points:1b} run data modify storage catenary:calc curve.3d.samples[-1].pos[1] set from storage flop:api output
execute if data storage catenary:calc curve{swapped_points:1b} run data modify storage catenary:calc curve.3d.samples[0].pos[1] set from storage flop:api output

### z ###
data modify storage flop:api input set from storage catenary:calc curve.2d.sampled.x
function flop:api/storage/read_as_eroxifloat
scoreboard players operation operand.a.sign flop = input.sign flop
scoreboard players operation operand.a.exponent flop = input.exponent flop
scoreboard players operation operand.a.mantissa flop = input.mantissa flop
scoreboard players operation operand.b.sign flop = #curve.3d.dz.s catenary.calc
scoreboard players operation operand.b.exponent flop = #curve.3d.dz.e catenary.calc
scoreboard players operation operand.b.mantissa flop = #curve.3d.dz.m catenary.calc
function flop:api/eroxifloat/multiply
scoreboard players operation operand.a.sign flop = output.sign flop
scoreboard players operation operand.a.exponent flop = output.exponent flop
scoreboard players operation operand.a.mantissa flop = output.mantissa flop
scoreboard players operation operand.b.sign flop = #curve.3d.base_z.s catenary.calc
scoreboard players operation operand.b.exponent flop = #curve.3d.base_z.e catenary.calc
scoreboard players operation operand.b.mantissa flop = #curve.3d.base_z.m catenary.calc
function flop:api/eroxifloat/add
function flop:api/eroxifloat/write_to_double

execute unless data storage catenary:calc curve{swapped_points:1b} run data modify storage catenary:calc curve.3d.samples[-1].pos[2] set from storage flop:api output
execute if data storage catenary:calc curve{swapped_points:1b} run data modify storage catenary:calc curve.3d.samples[0].pos[2] set from storage flop:api output