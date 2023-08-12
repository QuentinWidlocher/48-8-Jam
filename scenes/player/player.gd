class_name Player
extends CharacterBody2D

@onready var inventory_manager: InventoryManager = get_node("/root/MyInventoryManager")

@onready var debug_label: Label = $Label
@onready var weapon_location: Node2D = $WeaponAnchor/WeaponLocation
@onready var weapon_anchor: Node2D = $WeaponAnchor
@onready var dispenser_area_2d: Area2D = $DispenserArea2D

var state: State
var looking_angle := 0.0
var near_dispenser: Dispenser

func _ready():
  state = IdleState.new(self)
  state.on_enter()

func _physics_process(delta):
  if not state:
    return

  near_dispenser = null
  for area in dispenser_area_2d.get_overlapping_areas():
    var dispenser = area.get_parent()
    if dispenser is Dispenser:
      near_dispenser = dispenser
  
  weapon_anchor.rotation = Vector2.RIGHT.rotated(looking_angle).angle()
  if inventory_manager.current_weapon != null:
    inventory_manager.current_weapon.rotation = -weapon_anchor.rotation

    if inventory_manager.current_weapon != weapon_location.get_child(0):
      switch_weapon(weapon_location.get_child(0), inventory_manager.current_weapon)
  else:
      if weapon_location.get_child(0) != null:
        weapon_location.get_child(0).queue_free()

  var new_state = state.update(delta)

  if state != new_state:
    var previous_name = state.name
    state.on_exit()
    state = new_state
    state.on_enter()
    debug_label.text = state.name
    print("-> " + state.name + " from " + previous_name)

  move_and_slide()

func handle_common_collision():
  pass

func switch_weapon(previous_weapon: Weapon, new_weapon: Weapon):
  weapon_location.remove_child(previous_weapon)
  weapon_location.add_child(new_weapon)

func break_current_weapon():
  inventory_manager.current_weapon = null

func get_current_weapon():
  return inventory_manager.current_weapon
