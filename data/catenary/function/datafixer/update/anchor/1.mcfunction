execute if score @s eroxified2.datafixer_version matches 2.. run return run scoreboard players operation @s eroxified2.datafixer_version = catenary eroxified2.datafixer_version
scoreboard players operation @s eroxified2.datafixer_version = catenary eroxified2.datafixer_version

execute on passengers if entity @s[type=item_display] run tag @s add catenary.anchor
execute on passengers if entity @s[type=item_display] run tp @s ~ ~ ~

execute on passengers run tag @s add catenary.datafixer.remount
tag @s add catenary.datafixer.remount
execute on passengers run ride @s dismount

execute as @e[tag=catenary.datafixer.remount,distance=..1] run ride @s mount @n[type=item_display,tag=catenary.anchor,distance=..0.1]
tag @e[tag=catenary.datafixer.remount,distance=..1] remove catenary.datafixer.remount