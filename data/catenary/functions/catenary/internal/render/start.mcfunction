data modify storage catenary:calc render set value {}
data modify storage catenary:calc render.points set from storage catenary:calc curve.samples
data modify storage catenary:calc render.point set from storage catenary:calc render.points[0]
data remove storage catenary:calc render.points[0]

execute store result score #render.x_old catenary.calc run data get storage catenary:calc render.point.pos[0] 1000
execute store result score #render.y_old catenary.calc run data get storage catenary:calc render.point.pos[1] 1000
execute store result score #render.z_old catenary.calc run data get storage catenary:calc render.point.pos[2] 1000

data modify storage catenary:calc render.centre set value [0d,0d,0d]