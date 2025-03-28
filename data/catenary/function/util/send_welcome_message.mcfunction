advancement grant @s only catenary:trigger/send_welcome_message

tellraw @s {"text":"　　　　　　　　　　　　　　　　　　　　　","color":"yellow","strikethrough": true}
tellraw @s {"translate":"catenary.message.welcome.description","color":"light_purple","with":[{"storage":"eroxified2:internal","nbt":"eroxified2.installed_packs[{id:'catenary'}].version.string"}],"fallback": "Catenary v%s by Eroxen"}
tellraw @s {"translate":"catenary.message.welcome.thanks","fallback":"Thank you for installing Catenary!"}
tellraw @s {"text":"→ Datapack Wiki","color":"gray","underlined":true,"hoverEvent":{"action":"show_text","contents":[{"text":"github.com"}]},"clickEvent":{"action":"open_url","value":"https://github.com/Eroxen/Catenary-datapack/wiki"}}
tellraw @s {"text":"→ Support me on Ko-fi","color":"gold","underlined":true,"hoverEvent":{"action":"show_text","contents":[{"text":"ko-fi.com"}]},"clickEvent":{"action":"open_url","value":"https://ko-fi.com/eroxen"}}
tellraw @s {"text":"→ Modrinth","color":"green","underlined":true,"hoverEvent":{"action":"show_text","contents":[{"text":"modrinth.com"}]},"clickEvent":{"action":"open_url","value":"https://modrinth.com/datapack/catenary"}}
tellraw @s {"text":"→ Planet Minecraft","color":"aqua","underlined":true,"hoverEvent":{"action":"show_text","contents":[{"text":"planetminecraft.com"}]},"clickEvent":{"action":"open_url","value":"https://www.planetminecraft.com/data-pack/catenary/"}}
tellraw @s {"text":"→ Discord","color":"blue","underlined":true,"hoverEvent":{"action":"show_text","contents":[{"text":"discord.gg"}]},"clickEvent":{"action":"open_url","value":"https://discord.gg/p6jh5j2fY3"}}
tellraw @s {"text":"　　　　　　　　　　　　　　　　　　　　　","color":"yellow","strikethrough": true}