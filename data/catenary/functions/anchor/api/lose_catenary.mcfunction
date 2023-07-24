scoreboard players set #has_catenaries catenary.calc 0
execute on passengers if entity @s[type=marker,tag=catenary.end_point] run scoreboard players set #has_catenaries catenary.calc 1
execute if score #has_catenaries catenary.calc matches 0 run function catenary:anchor/api/kill