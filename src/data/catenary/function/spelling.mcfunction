function ~/preprocess:
  data modify storage catenary:calc internal.spelling set value {"string":"Catenary"}
  data modify storage catenary:calc internal.spelling.string set from storage catenary:calc rocket.item.components."minecraft:custom_name"
  execute if data storage catenary:calc internal.spelling.string.text run data modify storage catenary:calc internal.spelling.string set from storage catenary:calc internal.spelling.string.text
  execute store result score #catenary.fixed_n_segments catenary.calc run data get storage catenary:calc internal.spelling.string
  scoreboard players add #catenary.fixed_n_segments catenary.calc 1

  function catenary:catenary/summon/sample_points

function ~/init_provider:
  function ~/get_typeface with storage catenary:calc catenary.summon.provider.settings
  function ~/get_typeface:
    $data modify storage catenary:calc internal.spelling.typeface set from storage catenary:calc lookup.typefaces.$(typeface)

  data modify storage catenary:calc internal.temp set value {
    type: "item",
    item: {
      id: "minecraft:player_head"
    },
    transformation: {
      left_rotation: [0f,0.707f,0f,0.707f],
      scale: [1.05f,1.05f,1.05f]
    }
  }
  function ~/../next_provider

function ~/next_provider:
  data modify storage catenary:calc internal.spelling.char set string storage catenary:calc internal.spelling.string 0 1
  data modify storage catenary:calc internal.spelling.string set string storage catenary:calc internal.spelling.string 1
  execute if data storage catenary:calc internal.spelling{char:' '} run data modify storage catenary:calc internal.temp.type set value "none"
  execute unless data storage catenary:calc internal.spelling{char:' '}:
    data modify storage catenary:calc internal.temp.type set value "item"
    data modify storage catenary:calc internal.temp.item.components."minecraft:profile" set from storage catenary:calc internal.spelling.typeface.' '
    for letter in list("ABCDEFGHIJKLMNOPQRSTUVWXYZ"):
      execute if data storage catenary:calc internal.spelling{char:f"{letter}"} run data modify storage catenary:calc internal.spelling.char set value f"{letter.lower()}"
    execute if data storage catenary:calc internal.spelling{char:'"'} run data modify storage catenary:calc internal.temp.item.components."minecraft:profile" set from storage catenary:calc internal.spelling.typeface.'"'
    execute if data storage catenary:calc internal.spelling{char:'\\'} run data modify storage catenary:calc internal.temp.item.components."minecraft:profile" set from storage catenary:calc internal.spelling.typeface.'\\'
    execute unless data storage catenary:calc internal.spelling{char:'"'} unless data storage catenary:calc internal.spelling{char:'\\'} run function ~/macro with storage catenary:calc internal.spelling
    function ~/macro:
      $data modify storage catenary:calc internal.temp.item.components."minecraft:profile" set from storage catenary:calc internal.spelling.typeface."$(char)"
  function catenary:catenary/display_provider/entry_to_entity_decorations