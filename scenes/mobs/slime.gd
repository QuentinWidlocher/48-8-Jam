class_name Slime
extends Mob

const DIRECTION_CHANGE_TIME := 3.0
const SPEED := 50

var current_timeout := 0.0
var current_direction := Vector2.ZERO

func _physics_process(delta):
  current_timeout -= delta

  if can_be_hurt:
    if current_timeout <= 0:
      current_direction = get_random_direction()
      current_timeout = DIRECTION_CHANGE_TIME
    else:
      velocity = current_direction * SPEED

  move_and_slide()

func get_random_direction() -> Vector2:
  return Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()

