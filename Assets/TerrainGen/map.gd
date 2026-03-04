extends GridMap

const max_height = 32

func _ready() -> void:
	for x in range(0, 8):
		for z in range(0, 8):
			generate_chunk(x, z)
			await get_tree().process_frame

func generate_chunk(cx: int, cz: int) -> void:
	for x in range(cx*8, (cx+1)*8):
		for z in range(cz*8, (cz+1)*8):
			for y in range(0, floor(max_height / 2.0) + 1):
				set_cell(Vector3i(x, y, z))

func set_cell(p: Vector3i) -> void:
	var item := 1
	if p.y == floor(max_height / 2.0):
		item = 2
	set_cell_item(p, item)
