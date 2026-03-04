extends GridMap

func _ready() -> void:
	generate_map()

func generate_map() -> void:
	for x in range(8):
		for z in range(8):
			for y in range(32):
				set_cell_item(Vector3i(x, y, z), 0)
