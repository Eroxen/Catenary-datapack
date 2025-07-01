from catenary:block import BarrelBlockItem
from nbtlib import IntArray, Float
from catenary:gui import Gui, InputSlot, OutputSlot, RangeToggleSlot, FillerSlotArrowLabel
from catenary:materials import CatenaryMaterials, MaterialConfig
from beet import ItemTag

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

class DecorationMaterialConfig(MaterialConfig):
    def __init__(self, items, provider):
        super().__init__(items)
        self.provider = provider

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
  sunflower = RopeMaterialConfig(["minecraft:sunflower"], {
                        "type": "block",
                        "axis": "y",
                        "block_state": {
                          "Properties": {
                            "half": "lower"
                          }
                        }
                      })

class DecorationMaterials(CatenaryMaterials):
  lanterns = DecorationMaterialConfig(["minecraft:lantern", "minecraft:soul_lantern"], {
                        "type": "block",
                        "offset_y": -0.75,
                        "light": 15,
                        "block_state": {
                          "Properties": {
                            "hanging": "false"
                          }
                        }
                      })
  spellings = DecorationMaterialConfig("#minecraft:signs", {
                        "type": "spelling"
                      })

def check_rope_material(slot):
  execute if items block ~ ~ ~ slot *[minecraft:custom_data] run return fail
  execute if items block ~ ~ ~ slot RopeMaterials.tag_location run return 1
  raw return fail

def check_decoration_material(slot):
  execute if items block ~ ~ ~ slot *[minecraft:custom_data] run return fail
  execute if items block ~ ~ ~ slot DecorationMaterials.tag_location run return 1
  raw return fail

spelling_typeface_materials = {
  "minecraft:oak_planks": "oak",
  "minecraft:spruce_planks": "spruce",
  "minecraft:birch_planks": "birch",
  "minecraft:jungle_planks": "jungle",
  "minecraft:mangrove_planks": "mangrove",
  "minecraft:cherry_planks": "cherry",
  "minecraft:jack_o_lantern": "pumpkin",
  "minecraft:stone": "stone"
}
ctx.data[f"catenary:material/spelling_typeface_materials"] = ItemTag({'values':list(spelling_typeface_materials.keys())})
def check_decoration_material_2(slot):
  execute if items block ~ ~ ~ slot *[minecraft:custom_data] run return fail
  execute if items block ~ ~ ~ slot DecorationMaterials.tag_location run return 1
  prev_slot = slot[:-2] + str(int(slot[-2:]) - 1)
  execute if items block ~ ~ ~ prev_slot #catenary:material/decoration_materials/spellings if items block ~ ~ ~ slot #catenary:material/spelling_typeface_materials run return 1
  raw return fail

