scoreboard players operation #temp catenary.calc = #gui.x catenary.calc
scoreboard players remove #temp catenary.calc 625
scoreboard players set #op catenary.calc 4
scoreboard players operation #temp catenary.calc *= #op catenary.calc
scoreboard players set #op catenary.calc 313
scoreboard players operation #temp catenary.calc /= #op catenary.calc
execute if score #temp catenary.calc matches ..-1 run scoreboard players set #temp catenary.calc 0
execute if score #temp catenary.calc matches 4.. run scoreboard players set #temp catenary.calc 3
execute store result score #old catenary.calc run data get storage catenary:calc studio.data.settings.rope.sag 1

execute if score #temp catenary.calc matches 0 on vehicle on target run title @s actionbar {"text":"Rope Length: 1.0"}
execute if score #temp catenary.calc matches 1 on vehicle on target run title @s actionbar {"text":"Rope Length: 1.01"}
execute if score #temp catenary.calc matches 2 on vehicle on target run title @s actionbar {"text":"Rope Length: 1.05"}
execute if score #temp catenary.calc matches 3 on vehicle on target run title @s actionbar {"text":"Rope Length: 1.1"}

execute if score #temp catenary.calc = #old catenary.calc run return 0

execute store result storage catenary:calc studio.data.settings.rope.sag int 1 run scoreboard players get #temp catenary.calc
execute if score #temp catenary.calc matches 0 run data modify storage catenary:calc studio.spawn.sag set value 1.0f
execute if score #temp catenary.calc matches 1 run data modify storage catenary:calc studio.spawn.sag set value 1.01f
execute if score #temp catenary.calc matches 2 run data modify storage catenary:calc studio.spawn.sag set value 1.05f
execute if score #temp catenary.calc matches 3 run data modify storage catenary:calc studio.spawn.sag set value 1.1f

function catenary:studio/internal/gui/update_rope_sag with storage catenary:calc studio.gui
function catenary:studio/internal/recompute_curve
function catenary:studio/internal/anchor/save_studio_data
function catenary:studio/internal/render/rerender_rope