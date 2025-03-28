$data modify storage catenary:calc text_component set value $(custom_name)
execute if data storage catenary:calc text_component.text run data modify storage catenary:calc text_component set from storage catenary:calc text_component.text
data modify storage catenary:calc spawn.decorations.text set from storage catenary:calc text_component