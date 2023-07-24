execute if data storage catenary:calc spawn.decorations.spacing store result score #curve.sample_distance catenary.calc run data get storage catenary:calc spawn.decorations.spacing 1000
execute if data storage catenary:calc spawn.decorations.spacing run function catenary:curve/api/sample

function catenary:catenary/internal/render/decorations