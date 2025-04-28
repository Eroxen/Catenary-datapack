from catenary:flop import Eroxifloat, Vector
p1 = Vector("catenary.calc", "#catenary.pos1")
p2 = Vector("catenary.calc", "#catenary.pos2")
d_pos = Vector("catenary.calc", "#catenary.d_pos")
length = Eroxifloat("catenary.calc", "#catenary.length")
d_hor = Eroxifloat("catenary.calc", "#catenary.d_hor")
d_ver = Eroxifloat("catenary.calc", "#catenary.d_ver")
slope = Eroxifloat("catenary.calc", "#catenary.slope")

## API ##

# Storage input :
# - catenary:calc :
#   - catenary.summon :
#     - pos1 : end point of the catenary
#     - pos2 : end point of the catenary
#     - settings : rope settings
function ~/summon:
  scoreboard players set #catenary.swapped_points catenary.calc 0
  p1.from_storage("catenary:calc", "catenary.summon.pos1")
  p2.from_storage("catenary:calc", "catenary.summon.pos2")
  d_pos.assign(p2)
  d_pos -= p1

  scoreboard players set #catenary.curved catenary.calc 1
  execute if data storage catenary:calc catenary.summon.settings{sag:"1"} run scoreboard players set #catenary.curved catenary.calc 0
  execute if score #catenary.curved catenary.calc matches 1:
    d_hor.euclidian_norm([d_pos[0], d_pos[2]]).to_score("catenary.calc", "#catenary.d_hor", scale=1000)
    execute if score #catenary.d_hor catenary.calc matches ..1 run return run scoreboard players set #catenary.curved catenary.calc 0
    d_ver.assign(d_pos[1]).abs()
    slope.assign(d_ver)
    slope /= d_hor
    slope.to_score("catenary.calc", "#catenary.slope", scale=100)
    execute if score #catenary.slope catenary.calc matches 10001.. run return run scoreboard players set #catenary.curved catenary.calc 0

    d_pos[1].to_score("catenary.calc", "#internal.temp")
    execute if score #internal.temp catenary.calc matches ..-1:
      scoreboard players set #catenary.swapped_points catenary.calc 1
      p1.from_storage("catenary:calc", "catenary.summon.pos2")
      p2.from_storage("catenary:calc", "catenary.summon.pos1")
      d_pos.assign(p2)
      d_pos -= p1
  
  execute if score #catenary.curved catenary.calc matches 1 run function ~/../sample_points_curved
  execute if score #catenary.curved catenary.calc matches 0 run function ~/../sample_points_straight

  function ~/../visualise_points



## INTERNAL ##
function ~/visualise_points:
  data modify storage catenary:calc internal.visualise.points set from storage catenary:calc catenary.summon.points
  execute if data storage catenary:calc internal.visualise.points[0] run function ~/loop:
    data modify storage catenary:calc internal.visualise.point set value {}
    data modify storage catenary:calc internal.visualise.point.x set from storage catenary:calc internal.visualise.points[0][0]
    data modify storage catenary:calc internal.visualise.point.y set from storage catenary:calc internal.visualise.points[0][1]
    data modify storage catenary:calc internal.visualise.point.z set from storage catenary:calc internal.visualise.points[0][2]
    function ~/../particle with storage catenary:calc internal.visualise.point
    data remove storage catenary:calc internal.visualise.points[0]
    execute if data storage catenary:calc internal.visualise.points[0] run function ~/
  function ~/particle:
    $particle minecraft:block_marker{block_state:{Name:"minecraft:sunflower",Properties:{half:"upper"}}} $(x) $(y) $(z)

