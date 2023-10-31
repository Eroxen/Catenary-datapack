scoreboard players set #op catenary.calc 78
scoreboard players operation #temp catenary.calc *= #op catenary.calc
scoreboard players add #temp catenary.calc 157

$execute positioned ~ ~0.5 ~ align y positioned ~ ~0.5 ~ positioned $(offset) store result entity @e[type=text_display,tag=catenary.studio.gui.button.rope_length_slider,distance=..0.1,limit=1] transformation.translation[0] float 0.001 run scoreboard players get #temp catenary.calc