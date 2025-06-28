from beet import Context, Function, FunctionTag
from nbtlib import String, List, IntArray, Compound, serialize_tag
from pathlib import Path
from bs4 import BeautifulSoup as bs
import json
import requests
from tqdm import tqdm
from collections import Counter
from itertools import chain

CHARSET = set(
  list('abcdefghijklmnopqrstuvwxyz0123456789') +
  ['apostrophe', 'backslash', 'period', 'exclamation mark', 'question mark', 'quote', 'equals', 'plus', 'semicolon', 'comma', 'curly bracket (open)', 'curly bracket (closed)', 'percent sign', 'square bracket (open)', 'square bracket (closed)', 'round bracket (open)', 'round bracket (closed)', 'underscore', 'octothorpe', 'minus', 'colon', 'slash', 'heart', 'blank', 'ampersand'] +
  ['euro', 'pound', 'yen', 'dollar', '@']
)

CHAR_MAPPING = {
  'apostrophe': "'",
  'backslash': '\\',
  'period': '.',
  'exclamation mark': '!',
  'question mark': '?',
  'quote': '"',
  'equals': '=',
  'plus': '+',
  'minus': '-',
  'semicolon': ';',
  'comma': ',',
  'curly bracket (open)': '{',
  'curly bracket (closed)': '}',
  'percent sign': '%',
  'square bracket (open)': '[',
  'square bracket (closed)': ']',
  'round bracket (open)': '(',
  'round bracket (closed)': ')',
  'underscore': '_',
  'octothorpe': '#',
  'colon': ':',
  'slash': '/',
  'heart': '❤',
  'ampersand': '&',
  'euro': '€',
  'pound': '£',
  'yen': '¥',
  'dollar': '$',
  'blank': ' '
}

def profile_to_nbt(profile):
  return serialize_tag(Compound({
    'id':IntArray(profile['id']),
    'properties': List([
      Compound({
        'name': String('textures'),
        'value': String(profile['properties'][0]['value'])
      })
    ])
    }))

def scrape_profile_info_at_url(url):
    page = requests.get(url)
    soup = bs(page.text, 'html.parser')
    # title = soup.find("div", {"id": "content-main"}).find("h1").contents[0].strip()
    loot_table = json.loads(soup.find("textarea", {"id": "LootTable"}).contents[0])
    profile = loot_table['pools'][0]['entries'][0]['functions'][1]['components']['minecraft:profile']
    return profile

def titles_and_links_from_result_page(soup):
  ret = []
  head_boxes = soup.find("div", {"class":"head-list"}).find_all("div", {"class":"head-box"})
  for head_box in head_boxes:
    title = head_box.find_all("a")[2]['title']
    link = head_box.find_all("a")[2]['href']
    ret.append([title, link])
  return ret

def scrape_result_pages(first_page_url):
  page = requests.get(first_page_url)
  soup = bs(page.text, 'html.parser')
  end_link = soup.find("div", {"class":"mq-container"}).find_all("a")[-2]['href']
  num_pages = int(end_link[end_link.find('page=')+5:])

  ret = titles_and_links_from_result_page(soup)
  for i in range(1, num_pages+1):
    page = requests.get(first_page_url + f'?page={i}')
    soup = bs(page.text, 'html.parser')
    ret += titles_and_links_from_result_page(soup)
  
  return ret

class HeadFont:
  def __init__(self, name, url):
    self.name = name
    self.url = url
    self.cache_path = Path('player_head_font_cache') / self.name
    self.cache_path.mkdir(parents=True, exist_ok=True)
  
  def get_titles_and_links(self):
    cache_file = self.cache_path / "titles_and_links.json"
    if cache_file.is_file():
      with open(cache_file.as_posix(), 'r') as f:
        titles_and_links = json.load(f)
    else:
      # cache does not exist -> scrape url and make cache
      titles_and_links = scrape_result_pages(self.url)
      with open(cache_file.as_posix(), 'w') as f:
        json.dump(titles_and_links, f, indent=2)
    return list(zip(*titles_and_links))
  
  def get_char_index(self):
    titles, links = self.get_titles_and_links()
    titles = [e.lower().split(' ') for e in titles]
    ### remove all words that occur in over 90% of titles ###
    remove = set()
    for word, count in Counter(chain(*titles)).most_common():
      if count < 0.9 * len(titles):
        break
      remove.add(word)
    titles = [" ".join(list(filter(lambda x: x not in remove, a))) for a in titles]
    
    index = {}
    already_added = set()
    for i in range(len(titles)):
      if titles[i] in CHARSET and titles[i] not in already_added:
        index[titles[i]] = links[i]
        already_added.add(titles[i])
    missing_chars = already_added - CHARSET
    if len(missing_chars) > 0:
      print(f'Font "{self.name}" is missing chars: f{missing_chars}')
    
    # replace urls in index with profiles
    profiles = self.get_profiles_from_urls(index.values())
    index = dict(zip(index.keys(), profiles))
    return index
  
  def get_profiles_from_urls(self, urls):
    cache_file = self.cache_path / "profiles.json"
    if cache_file.is_file():
      with open(cache_file.as_posix(), 'r') as f:
        cache = json.load(f)
    else:
      cache = {}
    
    profiles = []
    cache_changed = False
    for url in tqdm(urls):
      if url in cache:
        profiles.append(cache[url])
      else:
        # url not in cache -> scrape profile and add to cache
        profile = scrape_profile_info_at_url(url)
        cache[url] = profile
        cache_changed = True
        profiles.append(profile)
    if cache_changed:
      with open(cache_file.as_posix(), 'w') as f:
        cache = json.dump(cache, f, indent=2)
    return profiles
  
  def load_func(self):
    cache_file = self.cache_path / "load_func.mcfunction"
    if cache_file.is_file():
      with open(cache_file.as_posix(), 'r') as f:
        return f.readlines()

    # cache file does not exist -> generate
    index = self.get_char_index()
    lines = []
    for char, profile in index.items():
      key = char
      if key in CHAR_MAPPING:
        key = CHAR_MAPPING[key]
      if key == '"':
        escaped_key = "'\"'"
      elif key == "'":
        escaped_key = '"\'"'
      elif key == "\\":
        escaped_key = '"\\\\"'
      else:
        escaped_key = f'"{key}"'
      lines.append(f"data modify storage catenary:calc lookup.typefaces.{self.name}.{escaped_key} set value {profile_to_nbt(profile)}\n")
    
    with open(cache_file.as_posix(), 'w') as f:
      f.writelines(lines)
    return lines
  
  def generate_load_func(self, ctx):
    func_name = f"load/typefaces/{self.name}"
    ctx.data["catenary"].functions[func_name] = Function([l.rstrip() for l in self.load_func()])
    return f"catenary:{func_name}"

FONTS = [
  HeadFont("oak", "https://minecraft-heads.com/custom-heads/tag/font-oak"),
  HeadFont("pumpkin", "https://minecraft-heads.com/custom-heads/tag/font-pumpkin")
]

def beet_default(ctx: Context):
  load_funcs = [f.generate_load_func(ctx) for f in FONTS]
  ctx.data["catenary"].function_tags["load/typefaces"] = FunctionTag({"values":load_funcs})
