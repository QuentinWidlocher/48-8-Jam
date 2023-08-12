extends Node

const LDTK_PROJECT = preload('res://assets/level_design.ldtk')

var current_level := 0

func _ready():
  pass

func load_level(level: int):
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
    
