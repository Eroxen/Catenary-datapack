from catenary:block import BarrelStonePressurePlateBlockItem
from nbtlib import IntArray
import numpy as np

class ZiplineMountPad(BarrelStonePressurePlateBlockItem):
  item_name = "Zipline Mount Pad"
  item_model = "minecraft:player_head"
  profile = {"id":[-1526820294,-186301761,-1780042148,-1074352176],"properties":[{"name":"textures","value":"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvOTkzN2E1YmM1ZGQzMzQ1M2EwNDJkNzFlMTcyMmE4OTgwODRjYzhmYTNkZmU4NTJlOWE5MWU5YzY1OTRiMTRlIn19fQ=="}]}
  recipe = {
    "pattern": [["_", "minecraft:chain", "_"],
                ["minecraft:chain", "minecraft:stone_pressure_plate", "minecraft:chain"],
                ["_", "minecraft:diamond", "_"]],
    "amount": 1
  }

  def on_placed(item):
    setblock ~ ~ ~ stone_pressure_plate
    summon marker ~ ~ ~ {Tags:["catenary.entity","catenary.custom_block","catenary.custom_block.component.detect_breaking","catenary.custom_block.component.detect_state_change","catenary.custom_block.component.detect_state_change.stone_pressure_plate","catenary.custom_block.component.detect_breaking.stone_pressure_plate",f"catenary.custom_block.id.{item.id}"]}
    skin = {"id":IntArray([-1526820294,-186301761,-1780042148,-1074352176]),"properties":[{"name":"textures","value":"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvOTkzN2E1YmM1ZGQzMzQ1M2EwNDJkNzFlMTcyMmE4OTgwODRjYzhmYTNkZmU4NTJlOWE5MWU5YzY1OTRiMTRlIn19fQ=="}]}
    execute align y run summon item_display ~ ~ ~ {Tags:["catenary.entity",f"catenary.custom_block.id.{item.id}.skin"],item:{id:"minecraft:player_head",components:{"minecraft:profile":skin}},transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0.07f,0f],scale:[1f,0.125f,1f]}}
  
  def on_pressed_down(item):
    execute positioned ~ ~2 ~ unless entity @e[type=item_display,tag=catenary.end_point,distance=..3,limit=1] run return fail
    execute positioned ~ ~2 ~ as @n[type=item_display,tag=catenary.end_point,distance=..3] unless data entity @s data.zipline_data run return fail

    execute align xyz as @e[type=#catenary:can_ride_zipline,dy=0] if function catenary:zipline/may_ride_zipline run tag @s add catenary.zipline.may_board
    execute align xyz unless entity @e[type=#catenary:can_ride_zipline,tag=catenary.zipline.may_board,dy=0,limit=1] run return fail

    execute align xyz as @e[type=#catenary:can_ride_zipline,tag=catenary.zipline.may_board,dy=0,limit=1,sort=random] run function catenary:zipline/init_boarder
    execute positioned ~ ~2 ~ as @n[type=item_display,tag=catenary.end_point,distance=..3] at @s positioned ~ ~0.15 ~ run function catenary:zipline/spawn_and_board
    tag @e[tag=catenary.zipline.may_board] remove catenary.zipline.may_board
    tag @e[tag=catenary.zipline.boarder] remove catenary.zipline.boarder

    execute align y:
      def particle_ring(radius, points, speed):
        for i in range(points):
          angle = i * 2 * np.pi / points
          x = radius * np.sin(angle)
          z = radius * np.cos(angle)
          particle minecraft:end_rod ~x ~ ~z 0 1 0 speed 0
      particle_ring(0.5, 16, 0.1)
      particle_ring(0.25, 12, 0.2)


  
  def on_broken(item):
    execute align y run kill @e[type=item_display,tag=f"catenary.custom_block.id.{item.id}.skin",distance=..0.1]
    loot spawn ~ ~ ~ loot item.loot_table