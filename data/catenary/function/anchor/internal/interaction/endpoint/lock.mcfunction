scoreboard players operation #search catenary.id = @s catenary.id
execute if score #anchor.lock catenary.calc matches 0 as @e[type=marker,tag=catenary.end_point,predicate=catenary:match_id] run tag @s remove catenary.end_point.locked
execute if score #anchor.lock catenary.calc matches 1 as @e[type=marker,tag=catenary.end_point,predicate=catenary:match_id] run tag @s add catenary.end_point.locked