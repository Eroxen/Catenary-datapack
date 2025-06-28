from beet import Context, Function, FunctionTag
import numpy as np

load_functions = []

class FuncApprox:
  def __init__(self, name: str, func: callable, first_der: callable, limit: tuple, scale: int, sections: int):
    self._name = name
    def wrapped_func(x):
      return (func(x/scale)*scale).astype(int)
    self._func = wrapped_func
    def wrapped_first_der(x):
      return (first_der(x/scale)*scale).astype(int)
    self._first_der = wrapped_first_der
    self.scale = scale

    self._params = []
    self._section_size = int((limit * scale) / sections)
    for sec in range(sections):
      centre = (sec + 0.5) * self._section_size
      self._params.append([self._func(centre), self._first_der(centre)])

  def generate(self, ctx):
    self._load_params(ctx)
    self._api_func(ctx)
  
  def _load_params(self, ctx):
    func_name = f"load/math/{self._name}"
    global load_functions
    load_functions.append(f"catenary:{func_name}")

    ctx.data["catenary"].functions[func_name] = Function([
      f"scoreboard players set #math.arcsinh.sec_size catenary.calc {self._section_size}",
      f"scoreboard players set #math.arcsinh.sec_half_size catenary.calc {self._section_size//2}",
      f"scoreboard players set #math.arcsinh.scale catenary.calc {self.scale}",
      f"data modify storage catenary:calc lookup.math.arcsinh set value {self._params}"
    ])
  
  def _api_func(self, ctx):
    func_name = f"math/{self._name}"
    ctx.data["catenary"].functions[func_name] = Function([
      "scoreboard players operation #math.arcsinh.abs catenary.calc = #math.arcsinh.input catenary.calc",
      "execute if score #math.arcsinh.input catenary.calc matches ..-1 run scoreboard players operation #math.arcsinh.abs catenary.calc *= -1 catenary.calc",
      "scoreboard players operation #math.arcsinh.sec catenary.calc = #math.arcsinh.abs catenary.calc",
      "scoreboard players operation #math.arcsinh.sec catenary.calc /= #math.arcsinh.sec_size catenary.calc",
      "data modify storage catenary:calc math.arcsinh set value {}",
      "execute store result storage catenary:calc math.arcsinh.sec int 1 run scoreboard players get #math.arcsinh.sec catenary.calc",
      f"function catenary:{func_name}/macro with storage catenary:calc math.arcsinh",
      "execute store result score #math.arcsinh.output catenary.calc run data get storage catenary:calc math.arcsinh.params[0]",
      "execute store result score #internal.math.temp1 catenary.calc run data get storage catenary:calc math.arcsinh.params[1]",
      "scoreboard players operation #internal.math.temp2 catenary.calc = #math.arcsinh.sec catenary.calc",
      "scoreboard players operation #internal.math.temp2 catenary.calc *= #math.arcsinh.sec_size catenary.calc",
      "scoreboard players operation #internal.math.temp2 catenary.calc += #math.arcsinh.sec_half_size catenary.calc",
      "scoreboard players operation #internal.math.temp2 catenary.calc -= #math.arcsinh.abs catenary.calc",
      "scoreboard players operation #internal.math.temp2 catenary.calc *= -1 catenary.calc",
      "scoreboard players operation #internal.math.temp1 catenary.calc *= #internal.math.temp2 catenary.calc",
      'execute unless score #internal.math.temp1 catenary.calc matches -1000000..1000000 run tellraw @a {"score":{"name":"#internal.math.temp1","objective":"catenary.calc"}}',
      "scoreboard players operation #internal.math.temp1 catenary.calc /= #math.arcsinh.scale catenary.calc",
      "scoreboard players operation #math.arcsinh.output catenary.calc += #internal.math.temp1 catenary.calc",
      "execute if score #math.arcsinh.input catenary.calc matches ..-1 run scoreboard players operation #math.arcsinh.output catenary.calc *= -1 catenary.calc",
      f"execute store result storage catenary:calc math.arcsinh.output double {1/self.scale} run scoreboard players get #math.arcsinh.output catenary.calc"
    ])

    ctx.data["catenary"].functions[f"{func_name}/macro"] = Function([
      "$data modify storage catenary:calc math.arcsinh.params set from storage catenary:calc lookup.math.arcsinh[$(sec)]"
    ])
  
arcsinh_approx = FuncApprox("arcsinh", np.arcsinh, lambda x: 1/np.sqrt((x)**2 + 1), 70, 10000, 10000)

def beet_default(ctx: Context):
  arcsinh_approx.generate(ctx)
  ctx.data["catenary"].function_tags["load/math"] = FunctionTag({"values":load_functions})