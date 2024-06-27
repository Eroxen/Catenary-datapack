function catenary:catenary/internal/render/provider/pool/rng with storage catenary:calc render.settings.random_macro

data modify storage catenary:calc temp set from storage catenary:calc render.settings.entries
function catenary:catenary/internal/render/provider/pool/randomise_loop
data modify storage catenary:calc render.provider set from storage catenary:calc temp[0].provider