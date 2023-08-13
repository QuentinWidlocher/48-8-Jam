class_name HurtState extends State

const KNOCKBACK_SPEED = 700
const DECELERATION = 1200.0

var mob: Mob

func _init(the_player: Player, the_mob: Mob):
  super._init(the_player)
  mob = the_mob

func _on_enter() -> void:
  name = "HurtState"
  var direction = player.position - mob.position
  player.velocity = direction.normalized() * KNOCKBACK_SPEED

func _on_exit() -> void:
  pass

func _update(delta: float) -> State:
  player.velocity.x = move_toward(player.velocity.x, 0.0, DECELERATION * delta)
  player.velocity.y = move_toward(player.velocity.y, 0.0, DECELERATION * delta)

  if player.velocity.length() <= 5:
    return IdleState.new(player)

  return self
