class_name Bat
extends Mob

const DIRECTION_CHANGE_TIME := 2.0
const SPEED := 150

var current_timeout := DIRECTION_CHANGE_TIME
var current_direction := Vector2.ZERO

func _physics_process(delta):
  current_timeout -= delta
  print(current_timeout)

  if current_timeout <= 0:
    current_direction = get_random_direction()
    current_timeout = DIRECTION_CHANGE_TIME
  else:
    velocity = current_direction * SPEED
    move_and_slide()

func get_random_direction() -> Vector2:
  return Vector2(randf_range(-1, 1), randf_range(-1, 1))
