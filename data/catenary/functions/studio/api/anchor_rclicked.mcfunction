data modify storage catenary:calc macro set value {from:[-0.5d,0.01d,-0.5d],to:[0.5d,1.01d,0.5d]}
execute on passengers if entity @s[type=marker,tag=catenary.studio.end_point] run data modify storage catenary:calc macro.origin set from entity @s Pos
execute on target run data modify storage catenary:calc macro.rotation set from entity @s Rotation
execute on target at @s anchored eyes positioned ^ ^ ^ run function eroxified:api/math/ray/intersect_box with storage catenary:calc macro

execute if score math.ray.hit eroxified.api matches 0 run return 0

data modify storage catenary:calc studio.gui set value {rotation:[0f,0f],offset:"~ ~ ~0.5",cardinal:0}

execute if score math.ray.hit_face eroxified.api matches 0 run data modify storage catenary:calc studio.gui set value {rotation:[90f,0f],offset:"~-0.501 ~ ~"}
execute if score math.ray.hit_face eroxified.api matches 4 run data modify storage catenary:calc studio.gui set value {rotation:[180f,0f],offset:"~ ~ ~-0.501"}
execute if score math.ray.hit_face eroxified.api matches 1 run data modify storage catenary:calc studio.gui set value {rotation:[-90f,0f],offset:"~0.501 ~ ~"}
execute if score math.ray.hit_face eroxified.api matches 2 run data modify storage catenary:calc studio.gui set value {rotation:[0f,90f],offset:"~ ~-0.501 ~"}
execute if score math.ray.hit_face eroxified.api matches 3 run data modify storage catenary:calc studio.gui set value {rotation:[0f,-90f],offset:"~ ~0.501 ~"}

execute if score math.ray.hit_axis eroxified.api matches 1 on target if entity @s[y_rotation=-135..-45] run data modify storage catenary:calc studio.gui.rotation[0] set value 90f
execute if score math.ray.hit_axis eroxified.api matches 1 on target if entity @s[y_rotation=-135..-45] run data modify storage catenary:calc studio.gui.cardinal set value 1
execute if score math.ray.hit_axis eroxified.api matches 1 on target if entity @s[y_rotation=-45..45] run data modify storage catenary:calc studio.gui.rotation[0] set value 180f
execute if score math.ray.hit_axis eroxified.api matches 1 on target if entity @s[y_rotation=-45..45] run data modify storage catenary:calc studio.gui.cardinal set value 2
execute if score math.ray.hit_axis eroxified.api matches 1 on target if entity @s[y_rotation=45..135] run data modify storage catenary:calc studio.gui.rotation[0] set value -90f
execute if score math.ray.hit_axis eroxified.api matches 1 on target if entity @s[y_rotation=45..135] run data modify storage catenary:calc studio.gui.cardinal set value 3

execute on passengers if entity @s[type=marker,tag=catenary.studio.end_point] run function catenary:studio/internal/end_point_rclicked