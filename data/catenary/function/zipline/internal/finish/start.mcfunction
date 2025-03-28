execute on vehicle on passengers unless entity @s[tag=catenary.zipline] run tag @s add catenary.zipline.ride

data modify storage catenary:calc macro set value {}
data modify storage catenary:calc macro.x set from storage catenary:calc zipline.end_point[0]
data modify storage catenary:calc macro.y set from storage catenary:calc zipline.end_point[1]
data modify storage catenary:calc macro.z set from storage catenary:calc zipline.end_point[2]
function catenary:zipline/internal/finish/find_anchor with storage catenary:calc macro

execute on vehicle on passengers unless entity @s[tag=catenary.zipline] run tag @s remove catenary.zipline.ride