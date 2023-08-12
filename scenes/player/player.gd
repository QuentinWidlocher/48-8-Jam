class_name Player
extends CharacterBody2D

@onready var debug_label: Label = $Label
@onready var weapon_location: Node2D = $WeaponAnchor/WeaponLocation
@onready var weapon_anchor: Node2D = $WeaponAnchor

var state: State
var weapons: Array = [
  load("res://scenes/weapons/laddle.tscn").instantiate()
]
var current_weapon := 0
var looking_angle := 0.0

func _ready():
  print("player ready")
  state = IdleState.new(self)
  state.on_enter()

  weapon_location.add_child(get_current_weapon())
  #get_current_weapon().position = weapon_location.position

func _physics_process(delta):
  if not state:
    return
  
  weapon_anchor.rotation = Vector2.RIGHT.rotated(looking_angle).angle()
  if get_current_weapon() != null:
    get_current_weapon().rotation = -weapon_anchor.rotation

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

func get_current_weapon():
  return weapons[current_weapon]

func break_current_weapon():
  weapon_location.remove_child(get_current_weapon())
  weapons[current_weapon] = null
