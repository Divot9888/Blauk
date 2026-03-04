extends GridMap

const max_height = 32

func _ready() -> void:
	for x in range(0, 1):
		for z in range(0, 1):
			generate_chunk(x, z)

func generate_chunk(cx: int, cz: int) -> void:
	for x in range(cx*8, (cx+1)*8):
		for z in range(cz*8, (cz+1)*8):
			for y in range(floor(max_height / 2.0)):
				set_cell_item(Vector3i(x, y, z), 1)
