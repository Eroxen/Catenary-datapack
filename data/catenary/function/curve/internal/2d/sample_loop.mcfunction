execute store result score #curve.2d.sample.l catenary.calc run data get storage catenary:calc curve.2d.sample[0].l_cum 1000
execute if score #curve.2d.sample.l catenary.calc >= #curve.2d.sample.next catenary.calc run function catenary:curve/internal/2d/add_sample
data remove storage catenary:calc curve.2d.sample[0]
execute if data storage catenary:calc curve.2d.sample[0] run function catenary:curve/internal/2d/sample_loop