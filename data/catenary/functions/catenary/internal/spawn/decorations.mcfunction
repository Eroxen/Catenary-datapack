execute if data storage catenary:calc spawn.decorations.spacing store result score #curve.sample_distance catenary.calc run data get storage catenary:calc spawn.decorations.spacing 1000
execute if data storage catenary:calc spawn.decorations.spacing run function catenary:curve/api/sample

execute if data storage catenary:calc spawn.decorations.count run scoreboard players set #curve.sample_distance catenary.calc 0
execute if data storage catenary:calc spawn.decorations.count store result score #curve.sample_count catenary.calc run data get storage catenary:calc spawn.decorations.count 1
execute if data storage catenary:calc spawn.decorations.count run scoreboard players add #curve.sample_count catenary.calc 2
execute if data storage catenary:calc spawn.decorations.count run function catenary:curve/api/sample

function catenary:catenary/internal/render/decorations