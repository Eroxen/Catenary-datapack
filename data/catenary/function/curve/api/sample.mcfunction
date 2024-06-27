#####################################################################
# curve/api/sample.mcfunction
# written by Eroxen
#
# Samples points from a curve
#
# Storage input :
# - catenary:calc :
#   - curve : curve object
# Scoreboard input :
# - catenary.calc :
#   - #curve.sample_distance : desired distance between samples * 1000
#   - #curve.sample_count : number of samples, used if #curve.sample_distance is 0
#
# Storage output :
# - catenary:calc :
#   - curve :
#     - samples : 3d samples
#####################################################################

execute if data storage catenary:calc curve{type:"catenary"} run function catenary:curve/internal/2d/sample_as_3d
execute if data storage catenary:calc curve{type:"straight"} run function catenary:curve/internal/3d/sample_straight