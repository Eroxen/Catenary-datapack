# Slider: from 0.157f to 0.391f


$summon item_display $(offset) {Tags:["catenary.studio","catenary.studio.gui","catenary.studio.gui.root","catenary.studio.gui.root.new"],Passengers:\
 [\
  {id:"minecraft:item_display",Tags:["catenary.studio","catenary.studio.gui","catenary.studio.gui.background"],Passengers:\
   [\
    {id:"minecraft:text_display",Tags:["catenary.studio.gui.background.rope_slot"],"text":'{"text":"□","color":"yellow"}',background:0b,transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[-0.34f,-0.011f,0f],scale:[2f,2f,1f]},Rotation:$(rotation)},\
    {id:"minecraft:text_display",Tags:["catenary.studio.gui.background.decoration_slot"],"text":'{"text":"□□","color":"aqua"}',background:0b,transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[-0.19f,-0.3235f,0f],scale:[2f,2f,1f]},Rotation:$(rotation)},\
    {id:"minecraft:text_display",Tags:["catenary.studio.gui.background.rope_length_slider"],"text":'{"text":"_","color":"gold"}',background:0b,transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0.25f,0.0625f,0f],scale:[2.5f,5f,1f]},Rotation:$(rotation)},\
    {id:"minecraft:text_display",Tags:["catenary.studio.gui.background.rope_segment_length_slider"],"text":'{"text":"_","color":"gold"}',background:0b,transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0.25f,-0.0625f,0f],scale:[2.5f,5f,1f]},Rotation:$(rotation)},\
    {id:"minecraft:text_display",Tags:["catenary.studio.gui.background.decoration_spacing_slider"],"text":'{"text":"_","color":"dark_aqua"}',background:0b,transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0.25f,-0.25f,0f],scale:[2.5f,5f,1f]},Rotation:$(rotation)},\
    {id:"minecraft:text_display",Tags:["catenary.studio.gui.background.decoration_light"],"text":'{"text":"_","color":"aqua"}',background:0b,transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0.175f,-0.375f,0f],scale:[1f,5f,1f]},Rotation:$(rotation)}\
   ]\
  },\
  {id:"minecraft:item_display",Tags:["catenary.studio","catenary.studio.gui","catenary.studio.gui.button"],Passengers:\
   [\
    {id:"minecraft:text_display",Tags:["catenary.studio.gui.button.rope_length_slider"],"text":'{"text":"_","color":"yellow"}',background:0b,transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0.157f,0.0625f,0.01f],scale:[0.625f,5f,1f]},Rotation:$(rotation)},\
    {id:"minecraft:text_display",Tags:["catenary.studio.gui.button.rope_segment_length_slider"],"text":'{"text":"_","color":"yellow"}',background:0b,transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0.274f,-0.0625f,0.01f],scale:[0.625f,5f,1f]},Rotation:$(rotation)},\
    {id:"minecraft:text_display",Tags:["catenary.studio.gui.button.decoration_spacing_slider"],"text":'{"text":"_","color":"aqua"}',background:0b,transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0.274f,-0.25f,0.01f],scale:[0.625f,5f,1f]},Rotation:$(rotation)},\
    {id:"minecraft:item_display",Tags:["catenary.studio.gui.button.decoration_light"],item:{Count:1b,id:"minecraft:light",tag:{BlockStateTag:{level:0}}},item_display:"gui",transformation:{left_rotation:[0f,1f,0f,0f],right_rotation:[0f,0f,0f,1f],translation:[0.1915f,-0.0665f,0.01f],scale:[0.125f,0.125f,0.01f]},Rotation:$(rotation)}\
   ]\
  },\
  {id:"minecraft:item_display",Tags:["catenary.studio","catenary.studio.gui","catenary.studio.gui.items"],Passengers:\
   [\
    {id:"minecraft:item_display",Tags:["catenary.studio.gui.item.rope"],item:{Count:1b,id:"minecraft:chain"},item_display:"gui",transformation:{left_rotation:[0f,1f,0f,0f],right_rotation:[0f,0f,0f,1f],translation:[-0.3125f,0.3125f,0.01f],scale:[0.25f,0.25f,0.01f]},Rotation:$(rotation)},\
    {id:"minecraft:item_display",Tags:["catenary.studio.gui.item.decoration.1"],item:{Count:1b,id:"minecraft:diamond_sword"},item_display:"gui",transformation:{left_rotation:[0f,1f,0f,0f],right_rotation:[0f,0f,0f,1f],translation:[-0.3125f,0f,0.01f],scale:[0.25f,0.25f,0.01f]},Rotation:$(rotation)},\
    {id:"minecraft:item_display",Tags:["catenary.studio.gui.item.decoration.2"],item:{Count:1b,id:"minecraft:player_head"},item_display:"gui",transformation:{left_rotation:[0f,1f,0f,0f],right_rotation:[0f,0f,0f,1f],translation:[-0.015f,0f,0.01f],scale:[0.25f,0.25f,0.01f]},Rotation:$(rotation)}\
   ]\
  }\
 ]\
}

$execute positioned $(offset) run scoreboard players operation @e[type=item_display,tag=catenary.studio.gui.root.new,distance=..0.1,limit=1] catenary.id = #assign catenary.id
$execute positioned $(offset) run tag @e[type=item_display,tag=catenary.studio.gui.root.new,distance=..0.1] remove catenary.studio.gui.root.new