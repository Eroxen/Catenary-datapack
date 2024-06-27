data modify storage catenary:calc macro set value {custom_name:"Catenary"}
data modify storage catenary:calc macro.custom_name set from storage catenary:calc spawn.item_components.minecraft:custom_name
function catenary:rocket/internal/preprocess/get_text with storage catenary:calc macro
execute store result storage catenary:calc spawn.decorations.count int 1 run data get storage catenary:calc spawn.decorations.text