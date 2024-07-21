#####################################################################
# zipline/api/zoo.mcfunction
# written by Eroxen
#
# Spawns a random animal which will ride the nearest catenary anchor.
#####################################################################

execute unless entity @e[type=marker,tag=catenary.end_point,distance=..5] run return fail

execute store result score #temp catenary.calc run random value 1..4

execute if score #temp catenary.calc matches 1 run summon cow ~ ~ ~ {Tags:["catenary.zipline.ride"]}
execute if score #temp catenary.calc matches 2 run summon sheep ~ ~ ~ {Tags:["catenary.zipline.ride"]}
execute if score #temp catenary.calc matches 3 run summon pig ~ ~ ~ {Tags:["catenary.zipline.ride"]}
execute if score #temp catenary.calc matches 4 run summon chicken ~ ~ ~ {Tags:["catenary.zipline.ride"]}

execute as @n[type=marker,tag=catenary.end_point,distance=..5] at @s positioned ~ ~-1.75 ~ run function catenary:zipline/api/spawn