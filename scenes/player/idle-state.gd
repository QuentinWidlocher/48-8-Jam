class_name IdleState extends State

var DECELERATION = RunningState.ACCELERATION

func _on_enter() -> void:
  name = "IdleState"
  player.animated_sprite.play("idle")

func _on_exit() -> void:
  pass

func _update(delta: float) -> State:
  var x_input = Input.get_action_strength("move_left") - Input.get_action_strength("move_right")
  var y_input = Input.get_action_strength("move_up") - Input.get_action_strength("move_down")

  var direction = Vector2(x_input, y_input).normalized()

  if direction.length() > 0:
    return RunningState.new(player)

  player.velocity.x = move_toward(player.velocity.x, 0.0, DECELERATION * delta)
  player.velocity.y = move_toward(player.velocity.y, 0.0, DECELERATION * delta)

  if (Input.is_action_just_pressed("attack")):
    if player.near_dispenser != null:
      player.near_dispenser.refill()
    else:
      return AttackingState.new(player)

  return self
