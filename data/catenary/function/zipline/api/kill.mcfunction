#####################################################################
# zipline/api/kill.mcfunction
# written by Eroxen
#
# Kills the zipline rider. Called as the marker riding the display.
#####################################################################

execute on vehicle on passengers unless entity @s[tag=catenary.zipline] run ride @s dismount
execute on vehicle run function eroxified2:entity/api/kill_stack