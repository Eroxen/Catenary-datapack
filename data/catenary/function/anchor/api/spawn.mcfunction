summon minecraft:item_display ~ ~ ~ {Tags:["catenary.entity","catenary.anchor"],width:0.3,height:0.3,transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0.3f,0f],scale:[0.6f,0.6f,0.6f]},Passengers:[\
{id:"minecraft:interaction",width:0.3,height:0.3,response:1b,Tags:["eroxified2.interaction","catenary.entity","catenary.anchor"]}\
]}
scoreboard players operation @n[type=interaction,tag=catenary.anchor,distance=..0.1] eroxified2.datafixer_version = catenary eroxified2.datafixer_version
execute as @n[type=item_display,tag=catenary.anchor,distance=..0.1] run function catenary:anchor/internal/set_item