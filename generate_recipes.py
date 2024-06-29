import json
import glob
import os

colour_names = ['White', 'Light Gray', 'Gray', 'Black', 'Brown', 'Red', 'Orange', 'Yellow', 'Lime', 'Green', 'Cyan', 'Light Blue', 'Blue', 'Purple', 'Magenta', 'Pink']

def snakecase(string):
    return string.lower().replace(' ', '_')

def generate_candle_recipes():
    base_path = "data/catenary/recipe/candles"
    os.makedirs(base_path, exist_ok=True)

    for a in range(len(colour_names)):
        colour_a = colour_names[a]
        for b in range(a, len(colour_names)):
            colour_b = colour_names[b]
            item_name = 'Candles' if colour_a == colour_b else 'Mixed Candles'
            ingredients = f'- Block: {colour_a} Candle' if colour_a == colour_b else f'- Blocks: {colour_a} Candle, {colour_b} Candle'

            if colour_a == colour_b:
                rope = """{
                            segment_length: 0.4375f,
                            scaling_axis: 1,
                            type: "single",
                            provider: {
                                type: "block",
                                full_length: 0.4375f,
                                block_state: {
                                    Name: "minecraft:""" + snakecase(colour_a) + """_candle"
                                },
                                transformation: {
                                    translation: [0.5f, -0.5f, 0f],
                                    left_rotation: [0f, 0.707f, 0.707f, 0f]
                                }
                            }
                        }"""
            else:
                rope = """{
                            segment_length: 0.4375f,
                            scaling_axis: 1,
                            type: "cycle",
                            providers: [
                                {
                                    type: "block",
                                    full_length: 0.4375f,
                                    block_state: {
                                        Name: "minecraft:""" + snakecase(colour_a) + """_candle"
                                    }
                                },
                                {
                                    type: "block",
                                    full_length: 0.4375f,
                                    block_state: {
                                        Name: "minecraft:""" + snakecase(colour_b) + """_candle"
                                    }
                                }
                            ],
                            default: {
                                transformation: {
                                    translation: [0.5f, -0.5f, 0f],
                                    left_rotation: [0f, 0.707f, 0.707f, 0f]
                                }
                            }
                        }"""


            obj = {
                "type": "minecraft:crafting_shaped",
                "category": "building",
                "group": "catenary:candles",
                "pattern": [
                    "AB ",
                    " AB"
                ],
                "key": {
                    "A": {
                    "item": f"minecraft:{snakecase(colour_a)}_candle"
                    },
                    "B": {
                    "item": f"minecraft:{snakecase(colour_b)}_candle"
                    }
                },
                "result": {
                    "id": "minecraft:firework_rocket",
                    "components": {
                    "!minecraft:fireworks": {},
                    "minecraft:item_name": "{\"text\": \"" + item_name + "\"}",
                    "minecraft:lore": [
                        "{\"text\": \"⛓𝕮𝖆𝖙𝖊𝖓𝖆𝖗𝖞⛓\", \"italic\": false, \"color\": \"#626f85\"}",
                        "{\"text\": \"Rope:\", \"italic\": false, \"color\": \"#e8e18e\"}",
                        "{\"text\": \"- Sag: 1\", \"italic\": false, \"color\": \"#e8e18e\"}",
                        "{\"text\": \"" + ingredients + "\", \"italic\": false, \"color\": \"#e8e18e\"}"
                    ],
                    "minecraft:custom_data": """{
                        catenary: {
                            detect: True,
                            settings: {
                                sag: 1,
                                anchor: {
                                  item: {
                                    id: "minecraft:""" + snakecase(colour_a) + """_shulker_box",
                                    components: {
                                      "minecraft:custom_data": {
                                        transformation: {
                                          scale: [0.3f, 0.3f, 0.3f],
                                          translation:[0f,0.15f,0f]
                                        }
                                      }
                                    }
                                  }
                                },
                                rope: """ + rope + """
                            }
                        }
                    }"""
                    }
                }
                }
            obj['result']['components']['minecraft:custom_data'] = ''.join([l.strip() for l in (obj['result']['components']['minecraft:custom_data'].split('\n'))])

            path = os.path.join(base_path, f"{snakecase(colour_a)}_{snakecase(colour_b)}.json")
            with open(path, 'w') as file:
                json.dump(obj, file, indent=2)



def create_unlock_advancements():
    for recipe_path in glob.glob("data/catenary/recipe/**/*.json"):
        registry_name = os.path.splitext(os.path.relpath(recipe_path, "data/catenary/recipe"))[0]
        print(registry_name)
        
        # recipe unlock advancement
        # get ingredients
        with open(recipe_path, 'r') as file:
            file_contents = ''.join([l.rstrip() for l in file.readlines()])
            recipe_obj = json.loads(file_contents)
        ingredients = list(set([item[1]['item'] for item in recipe_obj['key'].items() if 'item' in item[1]]))
        
        os.makedirs(os.path.split(f'data/catenary/advancement/recipe_unlock/{registry_name}')[0], exist_ok=True)
        
        # write advancement
        with open(f'data/catenary/advancement/recipe_unlock/{registry_name}.json', 'w') as file:
            json.dump(dict(
                criteria = dict(
                    has_ingredients = dict(
                        conditions = dict(
                            items = [
                                dict(
                                    items = ingredients
                                )
                            ]
                        ),
                        trigger = "minecraft:inventory_changed"
                    ),
                    has_the_recipe = dict(
                        conditions = dict(
                            recipe = f"catenary:{registry_name}"
                        ),
                        trigger = "minecraft:recipe_unlocked"
                    )
                ),
                requirements = [["has_ingredients","has_the_recipe"]],
                rewards = dict(
                    recipes = [f"catenary:{registry_name}"]
                )
            ), file, indent=2)


def main():
    generate_candle_recipes()
    create_unlock_advancements()

if __name__ == '__main__':
    main()