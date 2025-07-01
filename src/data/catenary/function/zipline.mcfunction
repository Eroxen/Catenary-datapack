from catenary:flop import Eroxifloat, Vector
p1 = Vector("catenary.calc", "#catenary.pos1")
p2 = Vector("catenary.calc", "#catenary.pos2")
d_pos = Vector("catenary.calc", "#catenary.d_pos")
segment_length = Eroxifloat("catenary.calc", "#catenary.segment_length")
acceleration = Eroxifloat("catenary.calc", "#zipline.acceleration")
speed = Eroxifloat("catenary.calc", "#zipline.speed")
drag = Eroxifloat("catenary.calc", "#zipline.drag")
drag_coef = Eroxifloat("catenary.calc", "#zipline.drag_coef")
pos = Eroxifloat("catenary.calc", "#zipline.pos")

### API ###

function ~/click_end_point:
  # id -1 gets excluded from connections aka can take all connections
  scoreboard players set #search catenary.id -1
  execute on vehicle run function ~/../get_available_connections
  execute unless entity @n[type=item_display,tag=catenary.zipline.connection] run return fail

  execute on target run tag @s add catenary.zipline.boarder
  execute on target run function eroxified2:entity/api/get_height
  execute as @e[type=item_display,tag=catenary.zipline.connection,limit=1,sort=random] at @s run function ~/../spawn_and_board
  tag @e[type=item_display,tag=catenary.zipline.connection] remove catenary.zipline.connection
  tag @e[tag=catenary.zipline.boarder] remove catenary.zipline.boarder



### INTERNAL ###
append function catenary:load:
  drag_coef = Eroxifloat("catenary.calc", "#zipline.drag_coef").immediate(0.03)
  base_drag = Eroxifloat("catenary.calc", "#zipline.base_drag").immediate(0.005)

function ~/clock:
  execute as @e[type=item_display,tag=catenary.zipline.root] at @s run function ~/../tick
  execute if entity @e[type=item_display,tag=catenary.zipline.root,limit=1] run schedule function ~/ 1t replace

function ~/tick:
  data modify storage catenary:calc zipline.data set from entity @s data.zipline_data
  speed.from_storage("catenary:calc", "zipline.data.speed")
  acceleration.from_storage("catenary:calc", "zipline.data.segment.acceleration")
  speed += acceleration
  speed.square(destination=drag)
  drag *= drag_coef
  drag += base_drag
  execute if score #zipline.speed.sign catenary.calc matches 1:
    drag.reverse_sign()
  speed += drag
  # if drag is greater than speed (drag sign = new speed sign), speed becomes 0
  execute store success score #internal.temp catenary.calc if score #zipline.speed.sign catenary.calc = #zipline.drag.sign catenary.calc
  execute if score #internal.temp catenary.calc matches 1:
    speed.immediate(0)
  speed.to_storage("catenary:calc", "zipline.data.speed")

  execute on passengers if entity @s[type=interaction,tag=catenary.zipline.seat] on passengers if entity @s[type=player] run function ~/../increase_stat
  # this has some garbage value if theres no player riding, maybe change?
  scoreboard players operation @s catenary.stats.distance_by_zipline += #internal.temp catenary.calc
  execute if score @s catenary.stats.distance_by_zipline matches 1000000.. on passengers if entity @s[type=interaction,tag=catenary.zipline.seat] on passengers if entity @s[type=player] run function ~/../get_achievement

  temp1 = Eroxifloat("catenary.calc", "#internal.temp1")
  pos.from_storage("catenary:calc", "zipline.data.pos")
  pos += speed
  pos.to_score("catenary.calc", "#zipline.pos", scale=1000)
  execute store result score #zipline.max_pos catenary.calc run data get storage catenary:calc zipline.data.path.length 1000
  execute if score #zipline.pos catenary.calc matches ..-1 run return run function ~/../reach_end
  execute if score #zipline.pos catenary.calc > #zipline.max_pos catenary.calc run return run function ~/../reach_end
  pos.to_storage("catenary:calc", "zipline.data.pos")

  execute store result score #internal.temp1 catenary.calc run data get storage catenary:calc zipline.data.speed 1000
  execute store result score #internal.temp2 catenary.calc run data get storage catenary:calc zipline.data.segment.acceleration 1000
  execute if score #internal.temp1 catenary.calc matches -1..1 if score #internal.temp2 catenary.calc matches -10..10 run return run function ~/../abort

  segment_length.from_storage("catenary:calc", "zipline.data.path.segment_length")
  temp1.assign(pos)
  temp1 /= segment_length
  temp1.to_score("catenary.calc", "#internal.temp1")
  data modify storage catenary:calc internal.temp set value 0
  execute store result storage catenary:calc internal.temp int 1 run scoreboard players get #internal.temp1 catenary.calc
  execute store success score #internal.temp2 catenary.calc run data modify storage catenary:calc zipline.data.segment.i set from storage catenary:calc internal.temp
  execute if score #internal.temp2 catenary.calc matches 1 run function ~/../get_segment_from_path

  p1.from_storage("catenary:calc", "zipline.data.segment.p1")
  p2.from_storage("catenary:calc", "zipline.data.segment.p2")
  temp1.from_storage("catenary:calc", "zipline.data.segment.i")
  temp1 *= segment_length
  temp1 -= pos
  temp1.reverse_sign()
  p2 *= temp1
  temp1 -= Eroxifloat("catenary.calc", "float_1")
  temp1.reverse_sign()
  p1 *= temp1
  p1 += p2
  p1.to_storage("catenary:calc", "internal.temp")
  data modify entity @s Pos set from storage catenary:calc internal.temp
  data modify entity @s data.zipline_data set from storage catenary:calc zipline.data

  #tellraw @a {text:"pos: ",extra:[{storage:"catenary:calc",nbt:"zipline.data.pos"},{text:", segment: "},{storage:"catenary:calc",nbt:"zipline.data.segment.i"}]}

