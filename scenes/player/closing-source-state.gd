class_name ClosingSourceState extends State

var DECELERATION = RunningState.ACCELERATION / 5.0

func _on_enter() -> void:
  name = "ClosingSourceState"
  player.animated_sprite.play("melee_attack")

func _on_exit() -> void:
  pass

func _update(delta: float) -> State:
  if Input.is_action_pressed("attack") and player.near_source != null:
    player.near_source.close(delta)
  else:
    return IdleState.new(player)

  player.velocity.x = move_toward(player.velocity.x, 0.0, DECELERATION * delta)
  player.velocity.y = move_toward(player.velocity.y, 0.0, DECELERATION * delta)

  return self
