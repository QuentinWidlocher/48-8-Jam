class_name State
extends Node

var player: Player
	
func _init(the_player : Player):
	player = the_player

# DO NOT IMPLEMENT
func on_enter() -> void:
	_on_enter()

func _on_enter() -> void:
	pass

# DO NOT IMPLEMENT
func on_exit() -> void:
	_on_exit()

func _on_exit() -> void:
	pass

# DO NOT IMPLEMENT
func update(_delta: float) -> State:
	var collision_state = player.handle_common_collision()
	if collision_state != null:
		return collision_state

	return _update(_delta)

func _update(_delta: float) -> State:
	return self
