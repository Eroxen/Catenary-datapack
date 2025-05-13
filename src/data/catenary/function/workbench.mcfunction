from catenary:block import BarrelBlockItem
from nbtlib import IntArray, Float
from catenary:gui import Gui, InputSlot, OutputSlot, RangeToggleSlot
from catenary:materials import CatenaryMaterials, MaterialConfig

colors = ["white", "light_gray", "gray", "black", "brown", "red", "orange", "yellow", "lime", "green", "cyan", "light_blue", "blue", "purple", "magenta", "pink"]
colored_glass_panes = []
for color in colors:
  colored_glass_panes.append(f"minecraft:{color}_stained_glass_pane")
woods = ["oak", "spruce", "birch", "jungle", "acacia", "dark_oak", "mangrove", "cherry", "pale_oak", "bamboo", "crimson", "warped"]


class RopeMaterialConfig(MaterialConfig):
    def __init__(self, items, provider, mapping=None):
        super().__init__(items)
        self.provider = provider
        self.mapping = mapping

class RopeMaterials(CatenaryMaterials):
  fence_gates = RopeMaterialConfig("#minecraft:fence_gates", {
                        "type": "block",
                        "axis": "x",
                        "block_state": {
                          "Properties": {
                            "in_wall": "true"
                          }
                        }
                      })
  columns = RopeMaterialConfig([
                        "minecraft:chain", "minecraft:end_rod", "minecraft:glass_pane"
                      ] + colored_glass_panes + [
                        "minecraft:lightning_rod", "minecraft:cactus", "#minecraft:fences", "#minecraft:walls", "minecraft:iron_bars", "minecraft:bamboo", "minecraft:sugar_cane"
                      ], {
                        "type": "block",
                        "axis": "y"
                      })
  vines = RopeMaterialConfig(["minecraft:glow_berries", "minecraft:weeping_vines", "minecraft:twisting_vines"], {
                        "type": "block",
                        "axis": "y",
                        "block_state": {
                          "Properties": {
                            "in_wall": "true"
                          }
                        }
                      }, mapping={
                        "minecraft:glow_berries": "minecraft:cave_vines_plant",
                        "minecraft:weeping_vines": "minecraft:weeping_vines_plant",
                        "minecraft:twisting_vines": "minecraft:twisting_vines_plant"
                      })
      

def check_rope_material(slot):
  execute if items block ~ ~ ~ slot *[minecraft:custom_data] run return fail
  execute if items block ~ ~ ~ slot RopeMaterials.tag_location run return 1
  raw return fail

