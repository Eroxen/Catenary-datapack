data modify storage catenary:calc create_curve set value {}
data modify storage catenary:calc create_curve.sag set from storage catenary:calc studio.spawn.sag
data modify storage catenary:calc create_curve.pos1 set from storage catenary:calc studio.data.pos1
data modify storage catenary:calc create_curve.pos2 set from storage catenary:calc studio.data.pos2
function catenary:curve/api/create
execute store result score #curve.sample_distance catenary.calc run data get storage catenary:calc spawn.rope.segment_length 1000
function catenary:curve/api/sample
data modify storage catenary:calc studio.data.curve set from storage catenary:calc curve