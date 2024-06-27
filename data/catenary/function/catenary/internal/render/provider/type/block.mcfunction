data modify storage catenary:calc render.entity merge value {type:"minecraft:block_display",data:{transformation:{translation:[-0.5f,-0.5f,-0.5f]}}}
execute if score #render.axis_scaling catenary.calc matches 1 run data modify storage catenary:calc render.entity.data.transformation.translation[2] set value 0.0f
data modify storage catenary:calc render.entity.data merge from storage catenary:calc render.default
data modify storage catenary:calc render.entity.data.block_state set from storage catenary:calc render.provider.block_state
execute if data storage catenary:calc render.provider.transformation run data modify storage catenary:calc render.entity.data.transformation merge from storage catenary:calc render.provider.transformation



execute if score #render.axis_scaling catenary.calc matches 0 run return 0
### scale model ###
scoreboard players set #render.scale catenary.calc 1000
scoreboard players operation #render.scale catenary.calc *= #render.distance catenary.calc
scoreboard players set #temp catenary.calc 1000
execute if data storage catenary:calc render.provider.full_length store result score #temp catenary.calc run data get storage catenary:calc render.provider.full_length 1000
scoreboard players operation #render.scale catenary.calc /= #temp catenary.calc
execute if score #render.scaling_axis catenary.calc matches 0 store result storage catenary:calc render.entity.data.transformation.scale[0] float 0.001 run scoreboard players get #render.scale catenary.calc
execute if score #render.scaling_axis catenary.calc matches 1 store result storage catenary:calc render.entity.data.transformation.scale[1] float 0.001 run scoreboard players get #render.scale catenary.calc
execute if score #render.scaling_axis catenary.calc matches 2 store result storage catenary:calc render.entity.data.transformation.scale[2] float 0.001 run scoreboard players get #render.scale catenary.calc

execute store result score #temp catenary.calc run data get storage catenary:calc render.entity.data.transformation.translation[2] 2000
scoreboard players operation #temp catenary.calc += #render.distance catenary.calc
execute store result storage catenary:calc render.entity.data.transformation.translation[2] float -0.0005 run scoreboard players get #temp catenary.calc