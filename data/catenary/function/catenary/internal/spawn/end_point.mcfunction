data modify entity @s {} merge value {Tags:["catenary.end_point","catenary.entity"]}
data modify entity @s data.item_components set from storage catenary:calc spawn.item_components
scoreboard players operation @s catenary.id = #assign catenary.id
ride @s mount @e[type=interaction,tag=catenary.anchor,distance=..0.1,limit=1,sort=nearest]