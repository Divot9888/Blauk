extends CharacterBody3D

const S = 5

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("Quit"):
		get_tree().quit()
	
	if !(is_on_floor()):
		velocity += get_gravity() * delta
	
	if Input.is_action_pressed("Upwards"):
		velocity.y = S
	
	var input_dir := Input.get_vector("Leftward", "Rightward", "Forward", "Backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * S
		velocity.z = direction.z * S
	else:
		velocity.x = move_toward(velocity.x, 0, S)
		velocity.z = move_toward(velocity.z, 0, S)
	
	move_and_slide()
	## done :D
	if Input.is_action_just_pressed("mine"):
		var point = $Camera/Ray.get_collision_point()
		var origin = $Camera/Ray.global_transform.origin
		var dir = (point - origin).normalized()
		var goal = point + dir * 0.01
		$"../Map".set_cell_item(goal, -1)
	if Input.is_action_just_pressed("place"):
		var point = $Camera/Ray.get_collision_point()
		var origin = $Camera/Ray.global_transform.origin
		var dir = (point - origin).normalized()
		var goal = point - dir * 0.01
		var cx = int(goal.x/8.0)
		var cz = int(goal.z/8.0)
		if ($"../Map".chunks).has("%d.%d"%[cx, cz]):
			$"../Map".set_cell(goal)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		$Camera.rotation_degrees.x = clamp($Camera.rotation_degrees.x - event.relative.y, -90, 90)
		rotation_degrees.y -= event.relative.x
