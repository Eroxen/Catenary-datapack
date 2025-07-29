from eroxified2:core import run_at_pack_load, call_on_player_joined

run_at_pack_load()
function flop:api/create_scoreboards

from catenary:flop import Eroxifloat
from catenary:utils import register_scoreboard_objective

scoreboard objectives add register_scoreboard_objective("catenary.calc") dummy
scoreboard objectives add register_scoreboard_objective("catenary.id") dummy
scoreboard objectives add register_scoreboard_objective("catenary.config") dummy

### ensure sufficient command chain length ###
execute store result score maxCommandChainLength catenary.calc run gamerule maxCommandChainLength
execute unless score maxCommandChainLength catenary.calc matches 1000000.. run gamerule maxCommandChainLength 1000000

function #catenary:load/ratio_params
function #catenary:load/math
function #catenary:load/typefaces

function catenary:dialog/load
function catenary:statistics/load
function catenary:config/load

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
_ = Eroxifloat("catenary.calc", "float_1").immediate(1)

function ~/player_joined:
  call_on_player_joined()
  function #catenary:enable_triggers