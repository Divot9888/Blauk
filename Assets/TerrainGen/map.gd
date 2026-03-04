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
				var pos = Vector3i(x, y, z)
				if is_exposed(pos):
					set_cell(pos)

func is_exposed(pos: Vector3i) -> bool:
	for dir in [Vector3.LEFT, Vector3.RIGHT, Vector3.UP, Vector3.DOWN, Vector3.FORWARD, Vector3.BACK]:
		var neighbor = pos + dir
		var cx = int(neighbor.x/8.0)
		var cz = int(neighbor.z/8.0)
		if !chunks.has("%d.%d"%[cx, cz]) or neighbor.y > max_height or neighbor.y < 0 or get_cell_item(neighbor) == -1:
			return true
	return false

func set_cell(p: Vector3i) -> void:
	var item := 1
	if p.y == floor(max_height / 2.0):
		item = 2
	if p.y > max_height:
		return
	if p.y < 0:
		return
	set_cell_item(p, item)

func load_map(arr: Array):
	clear()
	var c = 0
	for block in arr:
		var parts = block.split(".")
		if parts.size() != 5:
			return
		var type = int(parts[0])
		var pos = Vector3i(int(parts[1]), int(parts[2]), int(parts[3]))
		if type == -1:
			set_cell_item(pos, -1)
		else:
			set_cell(pos)
		if int(parts[4]) != c:
			c = int(parts[4])
			await get_tree().process_frame

func save_map() -> Array:
	var blocks = []
	var c = 0
	for chunk in chunks:
		c += 1
		var chunkpos = chunk.split(".")
		for x in range(int(chunkpos[0])*8, (int(chunkpos[0])+1)*8):
			for y in range(max_height):
				for z in range(int(chunkpos[1])*8, (int(chunkpos[1])+1)*8):
					var pos = Vector3i(x, y, z)
					var type = get_cell_item(Vector3i(pos))
					if type != -1:
						blocks.append("%d.%d.%d.%d.%d"%[type, pos.x, pos.y, pos.z, c])
		await get_tree().process_frame
	return blocks
