execute store result score 2dpath.l catenary.calc run data get storage catenary:calc 2dpath.l_cum[-1] 1000
scoreboard players operation 2dpath.samples catenary.calc = 2dpath.l catenary.calc
scoreboard players operation 2dpath.samples catenary.calc /= 2dpath.segment_length catenary.calc
scoreboard players add 2dpath.samples catenary.calc 1

scoreboard players set 2dpath.sample catenary.calc -1
execute store result score #2dpath.sample.dx.0 catenary.calc run data get storage catenary:calc 2dpath.sample.x[0] 1000
execute store result score #2dpath.sample.dy.0 catenary.calc run data get storage catenary:calc 2dpath.sample.y[0] 1000
function catenary:2dpath/next_sample
data modify storage catenary:calc 2dpath.samples set value []
data modify storage catenary:calc 2dpath.samples_d set value []
data modify storage catenary:calc 2dpath.sample set value {}
data modify storage catenary:calc 2dpath.sample.l_cum set from storage catenary:calc 2dpath.l_cum
data modify storage catenary:calc 2dpath.sample.x set from storage catenary:calc 2dpath.x
data modify storage catenary:calc 2dpath.sample.y set from storage catenary:calc 2dpath.y
execute if data storage catenary:calc 2dpath.sample.l_cum[0] run function catenary:2dpath/sample_loop
data remove storage catenary:calc 2dpath.sample