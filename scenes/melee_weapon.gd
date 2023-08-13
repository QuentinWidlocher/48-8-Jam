class_name MeleeWeapon
extends Weapon

@export var damage: float
@export var durability: float
@export var duration: float

var current_timer: float = 0.0
var current_durability: float = durability

func _ready():
  current_durability = durability
  get_node("CollisionShape2D").disabled = true

func _on_enter():
  if animation_player != null:
    animation_player.speed_scale = 1.0 / duration
    animation_player.play("melee_attack")

  if audio_player != null:
    audio_player.stream = SOUNDS[randi() % SOUNDS.size()]
    audio_player.play()

  get_node("CollisionShape2D").disabled = false

  print(current_durability, " / ", durability)

func _on_exit() -> bool:
  animation_player.play("RESET")
  current_timer = 0.0
  current_durability -= 1

  get_node("CollisionShape2D").disabled = true

  return current_durability <= 0

func _update(delta:float) -> bool:
  current_timer += delta

  return current_timer >= duration
