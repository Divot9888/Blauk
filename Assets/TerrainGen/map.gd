extends GridMap

const max_height = 32
var chunks = [] 

func _ready() -> void:
	$"../Player".position = Vector3i(randi_range(0, 64), 48, randi_range(0, 64))
	for x in range(0, 8):
		for z in range(0, 8):
			generate_chunk(x, z)
			$"../Player".position.y = 48
			await get_tree().process_frame

func generate_chunk(cx: int, cz: int) -> void:
	chunks.append("%d.%d"%[cx, cz])
	for x in range(cx*8, (cx+1)*8):
		for z in range(cz*8, (cz+1)*8):
			for y in range(0, floor(max_height / 2.0) + 1):
				set_cell(Vector3i(x, y, z))

func set_cell(p: Vector3i) -> void:
	var item := 1
	if p.y == floor(max_height / 2.0):
		item = 2
	if p.y > max_height:
		return
	if p.y < 0:
		return
	set_cell_item(p, item)
