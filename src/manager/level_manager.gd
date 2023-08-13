extends Node

const LEVELS = [
  preload("res://scenes/levels/l_1.tscn"),
  preload("res://scenes/levels/l_2.tscn"),
  preload("res://scenes/levels/l_3.tscn"),
  preload("res://scenes/levels/l_4.tscn"),
]
const GAME_OVER_SCREEN = preload('res://scenes/ui/game_over.tscn')
const WIN_SCREEN = preload('res://scenes/ui/win_screen.tscn')
const MUSIC = preload('res://sons/the monster.mp3')

var current_level := 0

var sources_in_level := 0
var current_sources_closed := 0
var all_sources_closed: bool:
  get:
    return current_sources_closed >= sources_in_level

func _ready():
  var player = AudioStreamPlayer.new()
  player.stream = MUSIC
  player.autoplay = true
  player.volume_db = -15
  add_child(player)

func load_level(level: int):
  sources_in_level = 0
  current_sources_closed = 0

  if level >= 4:
    get_tree().change_scene_to_packed(WIN_SCREEN)
    return

  get_tree().change_scene_to_packed(LEVELS[level])
  call_deferred("update_source_number")

  current_level = level

func update_source_number():
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
  print(current_sources_closed, " / ", sources_in_level)

func next_level():
  if all_sources_closed:
    load_level(current_level + 1)

