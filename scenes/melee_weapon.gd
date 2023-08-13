class_name MeleeWeapon
extends Weapon

@export var damage: float
@export var durability: float
@export var duration: float

var current_timer: float = 0.0

func _on_enter():
  animation_player.speed_scale = 1.0 / duration
  animation_player.play("melee_attack")
  audio_player.stream = SOUNDS[randi() % SOUNDS.size()]
  audio_player.play()

func _on_exit() -> bool:
  animation_player.play("RESET")
  current_timer = 0.0
  durability -= 1

  return durability <= 0

func _update(delta:float) -> bool:
  current_timer += delta

  return current_timer >= duration
