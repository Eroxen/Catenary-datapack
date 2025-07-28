from eroxified2:custom_item import transformer
from catenary:item import CatenaryItem
from catenary:utils import snake_case_to_words

class DecorationItem(CatenaryItem):
  abstract = True

  lore = [
    {"text":"For use in the Catenaring Table.","color":"gray"},
    {"text":"Can be used as a decoration material.","color":"gray"}
  ]

  @transformer('item_name', '')
  def item_name_transformer(item, item_name):
    item_name = snake_case_to_words(item.id)
    return {"text":"Decoration - ","extra":[item_name]}
  
  @transformer('lore', [])
  def add_description(item, lore):
    lore.append({"text":"Decorations:","color":"gray","italic":False})
    if item.decoration["type"] == "block":
      block_name = item.decoration['block_state']['Name'].split(':')[1]
      lore.append({"text":"  Block: ","color":"light_purple","italic":False,"extra":[{"translate":f"block.minecraft.{block_name}"}]})
    if item.decoration["type"] == "item":
      item_name = item.decoration['item']['id'].split(':')[1]
      lore.append({"text":"  Item: ","color":"light_purple","italic":False,"extra":[{"translate":f"item.minecraft.{item_name}","fallback":"%s","with":[{"translate":f"block.minecraft.{item_name}"}]}]})
    return lore
  
  @transformer('custom_data', {})
  def set_material(item, custom_data):
    return custom_data | {"catenary":{"decoration_material":item.decoration}}

class PaperLanterns(DecorationItem):
  item_model = "minecraft:player_head"
  profile = {"id":[-307565869,-899857461,-1955140466,-1970268593],"properties":[{"name":"textures","value":"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvMjYyODNlN2E4OGQzMjcxOTMwNGEzN2VkZTBjNmE4YzVkYzlkOWNmOWIwMGExNzljZjkwNGU4Y2U4MjEzMTIifX19"}]}
  decoration = {
    "type": "item",
    "light": 7,
    "item": {
      "id": "minecraft:player_head",
      "components": {
        "minecraft:profile": {"id":[-307565869,-899857461,-1955140466,-1970268593],"properties":[{"name":"textures","value":"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvMjYyODNlN2E4OGQzMjcxOTMwNGEzN2VkZTBjNmE4YzVkYzlkOWNmOWIwMGExNzljZjkwNGU4Y2U4MjEzMTIifX19"}]}
      }
    },
    "offset_y": -0.5,
    "transformation": {
      "scale": [1.5, 2.0, 1.5],
      "translation": [0.0, 0.5, 0.0]
    },
    "brightness": {"sky": 15, "block": 15}
  }
  shaped_crafting_recipe = {
    "pattern": [["_", "minecraft:string", "_"],
                ["minecraft:paper", "minecraft:red_dye", "minecraft:paper"],
                ["_", "minecraft:torch", "_"]],
    "amount": 1
  }