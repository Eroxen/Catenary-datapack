function ~/give_item_from_storage:
  function ~/macro_comp:
    $loot give @s loot {"pools":[{"rolls":1,"entries":[{"type":"minecraft:item","name":"$(id)","functions":[{"function":"minecraft:set_components","components":$(components)},{"function":"minecraft:set_count","count":$(count)}]}]}]}
  function ~/macro_no_comp:
    $loot give @s loot {"pools":[{"rolls":1,"entries":[{"type":"minecraft:item","name":"$(id)","functions":[{"function":"minecraft:set_count","count":$(count)}]}]}]}
  execute if data storage catenary:calc gui.give_item.components run return run function ~/macro_comp with storage catenary:calc gui.give_item
  function ~/macro_no_comp with storage catenary:calc gui.give_item

function ~/give_item_from_slot:
  function ~/macro_comp:
    $loot give @s loot {"pools":[{"rolls":1,"entries":[{"type":"minecraft:item","name":"$(id)","functions":[{"function":"minecraft:set_components","components":$(components)},{"function":"minecraft:set_count","count":$(count)}]}]}]}
  function ~/macro_no_comp:
    $loot give @s loot {"pools":[{"rolls":1,"entries":[{"type":"minecraft:item","name":"$(id)","functions":[{"function":"minecraft:set_count","count":$(count)}]}]}]}
  command = '$execute if data block ~ ~ ~ Items[{Slot:$(Slot)b}].components run return run function ' + ~/macro_comp + ' with block ~ ~ ~ Items[{Slot:$(Slot)b}]'
  raw command
  command = '$function ' + ~/macro_no_comp + ' with block ~ ~ ~ Items[{Slot:$(Slot)b}]'
  raw command

function ~/tick_clock:
  execute as @e[type=marker,tag=catenary.custom_block.component.gui.ticking] at @s run function ~/../tick
  execute if entity @e[type=marker,tag=catenary.custom_block.component.gui.ticking,limit=1] run schedule function ~/ 1t replace

function ~/tick:
  execute unless block ~ ~ ~ barrel[open=true] run return run function ~/../close
  function ~/../protect

function ~/open:
  function ~/../protect

function ~/protect:
  execute if block ~ ~-1 ~ hopper run data modify block ~ ~-1 ~ TransferCooldown set value 8
  execute positioned ~ ~-1 ~ align xyz as @e[type=hopper_minecart,dx=0]:
    kill @s
    loot spawn ~ ~ ~ loot {"pools":[{"rolls":1,"entries":[{"type":"minecraft:item","name":"minecraft:hopper_minecart"}]}]}