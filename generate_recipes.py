import json
import glob
import os

# all_recipes = set()

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

# all_recipes = sorted(list(all_recipes))

# with open(f'data/catenary/loot_tables/all_recipes.json', 'w') as file:
#     json.dump(dict(
#         type="minecraft:entity",
#         pools=[
#             dict(
#                 rolls=1,
#                 entries=[
#                     dict(
#                         type="minecraft:loot_table",
#                         name="catenary:preset/" + recipe
#                     )
#                 ]
#             )
#         for recipe in all_recipes ]
#     ), file, indent=2)

# with open(f'data/catenary/loot_tables/random_recipe.json', 'w') as file:
#     json.dump(dict(
#         type="minecraft:entity",
#         pools=[
#             dict(
#                 rolls=1,
#                 entries=[
#                     dict(
#                         type="minecraft:loot_table",
#                         name="catenary:preset/" + recipe
#                     )
#                 for recipe in all_recipes ]
#             )
#         ]
#     ), file, indent=2)