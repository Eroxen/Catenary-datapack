from catenary:utils import Direction

terms = []

for x in range(-5, 6):
  terms.append({
      "condition": "minecraft:location_check",
      "offsetX": x,
      "offsetY": 0,
      "offsetZ": 0,
      "predicate": {
        "block": {
          "blocks": "minecraft:barrel",
          "nbt": "{components:{'minecraft:custom_data':{catenary:{placed_trigger:{}}}}}"
        }
      }
    })

predicate ~/row {
  "condition": "minecraft:any_of",
  "terms": terms
}

terms = []

for x in range(-5, 6):
  for z in range(-5, 6):
    terms.append({
        "condition": "minecraft:location_check",
        "offsetX": x,
        "offsetY": 0,
        "offsetZ": z,
        "predicate": {
          "block": {
            "blocks": "minecraft:barrel",
            "nbt": "{components:{'minecraft:custom_data':{catenary:{placed_trigger:{}}}}}"
          }
        }
      })

predicate ~/plane {
  "condition": "minecraft:any_of",
  "terms": terms
}

function ~/scan_cube:
  for y in range(-5, 6):
    execute positioned ~ ~y ~ if predicate ~/../plane run function ~/../scan_plane

function ~/scan_plane:
  for z in range(-5, 6):
    execute positioned ~ ~ ~z if predicate ~/../row run function ~/../scan_row with storage catenary:calc internal.placement.predicate

function ~/scan_row:
  for x in range(-5, 6):
    path = ~/../scan_block
    command = f"$execute positioned ~{x} ~ ~ " + 'if predicate {\
      "condition": "minecraft:location_check",\
      "predicate": {\
        "block": {\
          "blocks": "minecraft:barrel",\
          "nbt": $(nbt)\
        }\
      }\
    } run function $(function)'
    raw command

function ~/broken:
  execute as @e[type=item,distance=..2] if items entity @s contents minecraft:barrel[!minecraft:custom_data] run kill @s
  function ~/../broken_delegate
  kill @s