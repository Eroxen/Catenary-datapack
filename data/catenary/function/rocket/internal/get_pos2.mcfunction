data modify storage catenary:calc spawn set value {}

data modify storage catenary:calc spawn.pos2 set from storage catenary:calc EntityData.Pos
data modify storage catenary:calc spawn.item_components set from storage catenary:calc EntityData.FireworksItem.components
function catenary:rocket/internal/extract_item_data