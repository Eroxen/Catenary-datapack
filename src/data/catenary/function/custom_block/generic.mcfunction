function ~/detect_breaking:
  execute if entity @s[tag=catenary.custom_block.component.detect_breaking.barrel] unless block ~ ~ ~ barrel run function catenary:custom_block/barrel/broken