function ~/sample_points_curved:
  data modify storage catenary:calc internal.temp set value {}
  execute store result storage catenary:calc internal.temp.i int 1 run scoreboard players get #catenary.slope catenary.calc
  function ~/lookup_params:
    $data modify storage catenary:calc catenary.summon.curve_params set from storage catenary:calc lookup.ratio_params."1.05"[$(i)]
    data modify storage catenary:calc catenary.summon.curve_length_factor set value 1.05f
  function ~/lookup_params with storage catenary:calc internal.temp

  d_pos.norm(length)
  temp1 = Eroxifloat("catenary.calc", "#internal.temp1").from_storage("catenary:calc", "catenary.summon.curve_length_factor")
  length *= temp1
  function ~/../get_n_segments

  dxdf = Eroxifloat("catenary.calc", "#catenary.dxdf").assign(d_pos[0])
  dzdf = Eroxifloat("catenary.calc", "#catenary.dzdf").assign(d_pos[2])

  a = Eroxifloat("catenary.calc", "#catenary.a").from_storage("catenary:calc", "catenary.summon.curve_params[0]")
  b = Eroxifloat("catenary.calc", "#catenary.b").from_storage("catenary:calc", "catenary.summon.curve_params[1]")
  c = Eroxifloat("catenary.calc", "#catenary.c").from_storage("catenary:calc", "catenary.summon.curve_params[2]")
  s0 = Eroxifloat("catenary.calc", "#catenary.s0").from_storage("catenary:calc", "catenary.summon.curve_params[3]")
  s = Eroxifloat("catenary.calc", "#catenary.s")
  s_bias = Eroxifloat("catenary.calc", "#catenary.s_bias")
  x = Eroxifloat("catenary.calc", "#catenary.x")
  y = Eroxifloat("catenary.calc", "#catenary.y")
  z = Eroxifloat("catenary.calc", "#catenary.z")
  bias = Eroxifloat("catenary.calc", "#catenary.bias").from_score("catenary.calc", "#catenary.slope", scale=0.01)
  bias *= d_hor
  bias -= d_ver
  pos = Vector("catenary.calc", "#catenary.pos")
  i_to_s = Eroxifloat("catenary.calc", "#catenary.i_to_s").assign(length)
  i_to_s /= d_hor
  segments = Eroxifloat("catenary.calc", "#catenary.segments").from_score("catenary.calc", "#catenary.segments")
  i_to_s /= segments

  data modify storage catenary:calc catenary.summon.points set value []
  scoreboard players set #internal.temp.i catenary.calc 1

  s0 *= b
  i_to_s *= b

  d_hor_times_a = Eroxifloat("catenary.calc", "#catenary.d_hor_times_a").assign(d_hor)
  d_hor_times_a *= a
  d_hor_over_b = Eroxifloat("catenary.calc", "#catenary.d_hor_over_b").assign(d_hor)
  d_hor_over_b /= b

  execute if score #internal.temp.i catenary.calc < #catenary.segments catenary.calc run function ~/loop:
    s.from_score("catenary.calc", "#internal.temp.i")
    s *= i_to_s

    s += s0
    s.arcsinh()
    
    x.assign(s)
    x /= b
    x += c
    z.assign(x)
    s_bias.assign(x)
    s_bias *= bias

    x *= dxdf
    z *= dzdf

    s.cosh()
    s *= d_hor_over_b
    s += d_hor_times_a
    s -= s_bias
    pos.assign(p1)
    pos_x = pos[0]
    pos_x += x
    pos_y = pos[1]
    pos_y += s
    pos_z = pos[2]
    pos_z += z
    data modify storage catenary:calc catenary.summon.points append value []
    pos.to_storage("catenary:calc", "catenary.summon.points[-1]")

    scoreboard players add #internal.temp.i catenary.calc 1
    execute if score #internal.temp.i catenary.calc < #catenary.segments catenary.calc run function ~/

  execute if score #catenary.swapped_points catenary.calc matches 1:
    data modify storage catenary:calc internal.temp set from storage catenary:calc catenary.summon.points
    data modify storage catenary:calc catenary.summon.points set value []
    data modify storage catenary:calc catenary.summon.points prepend from storage catenary:calc internal.temp[]

  data modify storage catenary:calc catenary.summon.points prepend from storage catenary:calc catenary.summon.pos1
  data modify storage catenary:calc catenary.summon.points append from storage catenary:calc catenary.summon.pos2

function ~/sample_points_straight:
  d_pos.norm(length)
  function ~/../get_n_segments
  data modify storage catenary:calc catenary.summon.points set value []
  data modify storage catenary:calc catenary.summon.points append from storage catenary:calc catenary.summon.pos1
  scoreboard players set #internal.temp.i catenary.calc 1
  segments = Eroxifloat("catenary.calc", "#catenary.segments").from_score("catenary.calc", "#catenary.segments")
  s = Eroxifloat("catenary.calc", "#catenary.s")
  pos = Vector("catenary.calc", "#catenary.pos")
  execute if score #internal.temp.i catenary.calc < #catenary.segments catenary.calc run function ~/loop:
    s.from_score("catenary.calc", "#internal.temp.i")
    s /= segments
    pos.assign(d_pos)
    pos *= s
    pos += p1
    data modify storage catenary:calc catenary.summon.points append value []
    pos.to_storage("catenary:calc", "catenary.summon.points[-1]")
    scoreboard players add #internal.temp.i catenary.calc 1
    execute if score #internal.temp.i catenary.calc < #catenary.segments catenary.calc run function ~/
  data modify storage catenary:calc catenary.summon.points append from storage catenary:calc catenary.summon.pos2

function ~/get_n_segments:
  segment_length = Eroxifloat("catenary.calc", "#catenary.segment_length").immediate(0.5)
  segments = Eroxifloat("catenary.calc", "#catenary.segments").assign(length)
  segments /= segment_length
  segments += Eroxifloat("catenary.calc", "float_0.5")
  segments.to_score("catenary.calc", "#catenary.segments")
