class_name InventoryManager
extends Node

const MAX_WEAPON_COUNT = 4

var weapons: Array = [
  null, null, null, null
]

var current_weapon_index := 0

signal inventory_updated(weapons: Array)
signal current_weapon_updated(weapon: Weapon)

func _physics_process(_delta):
  if Input.is_action_just_pressed("scroll_item_prev"):
    current_weapon_index -= 1
    current_weapon_index = current_weapon_index % MAX_WEAPON_COUNT
    current_weapon_updated.emit(current_weapon)
    print(weapons)

  if Input.is_action_just_pressed("scroll_item_next"):
    current_weapon_index += 1
    current_weapon_index = current_weapon_index % MAX_WEAPON_COUNT
    current_weapon_updated.emit(current_weapon)
    print(weapons)

var current_weapon: Weapon:
  get:
    return weapons[current_weapon_index] if is_instance_valid(weapons[current_weapon_index]) else null
  set(value):
    weapons[current_weapon_index] = value
    inventory_updated.emit(weapons)

func add_weapon(weapon_packed: PackedScene):
  for i in range(MAX_WEAPON_COUNT):
    var weapon = weapons[i]
    if weapon == null:
      weapons[i] = weapon_packed.instantiate()
      current_weapon_index = i
      current_weapon_updated.emit(current_weapon)
      inventory_updated.emit(weapons)
      print(weapons)
      break


