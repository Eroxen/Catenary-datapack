data modify storage catenary:calc test.point1 set from entity @e[type=marker,tag=catenary.test.point1,limit=1] Pos
data modify storage catenary:calc test.point2 set from entity @e[type=marker,tag=catenary.test.point2,limit=1] Pos
#data modify storage catenary:calc test.point1 set from storage catenary:calc EntityData.FireworksItem.tag.catenary.pos1
#data modify storage catenary:calc test.point2 set from storage catenary:calc EntityData.Pos

execute store result score test.x1 catenary.calc run data get storage catenary:calc test.point1[0] 1000
execute store result score test.y1 catenary.calc run data get storage catenary:calc test.point1[1] 1000
execute store result score test.z1 catenary.calc run data get storage catenary:calc test.point1[2] 1000
execute store result score test.x2 catenary.calc run data get storage catenary:calc test.point2[0] 1000
execute store result score test.y2 catenary.calc run data get storage catenary:calc test.point2[1] 1000
execute store result score test.z2 catenary.calc run data get storage catenary:calc test.point2[2] 1000

scoreboard players operation test.x2 catenary.calc -= test.x1 catenary.calc
scoreboard players operation test.x2 catenary.calc *= test.x2 catenary.calc
scoreboard players operation test.y2 catenary.calc -= test.y1 catenary.calc
scoreboard players operation test.y2 catenary.calc *= test.y2 catenary.calc
scoreboard players operation test.z2 catenary.calc -= test.z1 catenary.calc
scoreboard players operation test.z2 catenary.calc *= test.z2 catenary.calc

scoreboard players operation test.x2 catenary.calc += test.y2 catenary.calc
scoreboard players operation test.x2 catenary.calc += test.z2 catenary.calc

execute store result storage eroxified:api math.input float 0.000001 run scoreboard players get test.x2 catenary.calc
function eroxified:api/math/float/sqrt
data modify storage catenary:calc test.distance set from storage eroxified:api math.output

execute as @e[type=marker,tag=catenary.test.point1,limit=1] at @s run tp @s ~ ~ ~ facing entity @e[type=marker,tag=catenary.test.point2,limit=1]

execute store result score test.x2 catenary.calc run data get storage catenary:calc test.point2[0] 1000
execute store result score test.y2 catenary.calc run data get storage catenary:calc test.point2[1] 1000
execute store result score test.z2 catenary.calc run data get storage catenary:calc test.point2[2] 1000
scoreboard players operation test.x2 catenary.calc += test.x1 catenary.calc
scoreboard players operation test.y2 catenary.calc += test.y1 catenary.calc
scoreboard players operation test.z2 catenary.calc += test.z1 catenary.calc
data modify storage catenary:calc test.middle set value [0d,0d,0d]
execute store result storage catenary:calc test.middle[0] double 0.0005 run scoreboard players get test.x2 catenary.calc
execute store result storage catenary:calc test.middle[1] double 0.0005 run scoreboard players get test.y2 catenary.calc
execute store result storage catenary:calc test.middle[2] double 0.0005 run scoreboard players get test.z2 catenary.calc

kill @e[type=block_display,tag=catenary.test.connecting_line]
data modify storage catenary:calc EntityData set value {Tags:["catenary.test.connecting_line"],block_state:{Name:"minecraft:chain",Properties:{axis:"z"}},transformation:{translation:[-0.5f,-0.5f,-0.5f],scale:[1f,1f,1f]}}
data modify storage catenary:calc EntityData.Pos set from storage catenary:calc test.middle
data modify storage catenary:calc EntityData.Rotation set from entity @e[type=marker,tag=catenary.test.point1,limit=1] Rotation
execute store result storage catenary:calc EntityData.transformation.scale[2] float 0.001 run data get storage catenary:calc test.distance 1000
execute store result score test.translation catenary.calc run data get storage catenary:calc test.distance -500
#scoreboard players remove test.translation catenary.calc 500
execute store result storage catenary:calc EntityData.transformation.translation[2] float 0.001 run scoreboard players get test.translation catenary.calc
execute summon block_display run data modify entity @s {} merge from storage catenary:calc EntityData