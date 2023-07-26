#####################################################################
# catenary/internal/render/decorations.mcfunction
# written by Eroxen
#
# Decorations config:
# - type : "block"
# - spacing : distance between sample points (blocks)
# - placement : "point" (on the sample point) or "middle" (between 2 sample points)
# - EntityData : data for display entity
# - variations : list of objects :
#   - EntityData
#####################################################################
execute summon marker run function catenary:catenary/internal/render/decorations/on_marker