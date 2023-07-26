execute store result score #temp catenary.calc run data get entity @s Pos[1] 1000
scoreboard players operation #temp catenary.calc += #render.offset catenary.calc
execute store result entity @s Pos[1] double 0.001 run scoreboard players get #temp catenary.calc