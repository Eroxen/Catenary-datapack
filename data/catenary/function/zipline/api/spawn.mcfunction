#####################################################################
# zipline/api/spawn.mcfunction
# written by Eroxen
#
# Spawns a zipline rider entity. Must be called as a catenary end point.
#####################################################################

execute unless entity @s[type=marker,tag=catenary.end_point] run return fail
scoreboard players operation #catenary_id catenary.calc = @s catenary.id
execute unless data entity @s data.trajectory run return fail

playsound minecraft:item.elytra.flying neutral @a[distance=..16]
data modify storage catenary:calc zipline.spawn set value {rotation:[0f,0f]}
data modify storage catenary:calc zipline.spawn.trajectory set from entity @s data.trajectory

execute store result score #curve.3d.x1 catenary.calc run data get storage catenary:calc zipline.spawn.trajectory.points[0].pos[0] 1000
execute store result score #curve.3d.z1 catenary.calc run data get storage catenary:calc zipline.spawn.trajectory.points[0].pos[2] 1000
execute store result score #curve.3d.x2 catenary.calc run data get storage catenary:calc zipline.spawn.trajectory.points[-1].pos[0] 1000
execute store result score #curve.3d.z2 catenary.calc run data get storage catenary:calc zipline.spawn.trajectory.points[-1].pos[2] 1000
scoreboard players operation #curve.3d.dx catenary.calc = #curve.3d.x2 catenary.calc
scoreboard players operation #curve.3d.dx catenary.calc -= #curve.3d.x1 catenary.calc
scoreboard players operation #curve.3d.dz catenary.calc = #curve.3d.z2 catenary.calc
scoreboard players operation #curve.3d.dz catenary.calc -= #curve.3d.z1 catenary.calc
data modify storage eroxified2:api entity.pos set value [0d,0d,0d]
execute store result storage eroxified2:api entity.pos[0] double 0.001 run scoreboard players get #curve.3d.dx catenary.calc
execute store result storage eroxified2:api entity.pos[2] double 0.001 run scoreboard players get #curve.3d.dz catenary.calc

execute if data storage catenary:calc zipline.spawn.trajectory{direction:"up",swapped_points:1b} store result storage eroxified2:api entity.pos[0] double -0.001 run scoreboard players get #curve.3d.dx catenary.calc
execute if data storage catenary:calc zipline.spawn.trajectory{direction:"up",swapped_points:1b} store result storage eroxified2:api entity.pos[2] double -0.001 run scoreboard players get #curve.3d.dz catenary.calc
execute if data storage catenary:calc zipline.spawn.trajectory{direction:"down",swapped_points:0b} store result storage eroxified2:api entity.pos[0] double -0.001 run scoreboard players get #curve.3d.dx catenary.calc
execute if data storage catenary:calc zipline.spawn.trajectory{direction:"down",swapped_points:0b} store result storage eroxified2:api entity.pos[2] double -0.001 run scoreboard players get #curve.3d.dz catenary.calc

function eroxified2:entity/api/pos_to_rotation
data modify storage catenary:calc zipline.spawn.rotation[0] set from storage eroxified2:api entity.rotation[0]

function catenary:zipline/internal/spawn/summon with storage catenary:calc zipline.spawn
execute as @n[type=marker,tag=catenary.zipline.marker.new,distance=..1] run function catenary:zipline/internal/spawn/init