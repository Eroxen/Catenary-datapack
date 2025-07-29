function ~/spawn:
  execute unless predicate catenary:light_replaceable unless predicate catenary:waterlogged_light_replaceable run return fail
  execute align xyz positioned ~0.5 ~0.5 ~0.5:
    execute as @e[type=marker,tag=catenary.light,distance=..0.1] if score @s catenary.id = #assign catenary.id run return 0
    execute summon marker:
      data merge entity @s {Tags:["catenary","catenary.light","catenary.entity"],data:{light_level:0,name:"Catenary Light"}}
      scoreboard players operation @s catenary.id = #assign catenary.id
      execute store result entity @s data.light_level int 1 run scoreboard players get #light_level catenary.calc

      function ~/../get_max_light_level
      function ~/../place

      
function ~/kill:
  kill @s
  execute align xyz positioned ~0.5 ~0.5 ~0.5 unless entity @e[type=marker,tag=catenary.light,distance=..0.1,predicate=!catenary:match_id]:
    execute if block ~ ~ ~ minecraft:light[waterlogged=false] run setblock ~ ~ ~ minecraft:air
    execute if block ~ ~ ~ minecraft:light[waterlogged=true] run setblock ~ ~ ~ minecraft:water
  execute align xyz positioned ~0.5 ~0.5 ~0.5 unless entity @e[type=marker,tag=catenary.light,distance=..0.1,predicate=!catenary:match_id] run return 0

  function ~/../get_max_light_level
  function ~/../place

function ~/get_max_light_level:
  scoreboard players set #max_light_level catenary.calc 0
  execute as @e[type=marker,tag=catenary.light,distance=..0.1]:
    execute store result score #temp catenary.calc run data get entity @s data.light_level 1
    scoreboard players operation #max_light_level catenary.calc > #temp catenary.calc

function ~/place:
  execute if predicate catenary:light_replaceable run return:
    for i in range(16):
      execute if score #max_light_level catenary.calc matches i run setblock ~ ~ ~ minecraft:light[level=i,waterlogged=false]
  execute if predicate catenary:waterlogged_light_replaceable run return:
    for i in range(16):
      execute if score #max_light_level catenary.calc matches i run setblock ~ ~ ~ minecraft:light[level=i,waterlogged=false]