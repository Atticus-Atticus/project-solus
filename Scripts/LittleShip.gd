extends CharacterBody2D

@export var speed: float = 500.0
@export var acceleration: float = 250
@export var deceleration: float = 450
@export var rotation_speed: float = 8.0

@export var power_up: AudioStreamPlayer
@export var ship_move: AudioStreamPlayer
@export var power_down: AudioStreamPlayer

var control := true
var was_moving := false


func _physics_process(delta: float) -> void:
	var input_dir := Vector2.ZERO

	if control:
		if Input.is_action_pressed("Forward"):
			input_dir.y -= 1.0
		if Input.is_action_pressed("Backward"):
			input_dir.y += 1.0
		if Input.is_action_pressed("Left"):
			input_dir.x -= 1.0
		if Input.is_action_pressed("Right"):
			input_dir.x += 1.0

	if Input.is_action_just_pressed("R_Key") and control == false:
		_toggle()
		Globals.CamText = "Use the ship's controls to choose a destination"

	if Input.is_action_just_pressed("Pause"):
		_save_pos()
		get_tree().change_scene_to_file("res://Scenes/Levels/Calihan_Ship.tscn")

	if input_dir.length() > 1.0:
		input_dir = input_dir.normalized()

	var target_velocity := input_dir * speed
	var has_input := input_dir.length() > 0.01

	if has_input:
		velocity = velocity.move_toward(target_velocity, acceleration * delta)

		rotation = lerp_angle(
			rotation,
			input_dir.angle() + PI / 2.0,
			rotation_speed * delta
		)

		_handle_moving_audio()
	else:
		velocity = velocity.move_toward(Vector2.ZERO, deceleration * delta)
		_handle_decelerating_audio()

	move_and_slide()

	was_moving = velocity.length() > 5.0


func _handle_moving_audio() -> void:
	# Start ship movement loop if not already playing
	if ship_move and not ship_move.playing:
		ship_move.play()

	# Play power-up only when movement begins
	if not was_moving:
		if power_down:
			power_down.stop()

		if power_up:
			power_up.play()


func _handle_decelerating_audio() -> void:
	if velocity.length() > 5.0:
		if ship_move:
			ship_move.stop()

		if power_down and not power_down.playing:
			power_down.play()
	else:
		if ship_move:
			ship_move.stop()

		if power_down:
			power_down.stop()


func _toggle() -> void:
	control = !control


func _save_pos() -> void:
	SceneSwitcher.PlayerShipSpawn = position
