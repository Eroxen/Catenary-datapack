summon item_display ~ ~ ~ {Tags:["catenary.zipline.remount","catenary.entity"]}
ride @s mount @n[type=item_display,tag=catenary.zipline.remount,distance=..1]
kill @e[type=item_display,tag=catenary.zipline.remount,distance=..1]
tp @s ~ ~ ~

# summon ender_pearl ~ ~ ~ {Tags:["catenary.zipline.dismount_pearl"],Motion:[0d,-1d,0d],Silent:1b}
# data modify entity @n[type=ender_pearl,tag=catenary.zipline.dismount_pearl,distance=..1] Owner set from entity @s UUID
# tag @e[type=ender_pearl,tag=catenary.zipline.dismount_pearl,distance=..1] remove catenary.zipline.dismount_pearl