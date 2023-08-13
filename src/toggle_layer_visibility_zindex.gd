static func post_import(level: Node2D, _ldtk_data: Dictionary) -> Node2D:
  var tilemap: TileMap = level.get_children().filter(func(child): return child is TileMap)[0]

  print(tilemap)

  if tilemap != null:
    for i in range(tilemap.get_layers_count()):
      var layer_name := tilemap.get_layer_name(i)

      if layer_name.ends_with("int-values"):
        tilemap.set_layer_enabled(i, false)

      if layer_name == "Darkness" or layer_name.begins_with("Wall_Top"):
        tilemap.set_layer_z_index(i, 1)

  return level
