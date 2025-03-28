function catenary:catenary/internal/render/provider/choose

### get pos and rotation###
function catenary:catenary/internal/render/advance
function catenary:catenary/internal/render/provider/generate_entity
tp @e[type=marker,tag=catenaty.render.marker.1,limit=1] @s
data modify entity @s Pos set from storage catenary:calc render.point.pos
execute at @s run tp @s ~ ~ ~ facing entity @e[type=marker,tag=catenaty.render.marker.1,limit=1]

data modify storage catenary:calc render.entity.x set from storage catenary:calc render.centre[0]
data modify storage catenary:calc render.entity.y set from storage catenary:calc render.centre[1]
data modify storage catenary:calc render.entity.z set from storage catenary:calc render.centre[2]
data modify storage catenary:calc render.entity.data.Rotation[1] set from entity @s Rotation[1]

### summon display ###
execute if data storage catenary:calc render.entity run function catenary:catenary/internal/render/summon_display with storage catenary:calc render.entity

### loop ###
execute if data storage catenary:calc render.points[0] run function catenary:catenary/internal/render/rope/loop