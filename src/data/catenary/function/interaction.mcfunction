from eroxified2:interaction import call_on_lclick, call_on_rclick
from eroxified2:entity import kill_stack

function ~/rclicked:
  call_on_rclick()
  execute if entity @s[tag=catenary.anchor]:
    execute on target store success score #internal.temp catenary.calc if items entity @s weapon.mainhand minecraft:firework_rocket[custom_data~{catenary:{detect:true}}]
    execute if score #internal.temp catenary.calc matches 1 run return run function catenary:rocket/click_end_point
    execute on target store success score #internal.temp catenary.calc if items entity @s weapon.mainhand minecraft:bow
    execute if score #internal.temp catenary.calc matches 1 run return run function catenary:zipline/click_end_point
    execute on target store success score #internal.temp catenary.calc if items entity @s weapon.mainhand minecraft:poisonous_potato[custom_data~{catenary:{upgrade:true}}]
    execute if score #internal.temp catenary.calc matches 1 run return run function catenary:upgrades/click_end_point
    execute on target store success score #internal.temp catenary.calc if items entity @s weapon.mainhand minecraft:honeycomb
    execute if score #internal.temp catenary.calc matches 1 run return run function catenary:upgrades/apply_wax
    execute on target store success score #internal.temp catenary.calc if items entity @s weapon.mainhand #minecraft:axes
    execute if score #internal.temp catenary.calc matches 1 run return run function catenary:upgrades/remove_wax

function ~/lclicked:
  call_on_lclick()
  execute if entity @s[tag=catenary.anchor]:
    execute on attacker store success score #survival_or_adventure catenary.calc if predicate catenary:survival_or_adventure
    scoreboard players set #catenary.broken catenary.calc 0
    execute on vehicle on passengers if entity @s[type=item_display,tag=catenary.end_point,tag=!catenary.end_point.waxed] at @s run function catenary:catenary/hit_end_point
    execute on attacker run scoreboard players operation @s catenary.stats.catenaries_broken += #catenary.broken catenary.calc
    scoreboard players set #internal.temp catenary.calc 0
    execute on vehicle on passengers if entity @s[type=item_display,tag=catenary.end_point] run scoreboard players set #internal.temp catenary.calc 1
    execute if score #internal.temp catenary.calc matches 0 on vehicle run function eroxified2:entity/api/kill_stack