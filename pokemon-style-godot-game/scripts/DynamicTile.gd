@tool
extends Node3D

@export_enum("Dirt", "Grass", "Sand", "Stone", "Water")
var tile_type: String = "Grass":
	set(value):
		tile_type = value
		load_model()

func _ready():
	load_model()

func load_model():
	# Clear existing children
	for child in get_children():
		child.queue_free()

	var model_paths = {
		"Dirt": "res://scenes/tiles/dirt_tile.tscn",
		"Grass": "res://scenes/tiles/grass_tile.tscn",
		"Sand": "res://scenes/tiles/sand_tile.tscn",
		"Stone": "res://scenes/tiles/stone_tile.tscn",
		"Water": "res://scenes/tiles/water_tile.tscn"
	}

	var model_path = model_paths.get(tile_type, null)
	if model_path:
		var scene = load(model_path)
		if scene:
			var model = scene.instantiate()
			add_child(model)
		else:
			push_error("❌ Failed to load scene: " + model_path)
	else:
		push_error("❌ Invalid tile type: " + tile_type)
