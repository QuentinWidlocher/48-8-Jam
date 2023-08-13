class_name DodgingState extends State

const DODGE_SPEED = 100000
const DODGE_TIME = 0.2

const DASH_SOUNDS := [
  preload("res://sons/dispensers/woosh/SWSH_Whoosh 7 (ID 1800)_LS.wav"),
  preload("res://sons/dispensers/woosh/SWSH_Whoosh 8 (ID 1801)_LS.wav"),
  preload("res://sons/dispensers/woosh/SWSH_Whoosh 10 (ID 1798)_LS.wav"),
]

var direction: Vector2
var previous_velocity: float
var current_time = 0.0

func _on_enter() -> void:
  name = "DodgingState"

  var x_input = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
  var y_input = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")

  direction = Vector2(x_input, y_input).normalized()

  previous_velocity = player.velocity.length()
  
  player.get_node("AudioStreamPlayer2D").stream = DASH_SOUNDS[randi() % DASH_SOUNDS.size()]
  player.get_node("AudioStreamPlayer2D").play()


func _on_exit() -> void:
  player.velocity = direction * previous_velocity
  pass

func _update(delta: float) -> State:

  current_time += delta

  if current_time >= DODGE_TIME:
    return RunningState.new(player)

  player.velocity.x = direction.x * DODGE_SPEED * delta
  player.velocity.y = direction.y * DODGE_SPEED * delta

  return self
