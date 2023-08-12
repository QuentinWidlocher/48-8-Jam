class_name Player
extends CharacterBody2D

@onready var debug_label = $Label

var state: State
var weapons: Array = [
  MeleeWeapon.new(1.0, 5.0, 0.5),
]
var current_weapon := 0

func _ready():
  state = IdleState.new(self)
  state.on_enter()

func _physics_process(delta):
  if not state:
    return

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
  weapons[current_weapon] = null

