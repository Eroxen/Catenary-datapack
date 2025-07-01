from catenary:utils import snake_case_to_words, measure_text_width, text_padding, register_scoreboard_objective
from collections import defaultdict
STATS = ["catenaries_crafted", "catenaries_placed", "catenaries_broken", "distance_by_zipline"]
def default_1():
  return 1
STATS_SCALE = defaultdict(default_1, {
  "distance_by_zipline": 0.001
})

### API ###
function ~/load:
  for stat in STATS:
    scoreboard objectives add register_scoreboard_objective(f"catenary.stats.{stat}") dummy

function ~/show_dialog:
  data modify storage catenary:calc internal.temp set value {body:[]}
  data modify storage eroxified2:api format.input set value {value:0,width:10}
  scoreboard players set #internal.temp catenary.calc 0
  for stat in STATS:
    execute store result storage eroxified2:api format.input.value int STATS_SCALE[stat] run scoreboard players get @s f"catenary.stats.{stat}"
    function eroxified2:format/api/int_space_pad_front
    padding = text_padding(150 - measure_text_width(snake_case_to_words(stat)))
    data modify storage catenary:calc internal.temp.body append value {type:"minecraft:plain_message",width:300,contents:{text:snake_case_to_words(stat),extra:[padding]}}
    data modify storage catenary:calc internal.temp.body[-1].contents.extra append from storage eroxified2:api format.output
    execute if score #internal.temp catenary.calc matches 1 run data modify storage catenary:calc internal.temp.body[-1].contents.color set value "gray"
    execute store success score #internal.temp catenary.calc if score #internal.temp catenary.calc matches 0

  function ~/show with storage catenary:calc internal.temp
  function ~/show:
    $dialog show @s {type:"minecraft:notice",title:{translate:"gui.stats"},body:$(body),action:{label:{translate:"gui.done"}}}

### INTERNAL ###