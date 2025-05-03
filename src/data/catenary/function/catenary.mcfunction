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

  # function ~/../visualise_points
  scoreboard players add .new catenary.id 1
  scoreboard players operation #assign catenary.id = .new catenary.id
  function ~/../spawn_anchors
  function ~/../spawn_chains

function ~/hit_end_point:
  scoreboard players operation #search catenary.id = @s catenary.id
  kill @e[type=block_display,tag=catenary.display,predicate=catenary:match_id]
  execute if score #survival_or_adventure catenary.calc matches 1:
    function ~/spawn_loot:
      $loot spawn ~ ~ ~ loot {"pools":[{"rolls":1,"entries":[{"type":"minecraft:item","name":"$(id)","functions":[{"function":"minecraft:set_components","components":$(components)},{"function":"minecraft:set_count","count":$(count)}]}]}]}
    function ~/spawn_loot with entity @s item
  kill @s

  execute as @e[type=item_display,tag=catenary.end_point,predicate=catenary:match_id] at @s:
    tag @s remove catenary.end_point
    scoreboard players set #internal.temp catenary.calc 0
    execute on vehicle on passengers if entity @s[type=item_display,tag=catenary.end_point] run scoreboard players set #internal.temp catenary.calc 1
    execute if score #internal.temp catenary.calc matches 0 on vehicle run function eroxified2:entity/api/kill_stack
    kill @s


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

function ~/spawn_anchors:
  p1.from_storage("catenary:calc", "catenary.summon.pos1")
  p2.from_storage("catenary:calc", "catenary.summon.pos2")
  offset = Eroxifloat("catenary.calc", "#internal.temp1").immediate(-0.15)
  p1[1] += offset
  p2[1] += offset

  data modify storage catenary:calc catenary.summon.provider.entity set value {nbt:{Tags:["catenary.entity","catenary.display","catenary.anchor"],view_range:2f,width:0.3f,height:0.3f,item:{id:"minecraft:heavy_core"},transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0.3f,0f],scale:[0.6f,0.6f,0.6f]},Passengers:[{id:"minecraft:interaction",Tags:["catenary.entity","catenary.interaction","catenary.anchor","eroxified2.interaction"],width:0.3f,height:0.3f,response:1b}]}}

  function ~/summon:
    func = ~/summon
    raw f"$execute positioned 0.0 0.0 0.0 positioned ~$(x) ~$(y) ~$(z) run function {func} with storage catenary:calc catenary.summon.provider.entity"
    function ~/summon:
      $execute unless entity @e[type=item_display,tag=catenary.anchor,distance=..0.1] run summon item_display ~ ~ ~ $(nbt)
      summon item_display ~ ~ ~ {Tags:["catenary.entity","catenary.end_point","catenary.end_point.new"],transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[0f,0f,0f]}}
      execute as @n[type=item_display,tag=catenary.end_point.new,distance=..0.1]:
        tag @s remove catenary.end_point.new
        ride @s mount @n[type=item_display,tag=catenary.anchor,distance=..0.1]
        data modify entity @s item set from storage catenary:calc rocket.item
        data modify entity @s item.count set value 1
        scoreboard players operation @s catenary.id = #assign catenary.id
  
  for point in [p1, p2]:
    data modify storage catenary:calc internal.temp set value {}
    point.to_storage("catenary:calc","internal.temp.pos")
    for i, axis in enumerate("xyz"):
      data modify storage catenary:calc f"internal.temp.{axis}" set from storage catenary:calc internal.temp.pos[i]
    function ~/summon with storage catenary:calc internal.temp


function ~/spawn_chains:
  function ~/../display_provider/init_rope
  p_a = Vector("catenary.calc", "#catenary.point_a")
  p_b = Vector("catenary.calc", "#catenary.point_b")
  temp1v = Vector("catenary.calc", "#catenary.temp1")
  data modify storage catenary:calc internal.summon.points set from storage catenary:calc catenary.summon.points
  p_a.from_storage("catenary:calc", "internal.summon.points[0]")
  data remove storage catenary:calc internal.summon.points[0]
  execute if data storage catenary:calc internal.summon.points[0] run function ~/loop:
    function ~/summon:
      func = ~/summon
      raw f"$execute positioned 0.0 0.0 0.0 positioned ~$(x) ~$(y) ~$(z) run function {func} with storage catenary:calc catenary.summon.provider.entity"
      function ~/summon:
        $summon $(type) ~ ~ ~ $(nbt)
        func = ~/init
        raw f"$execute as @n[type=$(type),tag=catenary.display.new,distance=..0.1] run function {func}"
        function ~/init:
          tag @s remove catenary.display.new
          scoreboard players operation @s catenary.id = #assign catenary.id
    p_b.from_storage("catenary:calc", "internal.summon.points[0]")
    if score #catenary.curved catenary.calc matches 1:
      p_b.subtract(p_a, temp1v)
      temp1v.to_storage("eroxified2:api", "entity.pos")
      function eroxified2:entity/api/pos_to_rotation
      data modify storage catenary:calc catenary.summon.provider.entity.nbt.Rotation[1] set from storage eroxified2:api entity.rotation[1]
    p_a.mean_with(p_b).to_storage("catenary:calc", "internal.temp")
    data modify storage catenary:calc catenary.summon.provider.entity.x set from storage catenary:calc internal.temp[0]
    data modify storage catenary:calc catenary.summon.provider.entity.y set from storage catenary:calc internal.temp[1]
    data modify storage catenary:calc catenary.summon.provider.entity.z set from storage catenary:calc internal.temp[2]
    function ~/summon with storage catenary:calc catenary.summon.provider.entity
    
    data remove storage catenary:calc internal.summon.points[0]
    p_a.assign(p_b)
    function ~/../../display_provider/next
    execute if data storage catenary:calc internal.summon.points[0] run function ~/
  function ~/particle:
    $particle minecraft:block_marker{block_state:{Name:"minecraft:sunflower",Properties:{half:"upper"}}} $(x) $(y) $(z)

