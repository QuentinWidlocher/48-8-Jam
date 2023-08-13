static func post_import(entity_layer: Node2D, layer_data: Dictionary) -> Node2D:
  var player := preload("res://scenes/player/player.tscn")
  var dispenser := preload("res://scenes/dispenser.tscn")
  var source := preload("res://scenes/source.tscn")

  var level_width := int(layer_data["__cWid"])
  var level_height := int(layer_data["__cHei"])
  var tile_width := int(layer_data["__gridSize"])

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
        var camera: Camera2D = Camera2D.new()
        
        camera.position_smoothing_enabled = true
        camera.limit_left = 0
        camera.limit_top = 0 
        camera.limit_right = level_width * tile_width
        camera.limit_bottom = level_height * tile_width

        node.add_child(camera)

      "Dispenser":
        var disp: Dispenser = dispenser.instantiate()  
        disp.type = Dispenser.parse_enum(entity_data.fields["DispenserType"])
        disp.name = entity_data.fields["DispenserType"] + disp.name
        disp.get_node("Sprite2D").set_z_index(1)

        node = disp

      "Source":
        var src: Source = source.instantiate()
        src.spawn_timer = float(entity_data.fields["SpawnTimer"])
        src.initial_mob_spawned = int(entity_data.fields["InitialMobsSpawned"])

        node = src

      _:
        node = Node2D.new()

    var pivot = entity_data.pivot
    node.name = entity_data.identifier
    node.position = entity_data.px
    node.position += entity_extents
    node.position -= entity_size * pivot
    node.set_meta("entity_data", entity_data)
    entity_layer.add_child(node)

  entity_layer.add_child(preload("res://scenes/ui/ui.tscn").instantiate())

  return entity_layer
