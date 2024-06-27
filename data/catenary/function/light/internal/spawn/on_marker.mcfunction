data merge entity @s {Tags:["catenary","catenary.light","catenary.entity"],data:{light_level:0}}
scoreboard players operation @s catenary.id = #assign catenary.id
execute store result entity @s data.light_level int 1 run scoreboard players get #light_level catenary.calc

scoreboard players set #max_light_level catenary.calc 0
execute as @e[type=marker,tag=catenary.light,distance=..0.1] run function catenary:light/internal/spawn/get_max_light_level

execute if predicate catenary:light_replaceable run function catenary:light/internal/spawn/place
execute if predicate catenary:waterlogged_light_replaceable run function catenary:light/internal/spawn/place_waterlogged