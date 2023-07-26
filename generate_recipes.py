import json

for recipe in [
    "simple_chain",
    "straight_chain",
    "chain_with_lanterns",
    "chain_with_mixed_lanterns",
    "chain_with_paper_lanterns",
    "end_rods",
    "electrical_cable",
    "catenary_spelling"
    ]:
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
            f"loot give @s loot catenary:preset/{recipe}"
        ])
    
    # recipe unlock advancement
    # get ingredients
    with open(f'data/catenary/recipes/{recipe}.json', 'r') as file:
        recipe_obj = json.load(file)
    ingredients = [item[1]['item'] for item in recipe_obj['key'].items()]
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