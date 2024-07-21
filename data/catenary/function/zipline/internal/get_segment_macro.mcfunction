data modify storage catenary:calc temp set value {}
$data modify storage catenary:calc temp.1 set from storage catenary:calc zipline.data.trajectory.points[$(i)]
$data modify storage catenary:calc temp.2 set from storage catenary:calc zipline.data.trajectory.points[$(j)]

data modify storage catenary:calc zipline.data.segment.pos1 set from storage catenary:calc temp.1.pos
data modify storage catenary:calc zipline.data.segment.pos2 set from storage catenary:calc temp.2.pos
execute if data storage catenary:calc zipline.spawn.trajectory{swapped_points:1b} run data modify storage catenary:calc zipline.data.segment.length set from storage catenary:calc temp.1.distance
execute unless data storage catenary:calc zipline.spawn.trajectory{swapped_points:1b} run data modify storage catenary:calc zipline.data.segment.length set from storage catenary:calc temp.2.distance