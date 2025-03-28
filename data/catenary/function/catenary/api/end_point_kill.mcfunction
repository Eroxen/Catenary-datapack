#####################################################################
# catenary/api/end_point_kill.mcfunction
# written by Eroxen
#
# Called on an end point of the catenary, kills the catenary and end points
#####################################################################

data modify storage catenary:calc FireworksItem.components set from entity @s data.item_components
function catenary:rocket/internal/drop_with_components with storage catenary:calc FireworksItem

scoreboard players operation #search catenary.id = @s catenary.id
kill @e[type=item_display,tag=catenary.render,predicate=catenary:match_id]
kill @e[type=block_display,tag=catenary.render,predicate=catenary:match_id]
execute as @e[type=marker,tag=catenary.light,predicate=catenary:match_id] at @s run function catenary:light/api/kill
kill @s
execute as @e[type=marker,tag=catenary.end_point,predicate=catenary:match_id] at @s run function catenary:catenary/internal/kill_other_end_point