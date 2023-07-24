data modify storage catenary:calc render set value {}
data modify storage catenary:calc render.points set from storage catenary:calc 3dpath.samples
data modify storage catenary:calc render.distances set from storage catenary:calc 3dpath.2dpath.samples_d
data modify storage catenary:calc render.point set from storage catenary:calc render.points[0]
data remove storage catenary:calc render.points[0]
data remove storage catenary:calc render.distances[0]