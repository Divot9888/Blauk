extends Camera3D

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("Quit"):
		get_tree().quit()
	if Input.is_action_pressed("Forward"):
		position.z -= 1
	if Input.is_action_pressed("Backward"):
		position.z += 1
	if Input.is_action_pressed("Leftward"):
		position.x -= 1
	if Input.is_action_pressed("Rightward"):
		position.x += 1

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotation_degrees.x -= event.relative.y
		rotation_degrees.y -= event.relative.x
