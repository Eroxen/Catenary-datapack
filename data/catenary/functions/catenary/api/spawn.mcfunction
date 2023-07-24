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
#     - sag : rope length = sag * euclidian distance. Can be 1.01, 1.05, or 1.1.
#     - rope : display options for the rope
#       - segment_length : segment length
#
# Storage output :
# - catenary:calc :
#   - spawn :
#     - error : reason why catenary could not spawn
#####################################################################

### safeguards ###
# calculate the distance between the end points
# and check if it over the minimum distance of 1 block
execute store result score #temp.p1 catenary.calc run data get storage catenary:calc spawn.pos1[0] 1000
execute store result score #temp.p2 catenary.calc run data get storage catenary:calc spawn.pos2[0] 1000
scoreboard players operation #temp.p1 catenary.calc -= #temp.p2 catenary.calc
scoreboard players operation #temp.p1 catenary.calc *= #temp.p1 catenary.calc
scoreboard players operation #temp.d catenary.calc = #temp.p1 catenary.calc
execute store result score #temp.p1 catenary.calc run data get storage catenary:calc spawn.pos1[1] 1000
execute store result score #temp.p2 catenary.calc run data get storage catenary:calc spawn.pos2[1] 1000
scoreboard players operation #temp.p1 catenary.calc -= #temp.p2 catenary.calc
scoreboard players operation #temp.p1 catenary.calc *= #temp.p1 catenary.calc
scoreboard players operation #temp.d catenary.calc += #temp.p1 catenary.calc
execute store result score #temp.p1 catenary.calc run data get storage catenary:calc spawn.pos1[2] 1000
execute store result score #temp.p2 catenary.calc run data get storage catenary:calc spawn.pos2[2] 1000
scoreboard players operation #temp.p1 catenary.calc -= #temp.p2 catenary.calc
scoreboard players operation #temp.p1 catenary.calc *= #temp.p1 catenary.calc
scoreboard players operation #temp.d catenary.calc += #temp.p1 catenary.calc
execute store result storage eroxified:api math.input float 0.000001 run scoreboard players get #temp.d catenary.calc
function eroxified:api/math/float/sqrt
execute store result score #temp.d catenary.calc run data get storage eroxified:api math.output 1000
execute unless score #temp.d catenary.calc matches 750.. run data modify storage catenary:calc spawn.error set value "points_too_close"
execute unless score #temp.d catenary.calc matches 750.. run return 0
# check if the distance does not exceed the maximum distance
execute unless score #temp.d catenary.calc matches ..50000 run data modify storage catenary:calc spawn.error set value "points_too_far"
execute unless score #temp.d catenary.calc matches ..50000 run return 0

execute unless data storage catenary:calc spawn.sag run data modify storage catenary:calc spawn.sag set value 1.05f

execute unless data storage catenary:calc spawn.rope run data modify storage catenary:calc spawn.rope set value {type:"block",block_state:{Name:"minecraft:chain",Properties:{axis:"z"}}}

execute unless data storage catenary:calc spawn.rope.segment_length run data modify storage catenary:calc spawn.rope.segment_length set value 1.0f

### spawn new catenary ###
scoreboard players add .new catenary.id 1
scoreboard players operation #assign catenary.id = .new catenary.id
execute summon marker run function catenary:catenary/internal/spawn/on_marker