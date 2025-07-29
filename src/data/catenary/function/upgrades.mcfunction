import eroxified2:item as eroxified2_item

from catenary:item import CatenaryItem
from eroxified2:custom_item import data_generator, transformer
from catenary:flop import Eroxifloat
from catenary:utils import Translations

### API ###
function ~/apply_wax:
  scoreboard players set #internal.temp catenary.calc 0
  execute on vehicle on passengers if entity @s[type=item_display,tag=catenary.end_point] unless entity @s[tag=catenary.end_point.waxed]:
    scoreboard players add #internal.temp catenary.calc 1
    scoreboard players operation #search catenary.id = @s catenary.id
    tag @e[type=item_display,tag=catenary.end_point,predicate=catenary:match_id] add catenary.end_point.waxed
    execute at @e[type=block_display,tag=catenary.display,predicate=catenary:match_id] run particle minecraft:wax_on ~ ~ ~ 0.2 0.2 0.2 0 3
    execute at @e[type=item_display,tag=catenary.display,predicate=catenary:match_id] run particle minecraft:wax_on ~ ~ ~ 0.2 0.2 0.2 0 3
  execute if score #internal.temp catenary.calc matches 1.. on target:
    scoreboard players operation @s catenary.stats.catenaries_waxed += #internal.temp catenary.calc
    playsound minecraft:item.honeycomb.wax_on block @s
    advancement grant @s only minecraft:husbandry/wax_on
  particle minecraft:wax_on ~ ~0.15 ~ 0.15 0.15 0.15 0 5

function ~/remove_wax:
  scoreboard players set #internal.temp catenary.calc 0
  execute on vehicle on passengers if entity @s[type=item_display,tag=catenary.end_point] if entity @s[tag=catenary.end_point.waxed]:
    scoreboard players add #internal.temp catenary.calc 1
    scoreboard players operation #search catenary.id = @s catenary.id
    tag @e[type=item_display,tag=catenary.end_point,predicate=catenary:match_id] remove catenary.end_point.waxed
    execute at @e[type=block_display,tag=catenary.display,predicate=catenary:match_id] run particle minecraft:wax_off ~ ~ ~ 0.2 0.2 0.2 0 3
    execute at @e[type=item_display,tag=catenary.display,predicate=catenary:match_id] run particle minecraft:wax_off ~ ~ ~ 0.2 0.2 0.2 0 3
  execute if score #internal.temp catenary.calc matches 1.. on target:
    scoreboard players operation @s catenary.stats.catenaries_unwaxed += #internal.temp catenary.calc
    playsound minecraft:item.axe.wax_off block @s
    advancement grant @s only minecraft:husbandry/wax_off
  particle minecraft:wax_off ~ ~0.15 ~ 0.15 0.15 0.15 0 5


function ~/hit_end_point:
  data modify storage catenary:calc upgrade set value {}
  data modify storage catenary:calc upgrade.names set from entity @s data.upgrades
  execute if data storage catenary:calc upgrade.names[0] run function ~/loop:
    data modify storage catenary:calc upgrade.name set from storage catenary:calc upgrade.names[0]
    function ~/macro:
      $function catenary:upgrades/upgrade/$(name)/on_destroyed
    function ~/macro with storage catenary:calc upgrade
    data remove storage catenary:calc upgrade.names[0]
    execute if data storage catenary:calc upgrade.names[0] run function ~/

