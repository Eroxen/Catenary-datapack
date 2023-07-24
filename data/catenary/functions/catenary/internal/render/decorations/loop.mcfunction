### get pos ###
function catenary:catenary/internal/render/advance
data modify entity @s Pos set from storage catenary:calc render.point.pos

### summon display ###
execute at @s summon block_display run function catenary:catenary/internal/render/decorations/new_block_display

### loop ###
execute if data storage catenary:calc render.points[0] run function catenary:catenary/internal/render/decorations/loop