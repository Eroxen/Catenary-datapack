scoreboard players set #spawn_studio catenary.calc 1

data modify entity @s Pos set from storage catenary:calc spawn.pos1
execute at @s store result score #temp catenary.calc run function catenary:studio/internal/spawn/test_for_studio_base
execute if score #temp catenary.calc matches 0 run scoreboard players set #spawn_studio catenary.calc 0

data modify entity @s Pos set from storage catenary:calc spawn.pos2
execute at @s store result score #temp catenary.calc run function catenary:studio/internal/spawn/test_for_studio_base
execute if score #temp catenary.calc matches 0 run scoreboard players set #spawn_studio catenary.calc 0

execute if score #spawn_studio catenary.calc matches 1 run function catenary:studio/internal/spawn/spawn

kill @s