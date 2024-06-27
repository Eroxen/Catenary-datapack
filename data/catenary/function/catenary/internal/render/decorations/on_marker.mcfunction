### start ###
function catenary:catenary/internal/render/start
data modify storage catenary:calc render.settings set from storage catenary:calc spawn.decorations
data modify storage catenary:calc render.default merge from storage catenary:calc render.settings.default
scoreboard players set #render.axis_scaling catenary.calc 0
scoreboard players set #render.placement catenary.calc 0
execute if data storage catenary:calc spawn.decorations{placement:"middle"} run scoreboard players set #render.placement catenary.calc 1
scoreboard players set #render.offset catenary.calc 0
execute if data storage catenary:calc spawn.decorations.offset store result score #render.offset catenary.calc run data get storage catenary:calc spawn.decorations.offset 1000
function catenary:catenary/internal/render/provider/init

execute if score #render.placement catenary.calc matches 0 run data remove storage catenary:calc render.points[-1]

### enter loop ###
execute if data storage catenary:calc render.points[0] run function catenary:catenary/internal/render/decorations/loop

kill @s