@tool

static func run_post_import(
		element,
		script_path: String,
		source_file: String,
		name: String,
    ldtk_data: Dictionary = {},
	) -> Variant:

	var _class_name :String = element.get_class()

	if not script_path.is_empty():
		var script: GDScript = load(script_path)

		if not script or not script is GDScript:
			printerr("Post import script is not a GDScript.")
			return ERR_INVALID_PARAMETER

		element = script.post_import(element, ldtk_data)
		if element == null or element.get_class() != _class_name:
			printerr("[" + name + "]" +"Invalid scene returned from post import script.")
			return ERR_INVALID_DATA

	return element
