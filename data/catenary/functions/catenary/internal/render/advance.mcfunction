data modify storage catenary:calc render.point set from storage catenary:calc render.points[0]
data remove storage catenary:calc render.points[0]

execute store result score #render.x catenary.calc run data get storage catenary:calc render.point.pos[0] 1000
execute store result score #render.y catenary.calc run data get storage catenary:calc render.point.pos[1] 1000
execute store result score #render.z catenary.calc run data get storage catenary:calc render.point.pos[2] 1000
execute store result score #render.distance catenary.calc run data get storage catenary:calc render.point.distance 1000

scoreboard players operation #render.x catenary.calc += #render.x_old catenary.calc
scoreboard players operation #render.y catenary.calc += #render.y_old catenary.calc
scoreboard players operation #render.z catenary.calc += #render.z_old catenary.calc
execute store result storage catenary:calc render.centre[0] double 0.0005 run scoreboard players get #render.x catenary.calc
execute store result storage catenary:calc render.centre[1] double 0.0005 run scoreboard players get #render.y catenary.calc
execute store result storage catenary:calc render.centre[2] double 0.0005 run scoreboard players get #render.z catenary.calc

execute store result score #render.x_old catenary.calc run data get storage catenary:calc render.point.pos[0] 1000
execute store result score #render.y_old catenary.calc run data get storage catenary:calc render.point.pos[1] 1000
execute store result score #render.z_old catenary.calc run data get storage catenary:calc render.point.pos[2] 1000