class WorkbenchGui(Gui):
  slots = [
    RangeToggleSlot(0, "sag", values=["1", "1.01", "1.05", "1.1"],
      item_model="minecraft:string", default_state=2, lore=[
      "Controls how curvy the catenary is.",
      "Total rope length = distance between points * sag."
    ]),
    FillerSlotArrowLabel(1, "Rope Material", lore=[
      "Material used for the rope of the catenary. (required)"
    ]),
    InputSlot(2, "rope_1", check_func=check_rope_material),
    RangeToggleSlot(18, "decoration_distance", values=["Default", 0.5, 0.75, 1.0, 1.25, 1.5, 1.75, 2.0, 2.25, 2.5, 2.75, 3.0],
      item_model="minecraft:repeater", default_state=0, lore=[
      "Distance between decorations in blocks.",
      "\"Default\" reuses calculations & is less laggy."
    ]),
    FillerSlotArrowLabel(19, "Decorations", lore=[
      "Decorations hanging below the rope. (optional)"
    ]),
    InputSlot(20, "decoration_1", check_func=check_decoration_material),
    InputSlot(21, "decoration_2", check_func=check_decoration_material_2),
    OutputSlot(17)
  ]
  pass

  def on_input_changed(named_slots):
    data remove storage catenary:calc gui.data.output
    execute unless data storage catenary:calc gui.data.inputs.rope_1 run return fail

    execute if data storage catenary:calc gui.data.inputs.decoration_2 unless data storage catenary:calc gui.data.inputs.decoration_1 run return fail

    data modify storage catenary:calc internal.temp set value {}
    data modify storage catenary:calc internal.temp.sag set from storage catenary:calc gui.data.toggles.sag.value
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
    data modify storage catenary:calc internal.temp.main_ingredient set string storage catenary:calc gui.data.inputs.rope_1.id 10
    data modify storage catenary:calc gui.data.output.components."minecraft:item_model" set from storage catenary:calc gui.data.inputs.rope_1.id
    execute if data storage catenary:calc gui.data.inputs.decoration_1 run data modify storage catenary:calc gui.data.output.components."minecraft:item_model" set from storage catenary:calc gui.data.inputs.decoration_1.id

    ### rope material ###
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

    ### sag ###
    data modify storage catenary:calc internal.settings.sag set from storage catenary:calc internal.temp.sag
    execute if data storage catenary:calc internal.temp{sag:"1"} run data modify storage catenary:calc gui.data.output.components."minecraft:item_name" merge value {"translate":"item.catenary.rocket.straight","fallback":"Catenary (Straight %s)"}

    function ~/macro with storage catenary:calc internal.temp
    function ~/macro:
      $data modify storage catenary:calc gui.data.output.components."minecraft:item_name".with append value {"translate":"item.minecraft.$(main_ingredient)","fallback":"%s","with":[{"translate":"block.minecraft.$(main_ingredient)"}]}
      $data modify storage catenary:calc gui.data.output.components."minecraft:lore" append value {"translate":"","fallback":"  Sag: %s","with":[$(sag)],"italic":false,"color":"gray"}
      $data modify storage catenary:calc gui.data.output.components."minecraft:lore" append value {"translate":"","fallback":"  Block: %s","with":[{"translate":"block.minecraft.$(main_rope_block)"}],"italic":false,"color":"light_purple"}

    ### decorations ###
    scoreboard players set #catenary.valid_material_combo catenary.calc 1
    execute if data storage catenary:calc gui.data.inputs.decoration_1:
      data modify storage catenary:calc internal.settings.decorations set value {
            type: "single",
            provider: {
            }
      }
      for material in DecorationMaterials.materials:
        execute if items block ~ ~ ~ f"container.{named_slots['decoration_1'].slot}" material.tag_location:
          if material.provider['type'] == "block":
            data modify storage catenary:calc internal.settings.decorations.provider set value material.provider
            data modify storage catenary:calc internal.settings.decorations.provider.block_state.Name set from storage catenary:calc gui.data.inputs.decoration_1.id
          elif material.provider['type'] == "spelling":
            data modify storage catenary:calc internal.settings.decorations set value {type:"spelling", typeface:"oak"}
            for WOODTYPE in ["oak", "spruce", "birch", "jungle", "mangrove", "cherry"]:
              execute if items block ~ ~ ~ f"container.{named_slots['decoration_1'].slot}" f"minecraft:{WOODTYPE}_sign" run data modify storage catenary:calc internal.settings.decorations.typeface set value WOODTYPE
            function ~/set_spelling_material:
              for k, v in spelling_typeface_materials.items():
                execute if items block ~ ~ ~ f"container.{named_slots['decoration_2'].slot}" k run return run data modify storage catenary:calc internal.settings.decorations.typeface set value v
              return fail
            execute if items block ~ ~ ~ f"container.{named_slots['decoration_2'].slot}" * unless function ~/set_spelling_material run scoreboard players set #catenary.valid_material_combo catenary.calc 0
      execute if score #catenary.valid_material_combo catenary.calc matches 0 run return fail

      execute unless data storage catenary:calc gui.data.toggles.decoration_distance{value:"Default"} unless data storage catenary:calc internal.settings.decorations{type:"spelling"}:
        data modify storage catenary:calc internal.settings.decorations.distance set from storage catenary:calc gui.data.toggles.decoration_distance.value
        data modify storage catenary:calc internal.temp.decoration_distance set from storage catenary:calc gui.data.toggles.decoration_distance.value

      data modify storage catenary:calc internal.temp.decoration_block_1 set string storage catenary:calc internal.settings.decorations.provider.block_state.Name 10

      data modify storage catenary:calc gui.data.output.components."minecraft:lore" append value ""
      data modify storage catenary:calc gui.data.output.components."minecraft:lore" append value {"text": "Decorations:", "italic": false, "color": "gray"}
      execute if data storage catenary:calc internal.settings.decorations{type:"spelling"}:
        data modify storage catenary:calc gui.data.output.components."minecraft:lore" append value {"text":"  Spelling ","italic":false,"color":"light_purple","extra":[{"text":"(Rename in Anvil!)","color":"gold"}]}
        function ~/macro_4 with storage catenary:calc internal.settings.decorations
        function ~/macro_4:
          $data modify storage catenary:calc gui.data.output.components."minecraft:lore" append value {"text":"  Font: ","italic":false,"color":"light_purple","extra":[{"text":"$(typeface)"}]}
      execute if data storage catenary:calc internal.temp.decoration_block_1 run function ~/macro_2 with storage catenary:calc internal.temp
      function ~/macro_2:
        $data modify storage catenary:calc gui.data.output.components."minecraft:lore" append value {"translate":"","fallback":"  Block: %s","with":[{"translate":"block.minecraft.$(decoration_block_1)"}],"italic":false,"color":"light_purple"}
      execute if data storage catenary:calc internal.temp.decoration_distance run function ~/macro_3 with storage catenary:calc internal.temp
      function ~/macro_3:
        $data modify storage catenary:calc gui.data.output.components."minecraft:lore" append value {"translate":"","fallback":"  Distance: %s","with":["$(decoration_distance)"],"italic":false,"color":"light_purple"}
    
    execute if score #catenary.valid_material_combo catenary.calc matches 0 run return run data remove storage catenary:calc gui.data.output
    data modify storage catenary:calc gui.data.output.components."minecraft:lore" append value {"text":"","color":"#25025C","extra":[{"text":"⛓","shadow_color":[0.4,0,0,1]},{"text":"Catenary"}]}

    

        


    data modify storage catenary:calc gui.data.output.components."minecraft:custom_data".catenary.settings set from storage catenary:calc internal.settings
  
  def on_closed():
    stopsound @s * minecraft:block.barrel.close
  
  def on_successful_craft():
    playsound minecraft:block.wool.hit block @s
    scoreboard players add @s catenary.stats.catenaries_crafted 1


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