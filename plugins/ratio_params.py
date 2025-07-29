from beet import Context, Function, FunctionTag
from nbtlib import Double, List, serialize_tag
import numpy as np
from pathlib import Path

def beet_default(ctx: Context):
  root = Path("ratio_params")
  functions = []
  for sag in [1.01, 1.05, 1.1]:
    path = root / f"{sag}.npy"
    params = np.load(path)
    nbt_params = []
    for row in params:
      nbt_params.append(List([Double(e) for e in row]))
    nbt_params = List(nbt_params)
    function_name = f"load/ratio_params/{sag}"
    ctx.data["catenary"].functions[function_name] = Function([f"data modify storage catenary:calc lookup.ratio_params.\"{sag}\" set value {serialize_tag(nbt_params)}"])
    functions.append(f"catenary:{function_name}")
  
  ctx.data["catenary"].function_tags["load/ratio_params"] = FunctionTag({"values":functions})