static func post_import(entity_layer: Node2D, layer_data: Dictionary) -> Node2D:
  var player := preload("res://scenes/player/player.tscn")

  var level_width := int(layer_data["__cWid"])
  var level_height := int(layer_data["__cHei"])
  var tile_width := int(layer_data["__gridSize"])

  print("Level width:", level_width)
  print("Level height:", level_height)
  print("Tile width:", tile_width)

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
        var camera: Camera2D = node.get_node("Camera2D")

        camera.limit_left = 0
        camera.limit_top = 0 
        camera.limit_right = level_width * tile_width
        camera.limit_bottom = level_height * tile_width
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
