class_name RunningState extends State

const ACCELERATION = 5000.0
const MAX_SPEED = 500.0

func _on_enter() -> void:
  name = "RunningState"
  player.animated_sprite.play("running")

func _on_exit() -> void:
  pass

func _update(delta: float) -> State:
  var x_input = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
  var y_input = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")

  var direction = Vector2(x_input, y_input).normalized()

  if direction.length() <= 0:
    return IdleState.new(player)

  player.looking_angle = direction.angle()

  if direction.x < 0:
    player.animated_sprite.flip_h = true
  else:
    player.animated_sprite.flip_h = false

  player.velocity.x = move_toward(player.velocity.x, direction.x * MAX_SPEED, ACCELERATION * delta)
  player.velocity.y = move_toward(player.velocity.y, direction.y * MAX_SPEED, ACCELERATION * delta)

  if Input.is_action_just_pressed("dodge"):
    if player.near_dispenser != null and player.near_dispenser.is_available:
      player.near_dispenser.refill()
    elif player.near_source != null:
      return ClosingSourceState.new(player)
    elif player.near_door != null:
      player.level_manager.next_level()
    else:
      return DodgingState.new(player)

  if Input.is_action_just_pressed("attack") and player.get_current_weapon() != null:
    return AttackingState.new(player)

  return self
