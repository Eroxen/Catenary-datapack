execute on vehicle on target run function catenary:studio/internal/player/submit_item

execute store success score #item_changed catenary.calc run data modify storage catenary:calc studio.data.settings.rope.item set from storage catenary:calc studio.submitted_item
execute if score #item_changed catenary.calc matches 0 run return 0

function catenary:studio/internal/read_data/rope_item with storage catenary:calc studio.data.settings.rope.item
execute unless data storage catenary:calc studio.rope_item.render on vehicle on target run tellraw @s {"text":"This item cannot be used as a rope material."}
execute unless data storage catenary:calc studio.rope_item.render run return 0

data modify storage catenary:calc studio.data.spawn.rope.type set from storage catenary:calc studio.rope_item.render.type
data modify storage catenary:calc studio.data.spawn.rope.EntityData set from storage catenary:calc studio.rope_item.render.EntityData

function catenary:studio/internal/gui/update_rope_item with storage catenary:calc studio.gui
function catenary:studio/internal/anchor/save_studio_data
function catenary:studio/internal/render/rerender_rope