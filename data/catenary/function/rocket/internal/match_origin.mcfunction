scoreboard players set #temp catenary.calc 0
execute on origin if entity @s[tag=catenary.rocket_user] run scoreboard players set #temp catenary.calc 1
execute if score #temp catenary.calc matches 0 run return 0

data modify storage catenary:calc EntityData set from entity @s {}
data modify storage catenary:calc FireworksItem set from storage catenary:calc EntityData.FireworksItem
execute on origin run function catenary:rocket/internal/on_rocket_pos
kill @s