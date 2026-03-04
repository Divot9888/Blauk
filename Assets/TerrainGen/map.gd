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

func load_map(arr: Array):
	var i = 0
	for block in arr:
		i += 1
		var parts = block.split(".")
		if parts.size() != 4:
			return
		var type = int(parts[0])
		var pos = Vector3i(int(parts[1]), int(parts[2]), int(parts[3]))
		if type == -1:
			set_cell_item(pos, -1)
		else:
			set_cell(pos)
		if i >= 64:
			await get_tree().process_frame
			i = 0

func save_map() -> Array:
	var blocks = []
	for chunk in chunks:
		var chunkpos = chunk.split(".")
		for x in range(int(chunkpos[0])*8, (int(chunkpos[0])+1)*8):
			for y in max_height:
				for z in range(int(chunkpos[1])*8, (int(chunkpos[1])+1)*8):
					var pos = Vector3i(x, y, z)
					var type = get_cell_item(Vector3i())
					blocks.append("%d.%d.%d.%d"%[type, pos.x, pos.y, pos.z])
		await get_tree().process_frame
	return blocks
