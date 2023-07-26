scoreboard objectives add catenary.calc dummy
scoreboard objectives add catenary.id dummy

scoreboard players set -1 catenary.calc -1
scoreboard players set 2 catenary.calc 2
scoreboard players set 10 catenary.calc 10
scoreboard players set 100 catenary.calc 100
scoreboard players set 1000 catenary.calc 1000
scoreboard players set 10000 catenary.calc 10000

### ensure sufficient command chain length ###
execute store result score maxCommandChainLength catenary.calc run gamerule maxCommandChainLength
execute unless score maxCommandChainLength catenary.calc matches 1000000.. run gamerule maxCommandChainLength 1000000

### compatibility ###
data modify storage catenary:calc eroxified_installed set value 0b
data remove storage eroxified:compatibility installed
schedule function catenary:compatibility/install 1t
schedule function catenary:compatibility/scan 2t

schedule function catenary:clock_10t 10t replace