function ~/rclicked:
  execute if entity @s[tag=catenary.anchor]:
    execute on target store success score #internal.temp catenary.calc if items entity @s weapon.mainhand minecraft:firework_rocket[custom_data~{catenary:{detect:true}}]
    execute if score #internal.temp catenary.calc matches 1 run return run function catenary:rocket/click_end_point
    execute on target store success score #internal.temp catenary.calc if items entity @s weapon.mainhand minecraft:bow
    execute if score #internal.temp catenary.calc matches 1 run return run function catenary:zipline/click_end_point

function ~/lclicked:
  execute if entity @s[tag=catenary.anchor]:
    execute on attacker store success score #survival_or_adventure catenary.calc if predicate catenary:survival_or_adventure
    execute on vehicle on passengers if entity @s[type=item_display,tag=catenary.end_point] at @s run function catenary:catenary/hit_end_point
    scoreboard players set #internal.temp catenary.calc 0
    execute on vehicle on passengers if entity @s[type=item_display,tag=catenary.end_point] run scoreboard players set #internal.temp catenary.calc 1
    execute if score #internal.temp catenary.calc matches 0 on vehicle run function eroxified2:entity/api/kill_stack