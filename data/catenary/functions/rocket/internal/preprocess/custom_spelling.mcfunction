function catenary:rocket/internal/preprocess/get_text with storage catenary:calc spawn.item_tag.display
data modify storage catenary:calc spawn.decorations set value {type:"item",count:0,EntityData:{item:{Count:1b,id:"minecraft:player_head"},billboard:"vertical",transformation:{left_rotation:[0f,1f,0f,0f]}},variations:[]}

data modify storage catenary:calc preprocess set value {}
data modify storage catenary:calc preprocess.read_buffer set from storage catenary:calc text_component
data modify storage catenary:calc typeface set from storage catenary:calc typefaces.oak
execute store result score #preprocess.i catenary.calc run data get storage catenary:calc text_component
scoreboard players set #preprocess.escape catenary.calc 0
execute if score #preprocess.i catenary.calc matches 1.. run function catenary:rocket/internal/preprocess/custom_spelling_loop
say p

execute store result storage catenary:calc spawn.decorations.count int 1 run data get storage catenary:calc spawn.decorations.variations