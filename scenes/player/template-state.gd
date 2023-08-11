class_name NameState extends State

func _on_enter() -> void:
  name = "NameState"

func _on_exit() -> void:
  pass

func _update(_delta: float) -> State:
  return self
