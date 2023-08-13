class_name Dispenser
extends Node2D

enum DispenserType {
  KITCHEN,
  BOOKSHELF,
}

@export var type: DispenserType = DispenserType.KITCHEN

@onready var inventory_manager: InventoryManager = get_node("/root/MyInventoryManager")

const CONTENT: Dictionary = {
  DispenserType.KITCHEN: [
    preload("res://scenes/weapons/laddle.tscn"),
    preload("res://scenes/weapons/pan.tscn"),
  ],
  DispenserType.BOOKSHELF: [
    preload("res://scenes/weapons/dictionnary.tscn"),
  ],
}

const SPRITE: Dictionary = {
  DispenserType.KITCHEN: [
    preload("res://assets/dispensers/Kitchen.png"),
  ],
  DispenserType.BOOKSHELF: [
    preload("res://assets/dispensers/Bookcase_01.png"),
    preload("res://assets/dispensers/Bookcase_02.png"),
  ],
}

const AUDIO: Dictionary = {
  DispenserType.KITCHEN: [
    preload("res://sons/dispensers/kitchen/METLCrsh_Chute 2 barres d acier en tole 1 (ID 1776)_LS.wav"),
    preload("res://sons/dispensers/kitchen/METLCrsh_Chute 2 barres d acier en tole 2 (ID 1777)_LS.wav"),
    preload("res://sons/dispensers/kitchen/METLCrsh_Chute barre d acier en tole 4 (ID 1774)_LS.wav"),
    preload("res://sons/dispensers/kitchen/METLImpt_Fond casserole en cuivre 8cm sample (ID 0384)_LS.wav"),
  ],
  DispenserType.BOOKSHELF: [
    preload("res://sons/dispensers/bookcase/PAPRHndl_Pages qu on tourne 9 (ID 2216)_LS.wav"),
  ],
}


@onready var sprite: Sprite2D = $Sprite2D
@onready var audio_player: AudioStreamPlayer2D = $AudioStreamPlayer2D 

const COOLDOWN := 10.0
var current_cooldown := 0.0

var update_color := false

var is_available: bool:
  get:
    return current_cooldown <= 0.0

func _ready():
  sprite.texture = SPRITE[type][randi() % SPRITE[type].size()]

func _process(delta):
  if update_color:
    if is_available:
      sprite.modulate = Color(0, 1, 1)
    else:
      sprite.modulate = Color(1,1,1,)

  if current_cooldown > 0.0:
    current_cooldown -= delta

func refill():
  if not is_available:
    return

  var random_weapon = CONTENT[type][randi() % CONTENT[type].size()]
  inventory_manager.add_weapon(random_weapon)

  var random_sound = AUDIO[type][randi() % AUDIO[type].size()]
  audio_player.stream = random_sound
  audio_player.play()

  current_cooldown = COOLDOWN


static func parse_enum(value: String) -> DispenserType:
  match value:
    "Kitchen": return DispenserType.KITCHEN
    "Bookshelf": return DispenserType.BOOKSHELF
    _: return DispenserType.KITCHEN



func _on_area_2d_area_entered(area):
  if area.get_parent() is Player:
    update_color = true

func _on_area_2d_area_exited(area):
  if area.get_parent() is Player:
    sprite.modulate = Color(1, 1, 1)
    update_color = false
