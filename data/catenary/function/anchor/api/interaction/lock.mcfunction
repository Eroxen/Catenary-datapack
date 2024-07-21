scoreboard players set #anchor.lock catenary.calc 1
execute on passengers if entity @s[type=marker,tag=catenary.end_point.locked] run scoreboard players set #anchor.lock catenary.calc 0

execute if score #anchor.lock catenary.calc matches 0 on target run playsound minecraft:block.iron_door.close block @s ~ ~ ~ 1 1.3
execute if score #anchor.lock catenary.calc matches 1 on target run playsound minecraft:block.iron_door.close block @s ~ ~ ~ 1 0.7

execute on passengers if entity @s[type=marker,tag=catenary.end_point] run function catenary:anchor/internal/interaction/endpoint/lock