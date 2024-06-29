data modify storage catenary:calc render.entity set value {x:0f,y:0f,z:0f,data:{width:1,height:1,Tags:["catenary.render","catenary.entity","catenary.render.new"],Rotation:[0f,0f],transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[1f,1f,1f]}}}

execute if data storage catenary:calc render.provider{type:"block"} run function catenary:catenary/internal/render/provider/type/block
execute if data storage catenary:calc render.provider{type:"loot_table"} run function catenary:catenary/internal/render/provider/type/loot_table
execute if data storage catenary:calc render.provider{type:"item"} run function catenary:catenary/internal/render/provider/type/item

execute if data storage catenary:calc render.provider.emit_light run data modify storage catenary:calc render.entity.emit_light set from storage catenary:calc render.provider.emit_light
execute if data storage catenary:calc render.provider.brightness run data modify storage catenary:calc render.entity.data.brightness merge from storage catenary:calc render.provider.brightness
execute if data storage catenary:calc render.settings.rotation.horizontal.add_random run function catenary:catenary/internal/render/provider/random_rotation