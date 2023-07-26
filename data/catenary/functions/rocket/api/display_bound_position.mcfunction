execute store result score #display.x.i catenary.calc run data get entity @s SelectedItem.tag.catenary.pos1[0] 10
execute store result score #display.y.i catenary.calc run data get entity @s SelectedItem.tag.catenary.pos1[1] 10
execute store result score #display.z.i catenary.calc run data get entity @s SelectedItem.tag.catenary.pos1[2] 10
scoreboard players operation #display.x.d catenary.calc = #display.x.i catenary.calc
scoreboard players operation #display.y.d catenary.calc = #display.y.i catenary.calc
scoreboard players operation #display.z.d catenary.calc = #display.z.i catenary.calc
scoreboard players operation #display.x.i catenary.calc /= 10 catenary.calc
scoreboard players operation #display.y.i catenary.calc /= 10 catenary.calc
scoreboard players operation #display.z.i catenary.calc /= 10 catenary.calc
scoreboard players operation #display.x.d catenary.calc %= 10 catenary.calc
scoreboard players operation #display.y.d catenary.calc %= 10 catenary.calc
scoreboard players operation #display.z.d catenary.calc %= 10 catenary.calc

title @s actionbar {"translate":"Bound to: %s.%s, %s.%s, %s.%s","with":[{"score":{"name":"#display.x.i","objective":"catenary.calc"}},{"score":{"name":"#display.x.d","objective":"catenary.calc"}},{"score":{"name":"#display.y.i","objective":"catenary.calc"}},{"score":{"name":"#display.y.d","objective":"catenary.calc"}},{"score":{"name":"#display.z.i","objective":"catenary.calc"}},{"score":{"name":"#display.z.d","objective":"catenary.calc"}}]}