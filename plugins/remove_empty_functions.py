from beet import Context

def beet_default(ctx: Context):
    remove = []

    for name, function in ctx.data.functions.items():
        if len(function.lines) == 0:
            remove.append(name)

    for name in remove:
        del ctx.data.functions[name]
