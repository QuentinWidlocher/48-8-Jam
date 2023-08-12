class_name AttackingState extends State

var weapon: Weapon

func _on_enter() -> void:
  name = "AttackingState"

  weapon = player.get_current_weapon() 
  print("weapon: ", weapon)

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

  if done:
    return IdleState.new(player)

  return self
