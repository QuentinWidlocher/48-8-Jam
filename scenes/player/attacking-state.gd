class_name AttackingState extends State

var weapon: Weapon
var DECELERATION = RunningState.ACCELERATION / 5.0

func _on_enter() -> void:
  name = "AttackingState"

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
  
  player.velocity.x = move_toward(player.velocity.x, 0.0, DECELERATION * delta)
  player.velocity.y = move_toward(player.velocity.y, 0.0, DECELERATION * delta)

  if done:
    return IdleState.new(player)

  return self
