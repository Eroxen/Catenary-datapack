import json
import glob

all_recipes = set()

for recipe_path in glob.glob("data/catenary/recipes/*.json"):
    recipe = recipe_path[recipe_path.rfind("/")+1:recipe_path.rfind(".json")]
    recipe_base = recipe
    if '.' in recipe_base:
        recipe_base = recipe_base[:recipe_base.find(".")]

    all_recipes.add(recipe_base)
    
    # detection advancement
    with open(f'data/catenary/advancements/craft/{recipe}.json', 'w') as file:
        json.dump(dict(
            criteria = dict(
                crafted = dict(
                    conditions = dict(
                        recipe_id = f"catenary:{recipe}"
                    ),
                    trigger = "minecraft:recipe_crafted"
                )
            ),
            requirements = [["crafted"]],
            rewards = dict(
                function = f"catenary:craft/{recipe}"
            )
        ), file, indent=2)
    
    # give function
    with open(f'data/catenary/functions/craft/{recipe}.mcfunction', 'w') as file:
        file.writelines([
            "clear @s minecraft:knowledge_book 1\n",
            f"advancement revoke @s only catenary:craft/{recipe}\n",
            f"loot give @s loot catenary:preset/{recipe_base}"
        ])
    
    # recipe unlock advancement
    # get ingredients
    with open(f'data/catenary/recipes/{recipe}.json', 'r') as file:
        recipe_obj = json.load(file)
    ingredients = [item[1]['item'] for item in recipe_obj['key'].items() if 'item' in item[1]]
    # write advancement
    with open(f'data/catenary/advancements/recipe_unlock/{recipe}.json', 'w') as file:
        json.dump(dict(
            parent = "catenary:recipe_unlock/root",
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
                        recipe = f"catenary:{recipe}"
                    ),
                    trigger = "minecraft:recipe_unlocked"
                )
            ),
            requirements = [["has_ingredients","has_the_recipe"]],
            rewards = dict(
                recipes = [f"catenary:{recipe}"]
            )
        ), file, indent=2)

all_recipes = sorted(list(all_recipes))

with open(f'data/catenary/loot_tables/all_recipes.json', 'w') as file:
    json.dump(dict(
        type="minecraft:entity",
        pools=[
            dict(
                rolls=1,
                entries=[
                    dict(
                        type="minecraft:loot_table",
                        name="catenary:preset/" + recipe
                    )
                ]
            )
        for recipe in all_recipes ]
    ), file, indent=2)

with open(f'data/catenary/loot_tables/random_recipe.json', 'w') as file:
    json.dump(dict(
        type="minecraft:entity",
        pools=[
            dict(
                rolls=1,
                entries=[
                    dict(
                        type="minecraft:loot_table",
                        name="catenary:preset/" + recipe
                    )
                for recipe in all_recipes ]
            )
        ]
    ), file, indent=2)