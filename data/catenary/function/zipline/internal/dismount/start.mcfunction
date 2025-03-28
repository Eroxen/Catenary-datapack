data modify storage catenary:calc macro set value {x:0,y:0,z:0}
execute store result storage catenary:calc macro.x int 1 run data get storage catenary:calc zipline.end_point[0] 1
execute store result storage catenary:calc macro.y int 1 run data get storage catenary:calc zipline.end_point[1] 1
execute store result storage catenary:calc macro.z int 1 run data get storage catenary:calc zipline.end_point[2] 1
function catenary:zipline/internal/dismount/position with storage catenary:calc macro