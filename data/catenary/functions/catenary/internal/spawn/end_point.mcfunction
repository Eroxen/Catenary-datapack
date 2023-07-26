data modify entity @s {} merge value {Tags:["catenary.end_point"]}
data modify entity @s data.item_tag set from storage catenary:calc spawn.item_tag
scoreboard players operation @s catenary.id = #assign catenary.id
ride @s mount @e[type=interaction,tag=catenary.anchor,distance=..0.1,limit=1,sort=nearest]