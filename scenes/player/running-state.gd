class_name RunningState extends State

const ACCELERATION = 5000.0
const MAX_SPEED = 500.0

func _on_enter() -> void:
  name = "RunningState"

func _on_exit() -> void:
  pass

func _update(delta: float) -> State:
  var x_input = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
  var y_input = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")

  var direction = Vector2(x_input, y_input).normalized()

  if direction.length() <= 0:
    return IdleState.new(player)

  player.looking_angle = direction.angle()

  player.velocity.x = move_toward(player.velocity.x, direction.x * MAX_SPEED, ACCELERATION * delta)
  player.velocity.y = move_toward(player.velocity.y, direction.y * MAX_SPEED, ACCELERATION * delta)

  if Input.is_action_just_pressed("dodge"):
    return DodgingState.new(player)

  if (Input.is_action_just_pressed("attack")):
    return AttackingState.new(player)

  return self
