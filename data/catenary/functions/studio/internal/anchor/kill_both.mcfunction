data modify storage catenary:calc item_tag set from entity @s data.studio_data.invested_item_tag
loot spawn ~ ~ ~ loot catenary:rocket

scoreboard players operation #search catenary.id = @s catenary.id
kill @e[type=item_display,tag=catenary.render,predicate=catenary:match_id]
kill @e[type=block_display,tag=catenary.render,predicate=catenary:match_id]
execute as @e[type=marker,tag=catenary.light,predicate=catenary:match_id] at @s run function catenary:light/api/kill
execute as @e[type=minecraft:item_display,tag=catenary.studio.gui.root,predicate=catenary:match_id] run function catenary:studio/internal/gui/kill_recursive
kill @s
execute as @e[type=marker,tag=catenary.studio.end_point,predicate=catenary:match_id] at @s on vehicle run function catenary:studio/internal/anchor/kill_this