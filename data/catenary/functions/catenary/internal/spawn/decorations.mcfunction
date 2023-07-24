execute unless data storage catenary:calc spawn.decorations.spacing run scoreboard players set 2dpath.segment_length catenary.calc 1000
execute if data storage catenary:calc spawn.decorations.spacing store result score 2dpath.segment_length catenary.calc run data get storage catenary:calc spawn.decorations.spacing 1000
data modify storage catenary:calc 2dpath set from storage catenary:calc 3dpath.2dpath
function catenary:3dpath/sample
function catenary:3dpath/render/decorations/render