function ~/increase_stat:
  execute store result score #internal.temp catenary.calc run data get storage catenary:calc zipline.data.speed 1000
  execute if score #internal.temp catenary.calc matches ..-1 run scoreboard players operation #internal.temp catenary.calc *= -1 catenary.calc
  scoreboard players operation @s catenary.stats.distance_by_zipline += #internal.temp catenary.calc

function ~/get_achievement:
  say long long man

function ~/abort:
  say aaaah
  execute on passengers run kill @s
  kill @s

function ~/reach_end:
  say aaaah
  execute on passengers run kill @s
  kill @s

function ~/get_available_connections:
  tag @e[type=item_display,tag=catenary.zipline.connection] remove catenary.zipline.connection
  execute on passengers if entity @s[type=item_display] if data entity @s data.zipline_data unless predicate catenary:match_id run tag @s add catenary.zipline.connection

function ~/spawn_and_board:
  scoreboard players operation #search catenary.id = @s catenary.id
  data modify storage catenary:calc zipline.data set value {segment:{i:0},speed:0.1f,pos:0f}
  data modify storage catenary:calc zipline.data.path set from entity @s data.zipline_data
  function ~/../get_segment_from_path
  p1.from_storage("catenary:calc", "zipline.data.path.points[0]")
  d_pos.from_storage("catenary:calc", "zipline.data.path.points[1]")
  d_pos -= p1
  data modify storage eroxified2:api entity.pos set value [0d,0d,0d]
  for i in [0,2]:
    d_pos[i].to_storage("eroxified2:api", f"entity.pos[{i}]")
  function eroxified2:entity/api/pos_to_rotation

  data modify storage catenary:calc internal.temp set value {}
  data modify storage catenary:calc internal.temp.rotation set from storage eroxified2:api entity.rotation
  height = Eroxifloat("catenary.calc", "#internal.temp1").from_storage("eroxified2:api", "entity.get_height")
  # sitting player model is 65% of hitbox height
  temp = Eroxifloat("catenary.calc", "#internal.temp2").immediate(0.65)
  height *= temp
  # bow is 0.65 blocks tall
  temp.immediate(0.65)
  height += temp
  height.to_storage("catenary:calc", "internal.temp.height")

  function ~/summon with storage catenary:calc internal.temp
  function ~/summon:
    $summon item_display ~ ~ ~ {Rotation:$(rotation),transformation:[1.0607f,-1.0607f,0f,0f,1.0607f,1.0607f,0f,-0.5f,0f,0f,1.5f,0f,0f,0f,0f,1f],teleport_duration:2,view_range:4f,item:{id:"minecraft:bow"},Tags:["catenary.entity","catenary.zipline","catenary.zipline.root","catenary.zipline.root.new"],Passengers:[{id:"minecraft:interaction",Tags:["catenary.entity","catenary.zipline","catenary.zipline.seat"],height:-$(height)f,width:0f}]}

  execute as @e[type=item_display,tag=catenary.zipline.root.new,distance=..1]:
    tag @s remove catenary.zipline.root.new
    data modify entity @s data.zipline_data set from storage catenary:calc zipline.data
    execute on passengers if entity @s[type=interaction,tag=catenary.zipline.seat] run ride @n[tag=catenary.zipline.boarder] mount @s
  schedule function ~/../clock 1t replace

function ~/get_segment_from_path:
  data modify storage catenary:calc internal.temp set value {}
  data modify storage catenary:calc internal.temp.i1 set from storage catenary:calc zipline.data.segment.i
  execute store result score #internal.temp catenary.calc run data get storage catenary:calc internal.temp.i1 1
  scoreboard players add #internal.temp catenary.calc 1
  execute store result storage catenary:calc internal.temp.i2 int 1 run scoreboard players get #internal.temp catenary.calc
  function ~/get_points with storage catenary:calc internal.temp
  function ~/get_points:
    $data modify storage catenary:calc zipline.data.segment.p1 set from storage catenary:calc zipline.data.path.points[$(i1)]
    $data modify storage catenary:calc zipline.data.segment.p2 set from storage catenary:calc zipline.data.path.points[$(i2)]
  
  # calculate vertical force
  acceleration.from_storage("catenary:calc", "zipline.data.segment.p1[1]")
  temp1 = Eroxifloat("catenary.calc", "#internal.temp1").from_storage("catenary:calc", "zipline.data.segment.p2[1]")
  acceleration -= temp1
  segment_length.from_storage("catenary:calc", "zipline.data.path.segment_length")
  acceleration /= segment_length
  temp1.immediate(0.2)
  acceleration *= temp1
  acceleration.to_storage("catenary:calc", "zipline.data.segment.acceleration")