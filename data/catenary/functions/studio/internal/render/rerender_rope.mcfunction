kill @e[type=item_display,tag=catenary.render.rope,predicate=catenary:match_id]
kill @e[type=block_display,tag=catenary.render.rope,predicate=catenary:match_id]

data modify storage catenary:calc curve set from storage catenary:calc studio.data.curve
data modify storage catenary:calc spawn set from storage catenary:calc studio.data.spawn

execute summon marker run function catenary:studio/internal/render/rerender_rope_marker