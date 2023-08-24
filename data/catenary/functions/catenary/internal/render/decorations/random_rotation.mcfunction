scoreboard players set #render.horizontal_rotation catenary.calc 0
execute if predicate eroxified:random/1_2 run scoreboard players add #render.horizontal_rotation catenary.calc 1
execute if predicate eroxified:random/1_2 run scoreboard players add #render.horizontal_rotation catenary.calc 2
execute if predicate eroxified:random/1_2 run scoreboard players add #render.horizontal_rotation catenary.calc 4
execute if predicate eroxified:random/1_2 run scoreboard players add #render.horizontal_rotation catenary.calc 8
execute if predicate eroxified:random/1_2 run scoreboard players add #render.horizontal_rotation catenary.calc 16
execute if predicate eroxified:random/1_2 run scoreboard players add #render.horizontal_rotation catenary.calc 32
execute if predicate eroxified:random/1_2 run scoreboard players add #render.horizontal_rotation catenary.calc 64
execute if predicate eroxified:random/1_2 run scoreboard players add #render.horizontal_rotation catenary.calc 128
execute if predicate eroxified:random/1_2 run scoreboard players add #render.horizontal_rotation catenary.calc 256
execute if predicate eroxified:random/1_2 run scoreboard players add #render.horizontal_rotation catenary.calc 512
execute store result storage catenary:calc render.EntityData.Rotation[0] float 0.35156 run scoreboard players get #render.horizontal_rotation catenary.calc