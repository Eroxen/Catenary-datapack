scoreboard players set #render.rotation catenary.calc 0
execute if data storage catenary:calc spawn.decorations.rotation.horizontal.add store result score #temp catenary.calc run data get storage catenary:calc spawn.decorations.rotation.horizontal.add 10000
execute if data storage catenary:calc spawn.decorations.rotation.horizontal.add run scoreboard players operation #render.rotation catenary.calc += #temp catenary.calc
execute if data storage catenary:calc spawn.decorations.rotation.horizontal{inherit_rope:true} run scoreboard players operation #render.rotation catenary.calc += #render.angle catenary.calc
execute if score #render.rotation catenary.calc matches ..-5400001 run scoreboard players add #render.rotation catenary.calc 7200000
execute if score #render.rotation catenary.calc matches ..-1800001 run scoreboard players add #render.rotation catenary.calc 3600000
execute if score #render.rotation catenary.calc matches 5400001.. run scoreboard players remove #render.rotation catenary.calc 7200000
execute if score #render.rotation catenary.calc matches 1800001.. run scoreboard players remove #render.rotation catenary.calc 3600000
execute if data storage catenary:calc spawn.decorations.rotation.horizontal store result storage catenary:calc render.default.Rotation[0] float 0.0001 run scoreboard players get #render.rotation catenary.calc