class WorkbenchGui(Gui):
  slots = [
    InputSlot(2, "rope_1", check_func=check_rope_material),
    RangeToggleSlot(0, "sag", values=["1", "1.01", "1.05", "1.1"], item_model="minecraft:string", default_state=2),
    OutputSlot(17)
  ]
  pass

  def on_input_changed(named_slots):
    data remove storage catenary:calc gui.data.output
    execute unless data storage catenary:calc gui.data.inputs.rope_1 run return fail

    data modify storage catenary:calc internal.temp set value {}
    data modify storage catenary:calc internal.temp.sag set from storage catenary:calc gui.data.toggles.sag.value
    data modify storage catenary:calc internal.temp.main_ingredient set string storage catenary:calc gui.data.inputs.rope_1.id 10

    data modify storage catenary:calc gui.data.output set value {count:1,id:"minecraft:firework_rocket",components:{
      "minecraft:fireworks":{},
      "minecraft:enchantment_glint_override":true,
      "minecraft:item_name":{"translate":"item.catenary.rocket","fallback":"Catenary (%s)","with":[]},
      "minecraft:custom_data": {
        "catenary": {"detect":true,"settings":{}}
      },
      "minecraft:lore": [
        {"text": "Rope:", "italic": false, "color": "gray"}
      ]
    }}
    data modify storage catenary:calc internal.settings set value {}
    data modify storage catenary:calc internal.settings.rope set value {
          type: "single",
          provider: {
          }
        }

    for material in RopeMaterials.materials:
      execute if items block ~ ~ ~ f"container.{named_slots['rope_1'].slot}" material.tag_location:
        data modify storage catenary:calc internal.settings.rope.provider set value material.provider
        data modify storage catenary:calc internal.settings.rope.provider.block_state.Name set from storage catenary:calc gui.data.inputs.rope_1.id
        if material.mapping is not None:
          for k, v in material.mapping.items():
            execute if data storage catenary:calc internal.settings.rope.provider.block_state{Name:k} run data modify storage catenary:calc internal.settings.rope.provider.block_state.Name set value v

    data modify storage catenary:calc internal.temp.main_rope_block set string storage catenary:calc internal.settings.rope.provider.block_state.Name 10

    data modify storage catenary:calc internal.settings.sag set from storage catenary:calc internal.temp.sag
    execute if data storage catenary:calc internal.temp{sag:"1"} run data modify storage catenary:calc gui.data.output.components."minecraft:item_name" merge value {"translate":"item.catenary.rocket.straight","fallback":"Catenary (Straight %s)"}

    data modify storage catenary:calc gui.data.output.components."minecraft:item_model" set from storage catenary:calc gui.data.inputs.rope_1.id

    function ~/macro with storage catenary:calc internal.temp
    function ~/macro:
      $data modify storage catenary:calc gui.data.output.components."minecraft:item_name".with append value {"translate":"item.minecraft.$(main_ingredient)","fallback":"%s","with":[{"translate":"block.minecraft.$(main_ingredient)"}]}
      $data modify storage catenary:calc gui.data.output.components."minecraft:lore" append value {"translate":"","fallback":"  Length: %s","with":[$(sag)],"italic":false,"color":"gray"}
      $data modify storage catenary:calc gui.data.output.components."minecraft:lore" append value {"translate":"","fallback":"  Block: %s","with":[{"translate":"block.minecraft.$(main_rope_block)"}],"italic":false,"color":"light_purple"}

    data modify storage catenary:calc gui.data.output.components."minecraft:custom_data".catenary.settings set from storage catenary:calc internal.settings
  
  def on_closed():
    stopsound @s * minecraft:block.barrel.close


skins = [
  {"id":IntArray([-350824714,1079723201,-1333772721,852886936]),"properties":[{"name":"textures","value":"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvOGY5Yzk5NDlhNzY3ODk2ODkyZDQwNGE0OWNjNmYyODYzYzdlOGUwMDNjNmU5NWMyNWZiYzUzNDIxYjljMzEyNyJ9fX0="}]},
  {"id":IntArray([-2097777940,-189249239,-1277006748,1717810966]),"properties":[{"name":"textures","value":"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvOTNmNWU5ZTUyYTkwMTg1ZWRjNTdiZTUwYWYxYjUyYzdiZjY3OTk2YWU4NjMzNTJjZGM3MWQ0MTE2Y2ZiMWI5MiJ9fX0="}]},
  {"id":IntArray([-869705366,-1342158067,-1554732859,-1137778893]),"properties":[{"name":"textures","value":"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvMWFiYTExOGJlZTY2NDU0OTQ3MThiNWY4NjNhMWEwMTgzZDA2ODhmZDg4NTJkMjFiYTNmNWMxM2RiYjNiODBjMiJ9fX0="}]},
  {"id":IntArray([1421328944,-890551487,-1101023879,730933353]),"properties":[{"name":"textures","value":"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvYmI3NjI5MTNhMzkzNGVkNjc1YWU3Yjc5ODViZjc5NWI4YWJlZWE2MDc4OWRjYWQxMWM2MmI2NDQ0N2UyNjkwYyJ9fX0="}]}
]

