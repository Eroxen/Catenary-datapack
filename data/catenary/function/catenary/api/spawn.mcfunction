#####################################################################
# catenary/api/spawn.mcfunction
# written by Eroxen
#
# Spawns a fully rendered catenary with both anchors if possible,
# otherwise returns an error
#
# Storage input :
# - catenary:calc :
#   - spawn :
#     - pos1 : end point of the catenary
#     - pos2 : end point of the catenary
#     - sag : integer between 0 and 3. The higher, the saggier the rope.
#     - rope : display options for the rope
#     - decorations : display options for the decorations
#
# Storage output :
# - catenary:calc :
#   - spawn :
#     - error : reason why catenary could not spawn
#####################################################################

### safeguards ###
# calculate the distance between the end points
# and check if it over the minimum distance of 0.75 blocks
data modify storage catenary:calc math.point1 set from storage catenary:calc spawn.pos1
data modify storage catenary:calc math.point2 set from storage catenary:calc spawn.pos2
function catenary:math/distance_between_points
execute unless score #math.distance catenary.calc matches 750.. run data modify storage catenary:calc spawn.error set value "points_too_close"
execute unless score #math.distance catenary.calc matches 750.. run return 0
# check if the distance does not exceed the maximum distance
execute unless score #math.distance catenary.calc matches ..60000 run data modify storage catenary:calc spawn.error set value "points_too_far"
execute unless score #math.distance catenary.calc matches ..60000 run return 0

execute unless data storage catenary:calc spawn.sag run data modify storage catenary:calc spawn.sag set value 0
execute unless data storage catenary:calc spawn.rope run data modify storage catenary:calc spawn.rope set value {type:"single",provider:{type:"block",block_state:{Name:"minecraft:chain",Properties:{axis:"z"}}}}
execute unless data storage catenary:calc spawn.rope.segment_length run data modify storage catenary:calc spawn.rope.segment_length set value 1.0f

### spawn new catenary ###
scoreboard players add .new catenary.id 1
scoreboard players operation #assign catenary.id = .new catenary.id

execute summon marker run function catenary:catenary/internal/spawn/on_marker