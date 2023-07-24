data modify storage catenary:calc 3dpath.render set from storage catenary:calc 3dpath.samples

execute if data storage catenary:calc 3dpath.render[0] run function catenary:3dpath/test/render_samples_marker_loop

kill @s