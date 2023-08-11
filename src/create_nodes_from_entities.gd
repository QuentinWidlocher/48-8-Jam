static func post_import(entity_layer: Node2D) -> Node2D:
	var player := preload("res://scenes/player/player.tscn")

	var data: Array = entity_layer.get_meta("LDtk_entity_instances")
	var label_settings := LabelSettings.new()
	label_settings.font_size = 8
	label_settings.line_spacing = 0

	for entity_data in data:
		var node: Node2D
		var entity_size := Vector2(entity_data.width, entity_data.height)
		var entity_extents := entity_size * 0.5

		match entity_data.identifier:
			"Player":
				node = player.instantiate()
			_:
				node = Node2D.new()

		var pivot = entity_data.pivot
		node.name = entity_data.identifier
		node.position = entity_data.px
		node.position += entity_extents
		node.position -= entity_size * pivot
		node.set_meta("entity_data", entity_data)
		entity_layer.add_child(node)

	return entity_layer
