execute on passengers if entity @s[type=marker,tag=catenary.end_point,tag=!catenary.end_point.locked] run function catenary:catenary/api/end_point_kill

scoreboard players set #anchor.has_catenaries catenary.calc 0
execute on passengers if entity @s[type=marker,tag=catenary.end_point] run scoreboard players set #anchor.has_catenaries catenary.calc 1
execute if score #anchor.has_catenaries catenary.calc matches 0 run function catenary:anchor/api/kill