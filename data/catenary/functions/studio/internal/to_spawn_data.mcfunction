data modify storage catenary:calc spawn set value {rope:{segment_length:1.0f},sag:1.05f}
function catenary:studio/internal/read_data/rope_item with storage catenary:calc studio.data.settings.rope.item
data modify storage catenary:calc spawn.rope merge from storage catenary:calc studio.rope_item.render