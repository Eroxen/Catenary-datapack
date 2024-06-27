#####################################################################
# light/api/spawn.mcfunction
# written by Eroxen
#
# Spawns a light block along with a marker entity if there is a
# replaceable block.
#
# Scoreboard input :
# - catenary.calc :
#   - #light_level : light level
# - catenary.id :
#   - #assign : catenary id
#####################################################################

execute unless predicate catenary:light_replaceable unless predicate catenary:waterlogged_light_replaceable run return 0
execute align xyz positioned ~0.5 ~0.5 ~0.5 as @e[type=marker,tag=catenary.light,distance=..0.1] if score @s catenary.id = #assign catenary.id run return 0

execute align xyz positioned ~0.5 ~0.5 ~0.5 summon marker run function catenary:light/internal/spawn/on_marker