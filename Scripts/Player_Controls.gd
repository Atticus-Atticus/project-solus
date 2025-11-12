extends CharacterBody3D

@export var move_speed: float = 2.5
@export var rotation_speed: float = 2.5
@export var gravity: float = 9.8

var speed: Vector3 = Vector3.ZERO

func _physics_process(delta: float) -> void:
	var input_dir = Vector2.ZERO

	if Input.is_action_pressed("Backward"):
		input_dir.y -= 1
	if Input.is_action_pressed("Forward"):
		input_dir.y += 1
	if Input.is_action_pressed("Right"):
		input_dir.x -= 1
	if Input.is_action_pressed("Left"):
		input_dir.x += 1

	# Apply rotation (A / D)
	rotation.y += input_dir.x * rotation_speed * delta

	# Forward/backward movement in facing direction
	var forward = -transform.basis.z
	var move_dir = forward * input_dir.y

	# Gravity
	if not is_on_floor():
		velocity.y -= gravity * delta
	else:
		velocity.y = 0

	# Apply movement
	velocity.x = move_dir.x * move_speed
	velocity.z = move_dir.z * move_speed
	move_and_slide()
