extends CharacterBody3D

const S = 5

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("Quit"):
		get_tree().quit()
	
	if Input.is_action_pressed("Upwards"):
		velocity.y = S
	elif Input.is_action_pressed("Downwards"):
		velocity.y = -S
	else:
		velocity.y = 0
	
	var input_dir := Input.get_vector("Leftward", "Rightward", "Forward", "Backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * S
		velocity.z = direction.z * S
	else:
		velocity.x = move_toward(velocity.x, 0, S)
		velocity.z = move_toward(velocity.z, 0, S)
	
	move_and_slide()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		$Camera.rotation_degrees.x -= event.relative.y
		rotation_degrees.y -= event.relative.x
