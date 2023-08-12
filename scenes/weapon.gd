class_name Weapon
extends Node

func _init():
	push_error("you should never instantiate a weapon directly")

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
