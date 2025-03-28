data modify storage catenary:calc anchor_pos set from entity @s Pos

execute on passengers if entity @s[type=interaction] on target if items entity @s weapon.mainhand minecraft:firework_rocket[minecraft:custom_data~{catenary:{detect:true}}] run return run function catenary:rocket/api/click_anchor

data remove storage catenary:calc anchor.interaction
execute on passengers if entity @s[type=interaction] on target if items entity @s weapon.mainhand * run function catenary:anchor/internal/interaction/get_interaction with entity @s SelectedItem
execute if data storage catenary:calc anchor.interaction.function run function catenary:anchor/internal/interaction/call_function with storage catenary:calc anchor.interaction