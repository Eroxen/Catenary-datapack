data modify storage catenary:calc preprocess.key set string storage catenary:calc preprocess.read_buffer 0 1
data modify storage catenary:calc preprocess.read_buffer set string storage catenary:calc preprocess.read_buffer 1

execute if score #preprocess.escape catenary.calc matches 1 unless data storage catenary:calc preprocess{key:"\\"} run scoreboard players set #preprocess.escape catenary.calc 0
execute if data storage catenary:calc preprocess{key:"\\"} run scoreboard players add #preprocess.escape catenary.calc 1
execute if score #preprocess.escape catenary.calc matches 2 run scoreboard players set #preprocess.escape catenary.calc 0

execute if score #preprocess.escape catenary.calc matches 0 run function catenary:rocket/internal/preprocess/grab_from_typeface
execute if score #preprocess.escape catenary.calc matches 0 run data modify storage catenary:calc spawn.decorations.variations append value {EntityData:{item:{tag:{}}}}
execute if score #preprocess.escape catenary.calc matches 0 run data modify storage catenary:calc spawn.decorations.variations[-1].EntityData.item.tag set from storage catenary:calc preprocess.char


scoreboard players remove #preprocess.i catenary.calc 1
execute if score #preprocess.i catenary.calc matches 1.. run function catenary:rocket/internal/preprocess/custom_spelling_loop