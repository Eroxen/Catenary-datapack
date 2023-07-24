#####################################################################
# catenary/api/end_point_kill.mcfunction
# written by Eroxen
#
# Called on an end point of the catenary, kills the catenary and end points
#####################################################################

scoreboard players operation #search catenary.id = @s catenary.id
kill @e[type=block_display,tag=catenary.render.block,predicate=catenary:match_id]
kill @s
execute as @e[type=marker,tag=catenary.end_point,predicate=catenary:match_id] at @s run function catenary:catenary/internal/kill_other_end_point