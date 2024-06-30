
clear @a *[minecraft:custom_data~{catenary:{}}]
execute as @e[type=item] if items entity @s contents *[minecraft:custom_data~{catenary:{}}] run kill @s

execute as @e[type=marker,tag=catenary.light] at @s run function catenary:light/api/kill
kill @e[tag=catenary.entity]
kill @e[tag=catenary.render]

data remove storage catenary:calc curve
data remove storage catenary:calc create_curve
data remove storage catenary:calc make_curve
data remove storage catenary:calc spawn_anchor
data remove storage catenary:calc anchor_pos
data remove storage catenary:calc render
data remove storage catenary:calc typefaces
data remove storage catenary:calc typeface
data remove storage catenary:calc macro
data remove storage catenary:calc temp
data remove storage catenary:calc spawn
data remove storage catenary:calc FireworksItem
data remove storage catenary:calc RocketItem
data remove storage catenary:calc item_tag
data remove storage catenary:calc preprocess
data remove storage catenary:calc rope_items
data remove storage catenary:calc math
data remove storage catenary:calc EntityData
data remove storage catenary:calc error_message
data remove storage catenary:calc text_component
data remove storage catenary:calc 2dpath
data remove storage catenary:calc 3dpath
data remove storage catenary:calc used_item

scoreboard objectives remove catenary.calc
scoreboard objectives remove catenary.id

function flop:api/remove_scoreboards_and_storage

function catenary:signature
function eroxified2:core/api/disable_signature

datapack disable "file/Catenary-datapack"

function eroxified2:core/api/uninstall