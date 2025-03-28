data remove storage catenary:calc zipline.end_point

execute if data storage catenary:calc zipline.data.trajectory{swapped_points:0b} if score #zipline.rope_pos_i catenary.calc matches ..0 run data modify storage catenary:calc zipline.end_point set from storage catenary:calc zipline.data.trajectory.points[0].pos
execute if data storage catenary:calc zipline.data.trajectory{swapped_points:0b} if score #zipline.rope_pos_i catenary.calc >= #zipline.max_rope_pos_i catenary.calc run data modify storage catenary:calc zipline.end_point set from storage catenary:calc zipline.data.trajectory.points[-1].pos
execute if data storage catenary:calc zipline.data.trajectory{swapped_points:1b} if score #zipline.rope_pos_i catenary.calc matches ..0 run data modify storage catenary:calc zipline.end_point set from storage catenary:calc zipline.data.trajectory.points[-1].pos
execute if data storage catenary:calc zipline.data.trajectory{swapped_points:1b} if score #zipline.rope_pos_i catenary.calc >= #zipline.max_rope_pos_i catenary.calc run data modify storage catenary:calc zipline.end_point set from storage catenary:calc zipline.data.trajectory.points[0].pos

execute if data storage catenary:calc zipline.end_point run function catenary:zipline/internal/finish/start

execute if score #zipline.chained catenary.calc matches 0 run stopsound @a[distance=..16] neutral minecraft:item.elytra.flying
execute if score #zipline.chained catenary.calc matches 0 run playsound minecraft:entity.item.pickup neutral @a[distance=..16]
function catenary:zipline/api/kill