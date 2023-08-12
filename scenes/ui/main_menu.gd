extends Control

@onready var level_manager: LevelManager = get_node("/root/LevelManager")

func _on_play_button_pressed():
	level_manager.load_level(0)

func _on_exit_button_pressed():
	get_tree().quit()
