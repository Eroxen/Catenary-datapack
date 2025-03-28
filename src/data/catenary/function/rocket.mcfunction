from colorsys import hsv_to_rgb
from nbtlib import Double

PATH = ~/placed

advancement PATH {
  "parent": "catenary:trigger/root",
  "criteria": {
    "requirement": {
      "trigger": "minecraft:item_used_on_block",
      "conditions": {
        "location": [
          {
            "condition": "minecraft:match_tool",
            "predicate": {
              "items": "minecraft:firework_rocket",
              "predicates": {
                "minecraft:custom_data": {
                  "catenary": {
                    "detect": true
                  }
                }
              }
            }
          }
        ]
      }
    }
  },
  "rewards": {
    "function": PATH
  }
}

function PATH:
  advancement revoke @s only PATH
  say a
  tag @s add catenary.rocket_user
  execute as @e[type=minecraft:firework_rocket,distance=..16,nbt={FireworksItem:{components:{"minecraft:custom_data":{catenary:{detect:true}}}}}] at @s if function ~/../match_origin run function ~/../placed_on_rocket
  tag @s remove catenary.rocket_user

function ~/match_origin:
  execute on origin if entity @s[tag=catenary.rocket_user] run return 1
  return fail

function ~/reimburse:
  $execute if predicate catenary:survival_or_adventure unless items entity @s weapon.mainhand * run return run loot replace entity @s weapon.mainhand loot {"pools":[{"rolls":1,"entries":[{"type":"minecraft:item","name": "$(id)","functions":[{"function":"minecraft:set_components","components":$(components)}]}]}]}
  $execute if predicate catenary:survival_or_adventure run loot give @s loot {"pools":[{"rolls":1,"entries":[{"type":"minecraft:item","name": "$(id)","functions":[{"function":"minecraft:set_components","components":$(components)}]}]}]}

function ~/placed_on_rocket:
  data modify storage catenary:calc rocket.entity_data set from entity @s {}
  data modify storage catenary:calc rocket.item set from storage catenary:calc rocket.entity_data.FireworksItem
  execute on origin run function ~/../placed_on_player
  kill @s

function ~/placed_on_player:
  function ~/../get_storage
  execute unless data storage catenary:calc rocket.player_storage.loaded.selected_pos run return:
    say no pos yet
    data modify storage catenary:calc rocket.player_storage.loaded.selected_pos set from storage catenary:calc rocket.entity_data.Pos
    function ~/../reimburse with storage catenary:calc rocket.item
    tag @s add catenary.rocket.has_selected_pos
    function ~/../has_selected_clock
  
  function ~/../deselect

function ~/deselect:
  function ~/../get_storage
  say deselect
  data remove storage catenary:calc rocket.player_storage.loaded.selected_pos
  tag @s remove catenary.rocket.has_selected_pos


function ~/has_selected_tick:
  function ~/../get_storage
  execute unless data storage catenary:calc rocket.player_storage.loaded.selected_pos run return run function ~/../deselect

  scoreboard players set #raycast.i catenary.calc 50
  execute anchored eyes positioned ^ ^ ^ run function ~/../raycast

function ~/raycast:
  scoreboard players remove #raycast.i catenary.calc 1
  execute if score #raycast.i catenary.calc matches 1.. positioned ^ ^ ^0.1 if block ~ ~ ~ #catenary:raycast run return run function ~/

  # on hit pos
  data modify storage catenary:calc internal.temp set value {colour:[1d,0d,0d]}
  execute summon marker:
    data modify storage catenary:calc internal.temp.pos set from entity @s Pos
    kill @s
  data modify storage catenary:calc internal.temp.target set from storage catenary:calc rocket.player_storage.loaded.selected_pos

  scoreboard players set #rocket.squared_distance catenary.calc 0
  for i in range(3):
    execute store result score #internal.temp.a catenary.calc run data get storage catenary:calc internal.temp.pos[i] 100
    execute store result score #internal.temp.b catenary.calc run data get storage catenary:calc rocket.player_storage.loaded.selected_pos[i] 100
    scoreboard players operation #internal.temp.a catenary.calc -= #internal.temp.b catenary.calc
    scoreboard players operation #internal.temp.a catenary.calc *= #internal.temp.a catenary.calc
    scoreboard players operation #rocket.squared_distance catenary.calc += #internal.temp.a catenary.calc
  
  scoreboard players operation #internal.temp.a catenary.calc = #setting.max_length catenary.calc
  scoreboard players add #internal.temp.a catenary.calc 1600
  scoreboard players operation #internal.temp.a catenary.calc *= #internal.temp.a catenary.calc
  execute if score #rocket.squared_distance catenary.calc > #internal.temp.a catenary.calc run return run function ~/../deselect
  
  scoreboard players operation #internal.temp.a catenary.calc = #setting.min_length catenary.calc
  scoreboard players operation #internal.temp.a catenary.calc *= #internal.temp.a catenary.calc
  scoreboard players operation #internal.temp.b catenary.calc = #setting.max_length catenary.calc
  scoreboard players operation #internal.temp.b catenary.calc *= #internal.temp.b catenary.calc

  execute if score #rocket.squared_distance catenary.calc >= #internal.temp.a catenary.calc if score #rocket.squared_distance catenary.calc <= #internal.temp.b catenary.calc:
    execute store result score #rocket.colour catenary.calc run time query gametime
    scoreboard players operation #rocket.colour catenary.calc %= 50 catenary.calc
    for i in range(50):
      c = list(hsv_to_rgb(i/50, 1, 1))
      execute if score #rocket.colour catenary.calc matches i run data modify storage catenary:calc internal.temp.colour set value [Double(c[0]), Double(c[1]), Double(c[2])]

  function ~/../particle with storage catenary:calc internal.temp


function ~/particle:
  $particle minecraft:trail{target:$(target),duration:20,color:$(colour)} ~ ~ ~ 0 0 0 0 1 normal @s

function ~/has_selected_clock:
  execute if entity @a[tag=catenary.rocket.has_selected_pos] run schedule function ~/ 1t replace
  execute as @a[tag=catenary.rocket.has_selected_pos] at @s run function ~/../has_selected_tick


function ~/get_storage:
  execute if score #rocket.storage_player catenary.calc = @s eroxified2.playerid run return fail
  execute if score #rocket.storage_player catenary.calc matches 1..:
    data modify storage catenary:calc internal.temp set value {id:0}
    execute store result storage catenary:calc internal.temp.id int 1 run scoreboard players get #rocket.storage_player catenary.calc
    function ~/../set_storage_macro with storage catenary:calc internal.temp
  data modify storage catenary:calc rocket.player_storage.loaded set value {}
  function eroxified2:playerid/api/get_macro_object
  function ~/../get_storage_macro with storage eroxified2:api playerid.macro
  scoreboard players operation #rocket.storage_player catenary.calc = @s eroxified2.playerid

function ~/get_storage_macro:
  $data modify storage catenary:calc rocket.player_storage.loaded set from storage catenary:calc rocket.player_storage.saved.$(id)

function ~/set_storage_macro:
  $data modify storage catenary:calc rocket.player_storage.saved.$(id) set from storage catenary:calc rocket.player_storage.loaded