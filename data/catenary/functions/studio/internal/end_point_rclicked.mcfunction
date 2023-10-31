execute store success score #gui_changed catenary.calc run data modify entity @s data.gui set from storage catenary:calc studio.gui

scoreboard players operation #assign catenary.id = @s catenary.id
scoreboard players operation #search catenary.id = @s catenary.id
execute if score #gui_changed catenary.calc matches 1 as @e[type=marker,tag=catenary.studio.end_point,predicate=catenary:match_id] run data remove entity @s data.gui
execute if score #gui_changed catenary.calc matches 1 run data modify entity @s data.gui set from storage catenary:calc studio.gui
execute if score #gui_changed catenary.calc matches 1 as @e[type=minecraft:item_display,tag=catenary.studio.gui.root,predicate=catenary:match_id] run function catenary:studio/internal/gui/kill_recursive
execute if score #gui_changed catenary.calc matches 1 positioned ~ ~0.5 ~ align y positioned ~ ~0.5 ~ run function catenary:studio/internal/gui/spawn with storage catenary:calc studio.gui

execute if score #gui_changed catenary.calc matches 1 run return 0


data modify storage catenary:calc studio.data set from entity @s data.studio_data

scoreboard players set #gui.x catenary.calc 1000
scoreboard players set #gui.y catenary.calc 1000

execute unless score math.ray.hit_axis eroxified.api matches 1 run scoreboard players operation #gui.y catenary.calc = math.ray.hit.y eroxified.api
execute if score math.ray.hit_face eroxified.api matches 0 run scoreboard players operation #gui.x catenary.calc = math.ray.hit.z eroxified.api
execute if score math.ray.hit_face eroxified.api matches 1 run scoreboard players operation #gui.x catenary.calc -= math.ray.hit.z eroxified.api
execute if score math.ray.hit_face eroxified.api matches 4 run scoreboard players operation #gui.x catenary.calc -= math.ray.hit.x eroxified.api
execute if score math.ray.hit_face eroxified.api matches 5 run scoreboard players operation #gui.x catenary.calc = math.ray.hit.x eroxified.api

execute if score math.ray.hit_axis eroxified.api matches 1 store result score #gui.cardinal catenary.calc run data get storage catenary:calc studio.gui.cardinal
execute if score math.ray.hit_axis eroxified.api matches 1 if score #gui.cardinal catenary.calc matches 0 run scoreboard players operation #gui.x catenary.calc = math.ray.hit.x eroxified.api
execute if score math.ray.hit_axis eroxified.api matches 1 if score #gui.cardinal catenary.calc matches 0 run scoreboard players operation #gui.y catenary.calc -= math.ray.hit.z eroxified.api
execute if score math.ray.hit_axis eroxified.api matches 1 if score #gui.cardinal catenary.calc matches 1 run scoreboard players operation #gui.x catenary.calc = math.ray.hit.z eroxified.api
execute if score math.ray.hit_axis eroxified.api matches 1 if score #gui.cardinal catenary.calc matches 1 run scoreboard players operation #gui.y catenary.calc = math.ray.hit.x eroxified.api
execute if score math.ray.hit_axis eroxified.api matches 1 if score #gui.cardinal catenary.calc matches 2 run scoreboard players operation #gui.x catenary.calc -= math.ray.hit.x eroxified.api
execute if score math.ray.hit_axis eroxified.api matches 1 if score #gui.cardinal catenary.calc matches 2 run scoreboard players operation #gui.y catenary.calc = math.ray.hit.z eroxified.api
execute if score math.ray.hit_axis eroxified.api matches 1 if score #gui.cardinal catenary.calc matches 3 run scoreboard players operation #gui.x catenary.calc -= math.ray.hit.z eroxified.api
execute if score math.ray.hit_axis eroxified.api matches 1 if score #gui.cardinal catenary.calc matches 3 run scoreboard players operation #gui.y catenary.calc -= math.ray.hit.x eroxified.api
execute if score math.ray.hit_face eroxified.api matches 2 run scoreboard players set #temp catenary.calc 1000
execute if score math.ray.hit_face eroxified.api matches 2 run scoreboard players operation #temp catenary.calc -= #gui.y catenary.calc
execute if score math.ray.hit_face eroxified.api matches 2 run scoreboard players operation #gui.y catenary.calc = #temp catenary.calc

#tellraw @a ["",{"score":{"name":"#gui.x","objective":"catenary.calc"}},{"text":"  "},{"score":{"name":"#gui.y","objective":"catenary.calc"}}]

execute if score #gui.x catenary.calc matches 63..313 if score #gui.y catenary.calc matches 689..938 run function catenary:studio/internal/button/rope_item
execute if score #gui.x catenary.calc matches 625..938 if score #gui.y catenary.calc matches 813..938 run function catenary:studio/internal/button/rope_sag