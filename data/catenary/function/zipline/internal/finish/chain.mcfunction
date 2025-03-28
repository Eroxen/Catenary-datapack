execute if score #zipline.chained catenary.calc matches 1 run return fail
scoreboard players set #zipline.chained catenary.calc 1

execute as @e[tag=catenary.zipline.ride,distance=..16] run ride @s dismount

playsound minecraft:block.note_block.bell block @p[tag=catenary.zipline.ride,distance=..16] ~ ~ ~ 1 1.5

execute store result score #zipline.spawn_with.speed catenary.calc run data get storage catenary:calc zipline.data.speed 1000
execute if score #zipline.spawn_with.speed catenary.calc matches ..-1 run scoreboard players operation #zipline.spawn_with.speed catenary.calc *= -1 catenary.calc
function catenary:zipline/api/spawn