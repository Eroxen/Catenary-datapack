scoreboard players set #zipline.passengers catenary.calc 0
execute on vehicle on passengers unless entity @s[tag=catenary.zipline] run scoreboard players set #zipline.passengers catenary.calc 1
execute if score #zipline.passengers catenary.calc matches 0 run return run function catenary:zipline/internal/move/finish



data modify storage catenary:calc zipline.data set from entity @s data

# tellraw @a[distance=..8] [{"text":"rope: "},{"storage": "catenary:calc", "nbt": "zipline.data.rope_pos_i"},{"text":"+"},{"storage": "catenary:calc", "nbt": "zipline.data.rope_pos_f"}]

# accelerate
execute store result score #zipline.speed catenary.calc run data get storage catenary:calc zipline.data.speed 10000
execute store result score #zipline.acceleration catenary.calc run data get storage catenary:calc zipline.data.segment.slope 300
execute if score #zipline.acceleration catenary.calc matches ..-300 run scoreboard players set #zipline.acceleration catenary.calc -300
execute if score #zipline.acceleration catenary.calc matches 300.. run scoreboard players set #zipline.acceleration catenary.calc 300

execute if score #zipline.speed catenary.calc matches -100..100 if score #zipline.acceleration catenary.calc matches -10..10 run return run function catenary:zipline/internal/move/finish
# tellraw @a[distance=..8] [{"score": {"name": "#zipline.acceleration", "objective": "catenary.calc"},"color":"light_purple"},{"text":" -> "},{"score": {"name": "#zipline.speed", "objective": "catenary.calc"},"color":"light_purple"}]
scoreboard players operation #zipline.speed catenary.calc += #zipline.acceleration catenary.calc
scoreboard players set #zipline.drag catenary.calc 985
scoreboard players operation #zipline.speed catenary.calc *= #zipline.drag catenary.calc
execute store result storage catenary:calc zipline.data.speed float 0.0000001 run scoreboard players get #zipline.speed catenary.calc


# move
execute store result score #zipline.speed catenary.calc run data get storage catenary:calc zipline.data.speed 1300
execute store result score #zipline.rope_pos_f catenary.calc run data get storage catenary:calc zipline.data.rope_pos_f 1000
execute store result score #zipline.segment.length catenary.calc run data get storage catenary:calc zipline.data.segment.length 1000
scoreboard players set #zipline.momentum catenary.calc 1000
scoreboard players operation #zipline.momentum catenary.calc *= #zipline.speed catenary.calc
scoreboard players operation #zipline.momentum catenary.calc /= #zipline.segment.length catenary.calc
# tellraw @a[distance=..8] {"score": {"name": "#zipline.momentum", "objective": "catenary.calc"}}

scoreboard players operation #zipline.rope_pos_f catenary.calc += #zipline.momentum catenary.calc
scoreboard players operation #zipline.momentum catenary.calc = #zipline.rope_pos_f catenary.calc
# tellraw @a[distance=..8] {"score":{"name": "#zipline.rope_pos_f","objective": "catenary.calc"},"color": "blue"}
scoreboard players operation #zipline.rope_pos_f catenary.calc %= 1000 catenary.calc
# tellraw @a[distance=..8] {"score":{"name": "#zipline.rope_pos_f","objective": "catenary.calc"},"color": "red"}
execute store result storage catenary:calc zipline.data.rope_pos_f float 0.001 run scoreboard players get #zipline.rope_pos_f catenary.calc

scoreboard players operation #zipline.momentum catenary.calc /= 1000 catenary.calc
# tellraw @a[distance=..8] {"score":{"name": "#zipline.momentum","objective": "catenary.calc"},"color": "yellow"}
execute unless score #zipline.momentum catenary.calc matches 0 run function catenary:zipline/internal/move/switch_segment

# tellraw @a[distance=..8] [{"text":"rope: "},{"storage": "catenary:calc", "nbt": "zipline.data.rope_pos_i"},{"text":"+"},{"storage": "catenary:calc", "nbt": "zipline.data.rope_pos_f"}]

# calculate pos
data modify storage catenary:calc macro set value {i:0,j:0}
execute store result score #temp catenary.calc run data get storage catenary:calc zipline.data.rope_pos_f 1000
execute store result storage catenary:calc macro.j int 1 run scoreboard players get #temp catenary.calc
scoreboard players remove #temp catenary.calc 1000
execute store result storage catenary:calc macro.i int -1 run scoreboard players get #temp catenary.calc
function catenary:zipline/internal/move/calculate_pos with storage catenary:calc macro
# tellraw @a {"storage": "catenary:calc", "nbt": "zipline.pos"}
execute on vehicle run data modify entity @s Pos set from storage catenary:calc zipline.pos

data modify entity @s data set from storage catenary:calc zipline.data