### get pos ###
function catenary:catenary/internal/render/advance
execute if score #render.placement catenary.calc matches 0 run data modify entity @s Pos set from storage catenary:calc render.point.pos
execute if score #render.placement catenary.calc matches 1 run data modify entity @s Pos set from storage catenary:calc render.centre
execute unless score #render.offset catenary.calc matches 0 run function catenary:catenary/internal/render/decorations/offset

### variations ###
execute if score #render.variations catenary.calc matches 1 run function catenary:catenary/internal/render/variations/next

### random rotation ###
execute if score #render.random_rotation catenary.calc matches 1 run function catenary:catenary/internal/render/decorations/random_rotation

### summon display ###
execute if data storage catenary:calc render{type:"block"} at @s summon block_display run function catenary:catenary/internal/render/decorations/new_display
execute if data storage catenary:calc render{type:"item"} at @s summon item_display run function catenary:catenary/internal/render/decorations/new_display

### light ###
execute if score #render.emit_light catenary.calc matches 1 at @s run function catenary:light/api/spawn

### loop ###
execute if data storage catenary:calc render.points[0] run function catenary:catenary/internal/render/decorations/loop