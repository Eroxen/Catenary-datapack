data remove storage catenary:calc studio.rope_item
$data modify storage catenary:calc studio.rope_item set from storage catenary:calc studio_data.rope_items[{items:["$(id)"]}]

$execute if data storage catenary:calc studio.rope_item.render{type:"block"} unless data storage catenary:calc studio.rope_item.render.EntityData.block_state.Name run data modify storage catenary:calc studio.rope_item.render.EntityData.block_state.Name set value "$(id)"
execute if data storage catenary:calc studio.rope_item.render{type:"item"} unless data storage catenary:calc studio.rope_item.render.EntityData.item run data modify storage catenary:calc studio.rope_item.render.EntityData.item set from storage catenary:calc studio.submitted_item