function ~/click_end_point:
  data modify storage catenary:calc rocket.entity_data set from entity @s {}
  pos = Eroxifloat("catenary.calc", "#internal.temp1").from_storage("catenary:calc", "rocket.entity_data.Pos[1]")
  offset = Eroxifloat("catenary.calc", "#internal.temp2").immediate(0.15)
  pos += offset
  pos.to_storage("catenary:calc", "rocket.entity_data.Pos[1]")
  execute on target run function catenary:rocket/get_storage
  execute unless data storage catenary:calc rocket.player_storage.loaded.selected_pos on target run return:
      data modify storage catenary:calc rocket.player_storage.loaded.selected_pos set from storage catenary:calc rocket.entity_data.Pos
      tag @s add catenary.rocket.has_selected_pos
      function catenary:rocket/has_selected_clock

  scoreboard players set #upgrade.link_found catenary.calc 0
  data modify storage catenary:calc internal.temp set value {}
  for i, axis in enumerate("xyz"):
    data modify storage catenary:calc f"internal.temp.{axis}" set from storage catenary:calc rocket.player_storage.loaded.selected_pos[i]
  function ~/goto_first_point with storage catenary:calc internal.temp
  function ~/goto_first_point:
    func_path = ~/../at_first_point
    raw f"$execute positioned 0.0 -0.15 0.0 positioned ~$(x) ~$(y) ~$(z) run function {func_path}"
  function ~/at_first_point:
    execute if entity @s[distance=..0.1] run return fail
    # score for when a link was found
    execute on vehicle on passengers if entity @s[type=item_display,tag=catenary.end_point]:
      execute if score #upgrade.link_found catenary.calc matches 1 run return fail
      scoreboard players operation #search catenary.id = @s catenary.id
      execute if entity @e[type=item_display,tag=catenary.end_point,distance=..0.1,predicate=catenary:match_id]:
        scoreboard players set #upgrade.link_found catenary.calc 1

  execute if score #upgrade.link_found catenary.calc matches 0 run return:
    execute on target run tellraw @s Translations.error("upgrade.no_pair_found", "There is no catenary connecting these points.")
    execute on target run function catenary:rocket/deselect

  data modify storage catenary:calc upgrade set value {}
  data modify storage catenary:calc upgrade.pos1 set from storage catenary:calc rocket.player_storage.loaded.selected_pos
  data modify storage catenary:calc upgrade.pos2 set from storage catenary:calc rocket.entity_data.Pos
  execute on target run data modify storage catenary:calc upgrade.item set from entity @s SelectedItem
  data modify storage catenary:calc upgrade.name set from storage catenary:calc upgrade.item.components."minecraft:custom_data".catenary.upgrade_name

  scoreboard players set #internal.temp catenary.calc 0
  function ~/check_if_already_has_upgrade:
    $execute if data entity @s data{upgrades:["$(name)"]} run scoreboard players set #internal.temp catenary.calc 1
  execute as @e[type=item_display,tag=catenary.end_point,predicate=catenary:match_id] run function ~/check_if_already_has_upgrade with storage catenary:calc upgrade
  execute if score #internal.temp catenary.calc matches 1 run return:
    execute on target run tellraw @s Translations.error("upgrade.already_applied", "This upgrade is already applied.")
    execute on target run function catenary:rocket/deselect
  
  function ~/on_both_points:
    execute unless data entity @s data.upgrades run data modify entity @s data.upgrades set value []
    $data modify entity @s data.upgrades append value "$(name)"
  execute as @e[type=item_display,tag=catenary.end_point,predicate=catenary:match_id] at @s run function ~/on_both_points with storage catenary:calc upgrade

  execute at @e[type=block_display,tag=catenary.display,predicate=catenary:match_id] run particle minecraft:happy_villager ~ ~ ~ 0.2 0.2 0.2 0 3
  execute at @e[type=item_display,tag=catenary.display,predicate=catenary:match_id] run particle minecraft:happy_villager ~ ~ ~ 0.2 0.2 0.2 0 3

  function ~/goto_first_point_2 with storage catenary:calc internal.temp
  function ~/goto_first_point_2:
    func_path = ~/../at_first_point_2
    raw f"$execute positioned 0.0 -0.15 0.0 positioned ~$(x) ~$(y) ~$(z) run function {func_path} with storage catenary:calc upgrade"
  function ~/at_first_point_2:
    $execute as @n[type=item_display,tag=catenary.end_point,distance=..0.1,predicate=catenary:match_id] run function catenary:upgrades/upgrade/$(name)/on_point_1
  
  for i, axis in enumerate("xyz"):
    data modify storage catenary:calc f"internal.temp.{axis}" set from storage catenary:calc upgrade.pos2[i]
  function ~/goto_second_point with storage catenary:calc internal.temp
  function ~/goto_second_point:
    func_path = ~/../at_second_point
    raw f"$execute positioned 0.0 -0.15 0.0 positioned ~$(x) ~$(y) ~$(z) run function {func_path} with storage catenary:calc upgrade"
  function ~/at_second_point:
    $execute as @n[type=item_display,tag=catenary.end_point,distance=..0.1,predicate=catenary:match_id] run function catenary:upgrades/upgrade/$(name)/on_point_2
  
  execute on target:
    execute if predicate catenary:survival_or_adventure run function eroxified2:item/api/decrement_mainhand
    function catenary:rocket/deselect
    playsound minecraft:block.anvil.use block @s


### INTERNAL ###
class UpgradeItem(CatenaryItem):
  abstract = True

  @transformer("custom_data", {})
  def add_upgrade_info(item, custom_data):
    if custom_data is None:
      custom_data = {}
    return custom_data | {"catenary":{"upgrade": True, "upgrade_name": item.upgrade_name}}
  
  @data_generator
  def generate_functions(item):
    if hasattr(item, "on_point_1"):
      function f"catenary:upgrades/upgrade/{item.upgrade_name}/on_point_1":
        item.on_point_1(item)
    if hasattr(item, "on_point_2"):
      function f"catenary:upgrades/upgrade/{item.upgrade_name}/on_point_2":
        item.on_point_2(item)
    if hasattr(item, "on_destroyed"):
      function f"catenary:upgrades/upgrade/{item.upgrade_name}/on_destroyed":
        item.on_destroyed(item)

class ZiplineLiftUpgrade(UpgradeItem):
  item_name = "Zipline Lift Upgrade"
  item_model = "minecraft:player_head"
  upgrade_name = "zipline_lift"
  profile = {"id":[1842885748,1158431565,-1909639344,-2042918757],"properties":[{"name":"textures","value":"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvZjhlZWNhZTQyMzM1OWQzZjVlZmQxMDYzYTlhN2JjZmFhNDM4MzlkNzVkM2IyMjNjODA4ZGY3OTYxZGQxNzNkMCJ9fX0="}]}
  lore = [
    {"text":"Makes a zipline go in only one direction","color":"gray"},
    {"text":"and at a fixed speed, even when going upward.","color":"gray"},
    {"text":"Use on two endpoints of an existing catenary.","color":"gray"}
  ]
  shaped_crafting_recipe = {
    "pattern": [["minecraft:chain", "minecraft:powered_rail", "minecraft:diamond"],
                ["minecraft:chain", "minecraft:powered_rail", "minecraft:repeater"],
                ["minecraft:chain", "minecraft:powered_rail", "minecraft:iron_block"]],
    "amount": 1
  }

  def on_point_1(item):
    data modify entity @s data.zipline_data.fixed_speed set value 0.3f
  
  def on_point_2(item):
    data remove entity @s data.zipline_data
  
  def on_destroyed(item):
    loot spawn ~ ~ ~ loot item.loot_table