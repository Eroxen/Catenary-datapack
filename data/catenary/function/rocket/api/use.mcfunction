advancement revoke @s only catenary:trigger/use_rocket
tag @s add catenary.rocket_user
execute as @e[type=minecraft:firework_rocket,distance=..16,nbt={FireworksItem:{components:{"minecraft:custom_data":{catenary:{detect:true}}}}}] at @s run function catenary:rocket/internal/match_origin
tag @s remove catenary.rocket_user