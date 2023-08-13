extends Node

const LDTK_PROJECT = preload('res://assets/level_design.ldtk')
const GAME_OVER_SCREEN = preload('res://scenes/ui/game_over.tscn')

var current_level := 0

var sources_in_level := 0
var current_sources_closed := 0

func _ready():
  pass

func load_level(level: int):
  sources_in_level = 0
  current_sources_closed = 0

  current_level = level
  var ldtk_levels = LDTK_PROJECT.instantiate()
  var levels := ldtk_levels.get_children()

  if current_level >= levels.size():
    current_level = 0

  var level_to_load = levels[current_level]
  ldtk_levels.remove_child(level_to_load)

  var root := get_tree().root
  
  root.add_child(level_to_load)
  var current_scene = get_tree().current_scene

  if current_scene:
    root.remove_child(current_scene)

  get_tree().current_scene = level_to_load
  sources_in_level = get_tree().current_scene.get_node("Entities").get_children().filter(func(child): return child is Source).size()

    
func get_current_tilemap() -> TileMap:
  for child in get_tree().current_scene.get_children():
    if child is TileMap:
      return child

  return null

func spawn_entity(pack: PackedScene):
  var instance = pack.instance()
  get_tree().current_scene.get_node("Entities").add_child(instance)
  return instance

func player_died():
  get_tree().change_scene_to_packed(GAME_OVER_SCREEN)

func source_closed():
  current_sources_closed += 1

  if current_sources_closed >= sources_in_level:
    load_level(current_level + 1)
