extends CharacterBody2D

@export var speed: float = 500
@export var rotation_speed: float = 8.0


func _physics_process(delta: float) -> void:
	var input_dir := Vector2.ZERO

	if Input.is_action_pressed("Forward"):
		input_dir.y -= 1.0
	if Input.is_action_pressed("Backward"):
		input_dir.y += 1.0
	if Input.is_action_pressed("Left"):
		input_dir.x -= 1.0
	if Input.is_action_pressed("Right"):
		input_dir.x += 1.0

	if input_dir.length() > 1.0:
		input_dir = input_dir.normalized()

	velocity = input_dir * speed
	move_and_slide()

	if input_dir.length() > 0.01:
		rotation = lerp_angle(
			rotation,
			input_dir.angle() + PI / 2.0,
			rotation_speed * delta
		)