function ~/display_provider:
  function ~/init_rope:
    data modify storage catenary:calc catenary.summon.provider set value {}
    data modify storage catenary:calc catenary.summon.provider.settings set from storage catenary:calc catenary.summon.settings.rope
    function ~/../init_helper
  function ~/init_helper:
    say ih
    d_pos.to_storage("eroxified2:api", "entity.pos")
    function eroxified2:entity/api/pos_to_rotation
    data modify storage catenary:calc catenary.summon.provider.type set from storage catenary:calc catenary.summon.provider.settings.type
    execute if data storage catenary:calc catenary.summon.provider{type:"single"}:
      data modify storage catenary:calc internal.temp set from storage catenary:calc catenary.summon.provider.settings.provider
      function ~/../entry_to_entity
  function ~/entry_to_entity:
    say ete
    segment_length = Eroxifloat("catenary.calc", "#catenary.segment_length")
    data modify storage catenary:calc catenary.summon.provider.entity set value {nbt:{Tags:["catenary.entity","catenary.display","catenary.display.new"],view_range:2f,width:1f,height:1f,transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[1f,1f,1f]}}}
    execute if data storage catenary:calc internal.temp{type:"block"}:
      execute unless data storage catenary:calc internal.temp.axis run data modify storage catenary:calc internal.temp.axis set value "y"
      data modify storage catenary:calc catenary.summon.provider.entity merge value {type:"minecraft:block_display",nbt:{transformation:{left_rotation:[0f,0.707f,0.707f,0f],translation:[0.5f,-0.5f,-0.5f]}}}
      execute if data storage catenary:calc internal.temp{axis:"x"} run data modify storage catenary:calc catenary.summon.provider.entity.nbt.transformation merge value {left_rotation:[0f,0.707f,0f,-0.707f],translation:[0.5f,-0.5f,-0.5f]}
      execute if data storage catenary:calc internal.temp{axis:"z"} run data modify storage catenary:calc catenary.summon.provider.entity.nbt.transformation merge value {left_rotation:[0f,0f,0f,1f],translation:[-0.5f,-0.5f,-0.5f]}
      data modify storage catenary:calc catenary.summon.provider.entity.nbt.block_state set from storage catenary:calc internal.temp.block_state
      data modify storage catenary:calc catenary.summon.provider.entity.nbt.Rotation set from storage eroxified2:api entity.rotation
      for IND, DIR in enumerate("xyz"):
        execute if data storage catenary:calc internal.temp{axis:DIR}:
          segment_length.to_storage("catenary:calc", f"catenary.summon.provider.entity.nbt.transformation.scale[{IND}]", "float")
      temp1 = Eroxifloat("catenary.calc", "#internal.temp1").immediate(-0.5)
      temp1 *= segment_length
      temp1.to_storage("catenary:calc", "catenary.summon.provider.entity.nbt.transformation.translation[2]", "float")
  function ~/next:
    execute if data storage catenary:calc catenary.summon.provider{type:"single"} run return 1


  
    


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
  segments = Eroxifloat("catenary.calc", "#catenary.segments")
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
    p1.from_storage("catenary:calc", "catenary.summon.pos1")
    p2.from_storage("catenary:calc", "catenary.summon.pos2")
    d_pos.assign(p2)
    d_pos -= p1
    if data storage catenary:calc internal.temp[0] run function ~/reverse:
      data modify storage catenary:calc catenary.summon.points prepend from storage catenary:calc internal.temp[0]
      data remove storage catenary:calc internal.temp[0]
      execute if data storage catenary:calc internal.temp[0] run function ~/

  data modify storage catenary:calc catenary.summon.points prepend from storage catenary:calc catenary.summon.pos1
  data modify storage catenary:calc catenary.summon.points append from storage catenary:calc catenary.summon.pos2

function ~/sample_points_straight:
  d_pos.norm(length)
  function ~/../get_n_segments
  data modify storage catenary:calc catenary.summon.points set value []
  data modify storage catenary:calc catenary.summon.points append from storage catenary:calc catenary.summon.pos1
  scoreboard players set #internal.temp.i catenary.calc 1
  segments = Eroxifloat("catenary.calc", "#catenary.segments")
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
  segment_length = Eroxifloat("catenary.calc", "#catenary.segment_length").immediate(1)
  segments = Eroxifloat("catenary.calc", "#catenary.segments").assign(length)
  segments /= segment_length
  segments += Eroxifloat("catenary.calc", "float_0.5")
  segments.to_score("catenary.calc", "#catenary.segments")
  segments.from_score("catenary.calc", "#catenary.segments")
  segment_length.assign(length)
  segment_length /= segments
