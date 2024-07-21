tag @s remove catenary.zipline.marker.new
data modify storage catenary:calc zipline.data set value {rope_pos_i:0,rope_pos_f:0f,speed:0.15f}
data modify storage catenary:calc zipline.data.trajectory set from storage catenary:calc zipline.spawn.trajectory

execute on vehicle run ride @n[tag=catenary.zipline.ride,distance=..16] mount @s
execute on vehicle on passengers run tag @s[tag=catenary.zipline.ride] remove catenary.zipline.ride

# execute if data storage catenary:calc zipline.spawn.trajectory{swapped_points:1b} run say sp

execute if data storage catenary:calc zipline.spawn.trajectory{direction:"down"} run data modify storage catenary:calc zipline.data.speed set value -0.15f

execute store result score #temp catenary.calc run data get storage catenary:calc zipline.spawn.trajectory.points
scoreboard players remove #temp catenary.calc 1
execute store result storage catenary:calc zipline.data.max_rope_pos_i int 1 run scoreboard players get #temp catenary.calc
execute if data storage catenary:calc zipline.spawn.trajectory{direction:"down"} run data modify storage catenary:calc zipline.data.rope_pos_i set from storage catenary:calc zipline.data.max_rope_pos_i

# execute if data storage catenary:calc zipline.spawn.trajectory{swapped_points:1b} store result storage catenary:calc zipline.data.speed float -0.001 run data get storage catenary:calc zipline.data.speed 1000


function catenary:zipline/internal/get_segment

data modify entity @s data set from storage catenary:calc zipline.data