execute on passengers if entity @s[type=interaction] on target run tag @s add catenary.zipline.ride

execute positioned ~ ~-1.75 ~ on passengers if entity @s[type=marker,tag=catenary.end_point] run function catenary:zipline/api/spawn

execute on passengers if entity @s[type=interaction] on target run tag @s remove catenary.zipline.ride