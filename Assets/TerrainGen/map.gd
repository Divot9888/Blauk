extends GridMap

func _ready() -> void:
	generate_chunk(0, 0)

func generate_chunk(cx: int, cz: int) -> void:
	for x in range(cx*8, (cx+1)*8):
		for z in range(cz*8, (cz+1)*8):
			for y in range(32):
				set_cell_item(Vector3i(x, y, z), 0)
