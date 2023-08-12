class_name InventoryManager
extends Node

const MAX_WEAPON_COUNT = 4

var weapons: Array = [
  null, null, null, null
]

var current_weapon_index := 0

var current_weapon: Weapon:
  get:
    return weapons[current_weapon_index]
  set(value):
    weapons[current_weapon_index] = value

func add_weapon(weapon_packed: PackedScene):
  for i in range(MAX_WEAPON_COUNT):
    var weapon = weapons[i]
    if weapon == null:
      weapons[i] = weapon_packed.instantiate()
      current_weapon_index = i
