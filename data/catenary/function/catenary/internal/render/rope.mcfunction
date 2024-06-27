#####################################################################
# catenary/internal/render/rope.mcfunction
# written by Eroxen
#
# Rope config:
# - type : "block"
# - segment_length : distance between sample points (blocks)
# - scaling_axis : index in transformation.scale that will be set to the segment length (default 2)
# - EntityData : data for display entity
#####################################################################
execute summon marker run function catenary:catenary/internal/render/rope/on_marker