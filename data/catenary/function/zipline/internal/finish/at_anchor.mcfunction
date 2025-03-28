scoreboard players operation #catenary_id catenary.calc = @s catenary.id
scoreboard players set #zipline.chained catenary.calc 0
execute as @e[type=marker,tag=catenary.end_point,distance=..0.1,sort=random] unless score #catenary_id catenary.calc = @s catenary.id positioned ~ ~-1.75 ~ run function catenary:zipline/internal/finish/chain

execute if score #zipline.chained catenary.calc matches 0 align xyz positioned ~0.5 ~ ~0.5 on vehicle on passengers unless entity @s[tag=catenary.zipline] run function catenary:zipline/internal/dismount/passenger