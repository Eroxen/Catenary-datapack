data modify entity @s Pos set from storage catenary:calc 3dpath.render[0]
execute at @s run particle minecraft:block_marker sunflower[half=upper]
data remove storage catenary:calc 3dpath.render[0]

execute if data storage catenary:calc 3dpath.render[0] run function catenary:3dpath/test/render_samples_marker_loop