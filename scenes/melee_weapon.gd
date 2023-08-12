class_name MeleeWeapon
extends Weapon

var damage: float
var durability: float
var duration: float

var current_timer: float = 0.0

func _init(the_damage: float, the_durability: float, the_duration: float):
  damage = the_damage
  durability = the_durability
  duration = the_duration

func _on_exit() -> bool:
  current_timer = 0.0
  durability -= 1

  return durability <= 0

func _update(delta:float) -> bool:
  current_timer += delta

  return current_timer >= duration
