data remove storage catenary:calc studio.submitted_item
data modify storage catenary:calc studio.submitted_item set from entity @s SelectedItem
execute if data storage catenary:calc studio.submitted_item run data modify storage catenary:calc studio.submitted_item.Count set value 1b