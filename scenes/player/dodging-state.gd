class_name DodgingState extends State

const DODGE_SPEED = 100000
const DODGE_TIME = 0.2

var direction: Vector2
var previous_velocity: float
var current_time = 0.0

func _on_enter() -> void:
  var x_input = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
  var y_input = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")

  direction = Vector2(x_input, y_input).normalized()

  previous_velocity = player.velocity.length()

  name = "DodgingState"

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
