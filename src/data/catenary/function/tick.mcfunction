function ~/1t:
  schedule function ~/ 1t replace
  execute as @a at @s as @e[type=marker,tag=catenary.custom_block.component.detect_breaking,distance=..16] at @s run function catenary:custom_block/generic/detect_breaking
  execute as @e[type=marker,tag=catenary.custom_block.component.detect_state_change] at @s run function catenary:custom_block/generic/detect_state_change

function ~/10t:
  schedule function ~/ 10t replace
  execute as @e[type=marker,tag=catenary.custom_block.component.detect_breaking] at @s run function catenary:custom_block/generic/detect_breaking