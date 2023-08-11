class_name RunningState extends State

const ACCELERATION = 400.0
const MAX_SPEED = 200.0

func _on_enter() -> void:
  print("Entering RunningState")
  name = "RunningState"

func _on_exit() -> void:
  pass

func _update(delta: float) -> State:

  var x_input = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
  var y_input = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")

  var direction = Vector2(x_input, y_input).normalized()

  if direction.length() <= 0:
    return IdleState.new(player)

  print(player.velocity)

  player.velocity.x = move_toward(player.velocity.x, direction.x * MAX_SPEED, ACCELERATION * delta)
  player.velocity.y = move_toward(player.velocity.y, direction.y * MAX_SPEED, ACCELERATION * delta)

  return self
