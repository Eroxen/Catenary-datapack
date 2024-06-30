data modify storage catenary:calc render.provider set value {type:"item",item:{id:"minecraft:player_head"}}

data modify storage catenary:calc render.settings.buffer.char set string storage catenary:calc render.settings.buffer.str 0 1
data modify storage catenary:calc render.settings.buffer.str set string storage catenary:calc render.settings.buffer.str 1
execute if data storage catenary:calc render.settings.buffer{char:" "} run return run data modify storage catenary:calc render.provider set value {type:"empty"}

function catenary:catenary/internal/render/provider/spelling/grab_from_typeface
execute if data storage catenary:calc render.settings.emit_light run data modify storage catenary:calc render.provider.emit_light set from storage catenary:calc render.settings.emit_light