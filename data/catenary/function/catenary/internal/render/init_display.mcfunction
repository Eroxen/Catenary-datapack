scoreboard players operation @s catenary.id = #assign catenary.id
tag @s remove catenary.render.new

execute if data storage catenary:calc render.entity.emit_light store result score #light_level catenary.calc run data get storage catenary:calc render.entity.emit_light 1
execute if data storage catenary:calc render.entity.emit_light run function catenary:light/api/spawn

execute if data storage catenary:calc render.entity.init.insert_loot_table run function catenary:catenary/internal/render/init_display/insert_loot_table with storage catenary:calc render.entity.init