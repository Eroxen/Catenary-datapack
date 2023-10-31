execute align xyz run summon minecraft:interaction ~0.5 ~-0.01 ~0.5 {width:1.02f,height:1.02f,response:1b,Tags:["eroxified.interaction","catenary.studio","catenary.studio.anchor"],Passengers:[{id:"minecraft:marker",Tags:["catenary.studio","catenary.studio.end_point","catenary.studio.end_point.new"],data:{}}]}

execute align xyz positioned ~0.5 ~-0.01 ~0.5 run data modify entity @e[type=marker,tag=catenary.studio.end_point.new,distance=..0.1,limit=1] data.studio_data set from storage catenary:calc studio.data
execute align xyz positioned ~0.5 ~-0.01 ~0.5 run scoreboard players operation @e[type=marker,tag=catenary.studio.end_point.new,distance=..0.1,limit=1] catenary.id = #assign catenary.id
execute align xyz positioned ~0.5 ~-0.01 ~0.5 run tag @e[type=marker,tag=catenary.studio.end_point.new,distance=..0.1] remove catenary.studio.end_point.new

scoreboard players set #temp catenary.calc 1