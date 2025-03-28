#####################################################################
# light/api/spawn.mcfunction
# written by Eroxen
#
# Called on a light marker.
# Kills the light marker and removes the light block if no other markers are present.
#####################################################################

kill @s
execute align xyz positioned ~0.5 ~0.5 ~0.5 unless entity @e[type=marker,tag=catenary.light,distance=..0.1,predicate=!catenary:match_id] run function catenary:light/internal/remove_block
execute align xyz positioned ~0.5 ~0.5 ~0.5 unless entity @e[type=marker,tag=catenary.light,distance=..0.1,predicate=!catenary:match_id] run return 0

scoreboard players set #max_light_level catenary.calc 0
execute align xyz positioned ~0.5 ~0.5 ~0.5 as @e[type=marker,tag=catenary.light,distance=..0.1,predicate=!catenary:match_id] run function catenary:light/internal/spawn/get_max_light_level

execute if predicate catenary:light_replaceable run function catenary:light/internal/spawn/place
execute if predicate catenary:waterlogged_light_replaceable run function catenary:light/internal/spawn/place_waterlogged