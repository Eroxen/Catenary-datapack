from catenary:flop import Eroxifloat

scoreboard objectives add catenary.calc dummy
scoreboard objectives add catenary.id dummy
scoreboard objectives add catenary.config dummy

scoreboard players set min_length catenary.config 75
scoreboard players set max_length catenary.config 6400

function #catenary:load/ratio_params
function #catenary:load/math

schedule function catenary:tick/1t 3t replace
schedule function catenary:tick/10t 3t replace

scoreboard players set -1 catenary.calc -1
scoreboard players set 2 catenary.calc 2
scoreboard players set 3 catenary.calc 3
scoreboard players set 10 catenary.calc 10
scoreboard players set 50 catenary.calc 50
scoreboard players set 100 catenary.calc 100
scoreboard players set 1000 catenary.calc 1000
scoreboard players set 10000 catenary.calc 10000

_ = Eroxifloat("catenary.calc", "float_0.5").immediate(0.5)