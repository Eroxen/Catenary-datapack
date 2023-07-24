function catenary:3dpath/render/advance

data modify entity @s Pos set from storage catenary:calc render.point

execute at @s summon block_display run function catenary:3dpath/render/decorations/new_display

execute if data storage catenary:calc render.points[0] run function catenary:3dpath/render/decorations/loop