execute store result score 2dpath.cl catenary.calc run data get storage catenary:calc 2dpath.sample.l_cum[0] 1000
execute if score 2dpath.cl catenary.calc >= 2dpath.next_sample catenary.calc run function catenary:2dpath/next_sample

data remove storage catenary:calc 2dpath.sample.l_cum[0]
data remove storage catenary:calc 2dpath.sample.x[0]
data remove storage catenary:calc 2dpath.sample.y[0]
execute if data storage catenary:calc 2dpath.sample.l_cum[0] run function catenary:2dpath/sample_loop