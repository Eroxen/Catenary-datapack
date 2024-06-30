data modify storage catenary:calc math.point1 set from entity @s SelectedItem.components.minecraft:custom_data.catenary.pos1
scoreboard players set #raycast.i catenary.calc 40
execute at @s anchored eyes positioned ^ ^ ^0.3 run function catenary:rocket/internal/raycast
function catenary:math/distance_between_points

execute store result score #display.x.i catenary.calc run data get storage catenary:calc math.point1[0] 10
execute store result score #display.y.i catenary.calc run data get storage catenary:calc math.point1[1] 10
execute store result score #display.z.i catenary.calc run data get storage catenary:calc math.point1[2] 10
scoreboard players operation #display.x.d catenary.calc = #display.x.i catenary.calc
scoreboard players operation #display.y.d catenary.calc = #display.y.i catenary.calc
scoreboard players operation #display.z.d catenary.calc = #display.z.i catenary.calc
scoreboard players operation #display.x.i catenary.calc /= 10 catenary.calc
scoreboard players operation #display.y.i catenary.calc /= 10 catenary.calc
scoreboard players operation #display.z.i catenary.calc /= 10 catenary.calc
scoreboard players operation #display.x.d catenary.calc %= 10 catenary.calc
scoreboard players operation #display.y.d catenary.calc %= 10 catenary.calc
scoreboard players operation #display.z.d catenary.calc %= 10 catenary.calc

execute if score #math.distance catenary.calc <= #setting.max_length catenary.calc run title @s actionbar {"translate":"Bound to: %s.%s, %s.%s, %s.%s","with":[{"score":{"name":"#display.x.i","objective":"catenary.calc"}},{"score":{"name":"#display.x.d","objective":"catenary.calc"}},{"score":{"name":"#display.y.i","objective":"catenary.calc"}},{"score":{"name":"#display.y.d","objective":"catenary.calc"}},{"score":{"name":"#display.z.i","objective":"catenary.calc"}},{"score":{"name":"#display.z.d","objective":"catenary.calc"}}]}
execute if score #math.distance catenary.calc > #setting.max_length catenary.calc run title @s actionbar {"color":"red","translate":"Bound to: %s.%s, %s.%s, %s.%s","with":[{"score":{"name":"#display.x.i","objective":"catenary.calc"}},{"score":{"name":"#display.x.d","objective":"catenary.calc"}},{"score":{"name":"#display.y.i","objective":"catenary.calc"}},{"score":{"name":"#display.y.d","objective":"catenary.calc"}},{"score":{"name":"#display.z.i","objective":"catenary.calc"}},{"score":{"name":"#display.z.d","objective":"catenary.calc"}}]}
execute if score #math.distance catenary.calc > #setting.max_length catenary.calc run return 0

data modify storage catenary:calc macro set value {travel_time:10,destination:[0,0,0]}
execute if score #math.distance catenary.calc matches ..3000 store result storage catenary:calc macro.travel_time int 0.004 run scoreboard players get #math.distance catenary.calc
execute if score #math.distance catenary.calc matches 3000..8000 store result storage catenary:calc macro.travel_time int 0.003 run scoreboard players get #math.distance catenary.calc
execute if score #math.distance catenary.calc matches 8000..20000 store result storage catenary:calc macro.travel_time int 0.002 run scoreboard players get #math.distance catenary.calc
execute if score #math.distance catenary.calc matches 20000.. store result storage catenary:calc macro.travel_time int 0.001 run scoreboard players get #math.distance catenary.calc
execute store result score #display.x.i catenary.calc run data get storage catenary:calc math.point2[0] 10
execute store result score #display.y.i catenary.calc run data get storage catenary:calc math.point2[1] 10
execute store result score #display.z.i catenary.calc run data get storage catenary:calc math.point2[2] 10
scoreboard players operation #display.x.i catenary.calc /= 10 catenary.calc
scoreboard players operation #display.y.i catenary.calc /= 10 catenary.calc
scoreboard players operation #display.z.i catenary.calc /= 10 catenary.calc
execute store result storage catenary:calc macro.destination[0] int 1 run scoreboard players get #display.x.i catenary.calc
execute store result storage catenary:calc macro.destination[1] int 1 run scoreboard players get #display.y.i catenary.calc
execute store result storage catenary:calc macro.destination[2] int 1 run scoreboard players get #display.z.i catenary.calc
data modify storage catenary:calc macro.x set from storage catenary:calc math.point1[0]
data modify storage catenary:calc macro.y set from storage catenary:calc math.point1[1]
data modify storage catenary:calc macro.z set from storage catenary:calc math.point1[2]
function catenary:rocket/internal/vibration with storage catenary:calc macro