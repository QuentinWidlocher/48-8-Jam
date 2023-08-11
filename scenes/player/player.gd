class_name Player
extends CharacterBody2D

var state: State

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
    print("-> " + state.name + " from " + previous_name)

  move_and_slide()

func handle_common_collision():
  pass
