data modify storage catenary:calc macro set value {min:0,max:0}
execute store result storage catenary:calc macro.min int 1 run data get storage catenary:calc render.settings.rotation.horizontal.add_random.min 10000
execute store result storage catenary:calc macro.max int 1 run data get storage catenary:calc render.settings.rotation.horizontal.add_random.max 10000
function catenary:math/rng with storage catenary:calc macro
execute store result score #render.rotation catenary.calc run data get storage catenary:calc render.entity.data.Rotation[0] 10000
scoreboard players operation #render.rotation catenary.calc += math.random.value catenary.calc
execute if score #render.rotation catenary.calc matches ..-5400001 run scoreboard players add #render.rotation catenary.calc 7200000
execute if score #render.rotation catenary.calc matches ..-1800001 run scoreboard players add #render.rotation catenary.calc 3600000
execute if score #render.rotation catenary.calc matches 5400001.. run scoreboard players remove #render.rotation catenary.calc 7200000
execute if score #render.rotation catenary.calc matches 1800001.. run scoreboard players remove #render.rotation catenary.calc 3600000
execute store result storage catenary:calc render.entity.data.Rotation[0] float 0.0001 run scoreboard players get #render.rotation catenary.calc