class Workbench(BarrelBlockItem):
  item_name = "Catenaring Table"
  item_model = "minecraft:player_head"
  profile = {"id":[-869705366,-1342158067,-1554732859,-1137778893],"properties":[{"name":"textures","value":"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvMWFiYTExOGJlZTY2NDU0OTQ3MThiNWY4NjNhMWEwMTgzZDA2ODhmZDg4NTJkMjFiYTNmNWMxM2RiYjNiODBjMiJ9fX0="}]}
  recipe = {
    "pattern": [["minecraft:chain", "minecraft:chain"],
                ["#minecraft:planks", "#minecraft:planks"]],
    "amount": 1
  }

  def on_placed(item):
    data modify block ~ ~ ~ CustomName set value item.components['minecraft:item_name']

    offset = 0.0015
    DSP_SCL = Float(1.008)
    DSP_RI = Float(0.25 + offset)
    DSP_LE = Float(-0.25 - offset)
    DSP_UP = Float(offset)
    DSP_DW = Float(-0.5 - offset)

    summon marker ~ ~ ~ {Tags:["catenary.entity","catenary.custom_block","catenary.custom_block.component.detect_breaking","catenary.custom_block.component.gui","catenary.custom_block.component.detect_breaking.barrel",f"catenary.custom_block.id.{item.id}"]}
    execute positioned ~ ~1 ~ align y run summon item_display ~ ~ ~ {Tags:["catenary.entity",f"catenary.custom_block.id.{item.id}.skin"],item:{id:"minecraft:player_head",components:{"minecraft:profile":skins[0]}},transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[DSP_RI,DSP_UP,DSP_RI],scale:[DSP_SCL,DSP_SCL,DSP_SCL]},Passengers:[
      {id:"minecraft:item_display",Tags:["catenary.entity"],item:{id:"minecraft:player_head",components:{"minecraft:profile":skins[1]}},transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[DSP_LE,DSP_UP,DSP_RI],scale:[DSP_SCL,DSP_SCL,DSP_SCL]}},
      {id:"minecraft:item_display",Tags:["catenary.entity"],item:{id:"minecraft:player_head",components:{"minecraft:profile":skins[2]}},transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[DSP_RI,DSP_UP,DSP_LE],scale:[DSP_SCL,DSP_SCL,DSP_SCL]}},
      {id:"minecraft:item_display",Tags:["catenary.entity"],item:{id:"minecraft:player_head",components:{"minecraft:profile":skins[3]}},transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[DSP_LE,DSP_UP,DSP_LE],scale:[DSP_SCL,DSP_SCL,DSP_SCL]}},
      {id:"minecraft:item_display",Tags:["catenary.entity"],item:{id:"minecraft:player_head",components:{"minecraft:profile":skins[3]}},transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[DSP_RI,DSP_DW,DSP_RI],scale:[DSP_SCL,DSP_SCL,DSP_SCL]}},
      {id:"minecraft:item_display",Tags:["catenary.entity"],item:{id:"minecraft:player_head",components:{"minecraft:profile":skins[2]}},transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[DSP_LE,DSP_DW,DSP_RI],scale:[DSP_SCL,DSP_SCL,DSP_SCL]}},
      {id:"minecraft:item_display",Tags:["catenary.entity"],item:{id:"minecraft:player_head",components:{"minecraft:profile":skins[1]}},transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[DSP_RI,DSP_DW,DSP_LE],scale:[DSP_SCL,DSP_SCL,DSP_SCL]}},
      {id:"minecraft:item_display",Tags:["catenary.entity"],item:{id:"minecraft:player_head",components:{"minecraft:profile":skins[0]}},transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[DSP_LE,DSP_DW,DSP_LE],scale:[DSP_SCL,DSP_SCL,DSP_SCL]}}
    ]}
    raw return 1

  def on_broken(item):
    execute positioned ~ ~1 ~ align y as @e[type=item_display,tag=f"catenary.custom_block.id.{item.id}.skin",distance=..0.1] run function eroxified2:entity/api/kill_stack
    loot spawn ~ ~ ~ loot item.loot_table
  
  def on_use(item):
    execute if data block ~ ~ ~ lock run return fail
    playsound minecraft:block.smithing_table.use block @s ~ ~ ~ 1 1
    WorkbenchGui.open()