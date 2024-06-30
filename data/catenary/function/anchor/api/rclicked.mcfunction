execute on target run advancement grant @s only catenary:trigger/send_welcome_message

data modify storage catenary:calc anchor_pos set from entity @s Pos

execute on target if items entity @s weapon.mainhand minecraft:firework_rocket[minecraft:custom_data~{catenary:{detect:true}}] run function catenary:rocket/api/click_anchor