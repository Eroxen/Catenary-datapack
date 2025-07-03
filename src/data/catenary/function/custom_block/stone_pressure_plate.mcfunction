function ~/broken:
  scoreboard players set #custom_block.retrieved_item catenary.calc 0
  execute as @e[type=item,distance=..2] if items entity @s contents minecraft:stone_pressure_plate:
    execute if score #custom_block.retrieved_item catenary.calc matches 1 run return fail
    raw item modify entity @s contents [{function:"minecraft:set_count","count":-1,"add":true}]
    scoreboard players set #custom_block.retrieved_item catenary.calc 1
  function ~/../broken_delegate
  kill @s

function ~/detect_state_change:
  execute if entity @s[tag=catenary.custom_block.component.detect_state_change.stone_pressure_plate.powered] run return run execute if block ~ ~ ~ minecraft:stone_pressure_plate[powered=false]:
    tag @s remove catenary.custom_block.component.detect_state_change.stone_pressure_plate.powered
  execute if block ~ ~ ~ minecraft:stone_pressure_plate[powered=true]:
    tag @s add catenary.custom_block.component.detect_state_change.stone_pressure_plate.powered
    function ~/../pressed_down_delegate