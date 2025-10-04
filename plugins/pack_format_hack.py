from beet import Context, Mcmeta

def add_pack_format(cfg):
  ret = cfg.copy()
  if "pack_format" in cfg:
    return ret
  if isinstance(cfg["min_format"], int):
    ret["pack_format"] = cfg["min_format"]
  elif isinstance(cfg["min_format"], list):
    ret["pack_format"] = cfg["min_format"][0]
  return ret

def beet_default(ctx: Context):
  config = ctx.meta["pack_format_hack"]
  if "data_pack" in config:
    ctx.data.mcmeta = Mcmeta({
        "pack": add_pack_format(config["data_pack"])
    })
  if "resource_pack" in config:
    ctx.assets.mcmeta = Mcmeta({
        "pack": add_pack_format(config["resource_pack"])
    })