function ~/detect_breaking:
  execute if entity @s[tag=catenary.custom_block.component.detect_breaking.barrel] unless block ~ ~ ~ barrel run function catenary:custom_block/barrel/broken
  execute if entity @s[tag=catenary.custom_block.component.detect_breaking.stone_pressure_plate] unless block ~ ~ ~ stone_pressure_plate run function catenary:custom_block/stone_pressure_plate/broken

function ~/detect_state_change:
  execute if entity @s[tag=catenary.custom_block.component.detect_state_change.stone_pressure_plate] run function catenary:custom_block/stone_pressure_plate/detect_state_change