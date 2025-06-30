from catenary:flop import Eroxifloat, Vector
p1 = Vector("catenary.calc", "#catenary.pos1")
p2 = Vector("catenary.calc", "#catenary.pos2")
d_pos = Vector("catenary.calc", "#catenary.d_pos")

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



### INTERNAL ###
function ~/get_available_connections:
  tag @e[type=item_display,tag=catenary.zipline.connection] remove catenary.zipline.connection
  execute on passengers if entity @s[type=item_display] if data entity @s data.zipline_data unless predicate catenary:match_id run tag @s add catenary.zipline.connection

function ~/spawn_and_board:
  scoreboard players operation #search catenary.id = @s catenary.id
  data modify storage catenary:calc zipline.data set value {}
  data modify storage catenary:calc zipline.data.path set from entity @s data.zipline_data
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
    $summon item_display ~ ~ ~ {Rotation:$(rotation),transformation:[1.0607f,-1.0607f,0f,0f,1.0607f,1.0607f,0f,-0.5f,0f,0f,1.5f,0f,0f,0f,0f,1f],teleport_duration:2,item:{id:"minecraft:bow"},Tags:["catenary.entity","catenary.zipline","catenary.zipline.root"],Passengers:[{id:"minecraft:interaction",Tags:["catenary.entity","catenary.zipline","catenary.zipline.seat","catenary.zipline.seat.new"],height:-$(height)f,width:0f}]}
  ride @n[tag=catenary.zipline.boarder] mount @n[type=interaction,tag=catenary.zipline.seat.new,distance=..1]
  tag @e[type=interaction,tag=catenary.zipline.seat.new,distance=..1] remove catenary.zipline.seat.new