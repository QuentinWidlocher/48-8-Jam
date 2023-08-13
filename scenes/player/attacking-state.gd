class_name AttackingState extends State

var weapon: Weapon
var ACCELERATION = RunningState.ACCELERATION
var MAX_SPEED = RunningState.MAX_SPEED

func _on_enter() -> void:
  name = "AttackingState"
  player.animated_sprite.play("melee_attack")

  weapon = player.get_current_weapon()

  if weapon != null:
    weapon.on_enter()

func _on_exit() -> void:
  if weapon != null:
    var should_be_destroyed := weapon.on_exit()
    if should_be_destroyed:
      player.break_current_weapon()

func _update(delta: float) -> State:
  if weapon == null:
    return IdleState.new(player)

  var done = weapon.update(delta)
  
  var x_input = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
  var y_input = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")

  var direction = Vector2(x_input, y_input).normalized()

  if direction.length() > 0:
    player.looking_angle = direction.angle()

  if direction.x < 0:
    player.animated_sprite.flip_h = true
  else:
    player.animated_sprite.flip_h = false

  player.velocity.x = move_toward(player.velocity.x, direction.x * MAX_SPEED, ACCELERATION * delta)
  player.velocity.y = move_toward(player.velocity.y, direction.y * MAX_SPEED, ACCELERATION * delta)

  if done:
    return IdleState.new(player)

  return self
