class_name Dispenser
extends Node2D

enum DispenserType {
  KITCHEN
}

@export var type: DispenserType = DispenserType.KITCHEN

@onready var inventory_manager: InventoryManager = get_node("/root/MyInventoryManager")

const CONTENT: Dictionary = {
  DispenserType.KITCHEN: [
    preload("res://scenes/weapons/laddle.tscn"),
  ]
}

const SPRITE: Dictionary = {
  DispenserType.KITCHEN: preload("res://icon.svg"),
}

@onready var sprite: Sprite2D = $Sprite2D

func _ready():
  sprite.texture = SPRITE[type]

func refill():
  var random_weapon = CONTENT[type][randi() % CONTENT[type].size()]
  inventory_manager.add_weapon(random_weapon)

static func parse_enum(value: String) -> DispenserType:
  match value:
    "Kitchen": return DispenserType.KITCHEN
    _: return DispenserType.KITCHEN

