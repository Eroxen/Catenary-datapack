$execute store result score #curve.3d.x1 catenary.calc run data get storage catenary:calc zipline.data.segment.pos1[0] $(i)
$execute store result score #curve.3d.y1 catenary.calc run data get storage catenary:calc zipline.data.segment.pos1[1] $(i)
$execute store result score #curve.3d.z1 catenary.calc run data get storage catenary:calc zipline.data.segment.pos1[2] $(i)
$execute store result score #curve.3d.x2 catenary.calc run data get storage catenary:calc zipline.data.segment.pos2[0] $(j)
$execute store result score #curve.3d.y2 catenary.calc run data get storage catenary:calc zipline.data.segment.pos2[1] $(j)
$execute store result score #curve.3d.z2 catenary.calc run data get storage catenary:calc zipline.data.segment.pos2[2] $(j)

scoreboard players operation #curve.3d.x1 catenary.calc += #curve.3d.x2 catenary.calc
scoreboard players operation #curve.3d.y1 catenary.calc += #curve.3d.y2 catenary.calc
scoreboard players operation #curve.3d.z1 catenary.calc += #curve.3d.z2 catenary.calc
scoreboard players remove #curve.3d.y1 catenary.calc 1750
data modify storage catenary:calc zipline.pos set value [0d,0d,0d]
execute store result storage catenary:calc zipline.pos[0] double 0.001 run scoreboard players get #curve.3d.x1 catenary.calc
execute store result storage catenary:calc zipline.pos[1] double 0.001 run scoreboard players get #curve.3d.y1 catenary.calc
execute store result storage catenary:calc zipline.pos[2] double 0.001 run scoreboard players get #curve.3d.z1 catenary.calc
