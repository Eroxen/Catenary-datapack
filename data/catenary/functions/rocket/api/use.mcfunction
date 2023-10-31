scoreboard players set #used_on_studio_base catenary.calc 0
#execute if entity @s[advancements={catenary:trigger/use_rocket={use_on_studio_base=true}}] run scoreboard players set #used_on_studio_base catenary.calc 1

advancement revoke @s only catenary:trigger/use_rocket
tag @s add catenary.rocket_user
execute as @e[type=minecraft:firework_rocket,distance=..16,nbt={FireworksItem:{tag:{catenary:{detect:1b}}}}] at @s run function catenary:rocket/internal/match_origin
tag @s remove catenary.rocket_user