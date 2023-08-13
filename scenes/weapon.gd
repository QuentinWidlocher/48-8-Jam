class_name Weapon
extends Node2D

@onready var sprite: Sprite2D = $Sprite
@onready var animation_player: AnimationPlayer = $AnimationPlayer 
@onready var audio_player: AudioStreamPlayer2D = $AudioStreamPlayer2D 

const SOUNDS := [
  preload("res://sons/dispensers/woosh/SWSH_Whoosh 7 (ID 1800)_LS.wav"),
  preload("res://sons/dispensers/woosh/SWSH_Whoosh 8 (ID 1801)_LS.wav"),
  preload("res://sons/dispensers/woosh/SWSH_Whoosh 10 (ID 1798)_LS.wav"),
]

# DO NOT IMPLEMENT
func on_enter() -> void:
  _on_enter()

func _on_enter() -> void:
  pass

# DO NOT IMPLEMENT
func on_exit() -> bool: # return true if the weapon should be destroyed
  return _on_exit()

func _on_exit() -> bool:
  return false

# DO NOT IMPLEMENT
func update(delta: float) -> bool: # return true if the attack is finished
  return _update(delta)

func _update(_delta: float) -> bool:
  return true
