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

func refill():
  var random_weapon = CONTENT[type][randi() % CONTENT[type].size()]
  inventory_manager.add_weapon(random_weapon)
