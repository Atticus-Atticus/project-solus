extends CharacterBody2D

@export var speed: float = 500
@export var rotation_speed: float = 8.0

var control = true

func _physics_process(delta: float) -> void:
	var input_dir := Vector2.ZERO

	if Input.is_action_pressed("Forward") and control == true:
		input_dir.y -= 1.0
	if Input.is_action_pressed("Backward") and control == true:
		input_dir.y += 1.0
	if Input.is_action_pressed("Left") and control == true:
		input_dir.x -= 1.0
	if Input.is_action_pressed("Right") and control == true:
		input_dir.x += 1.0

	if Input.is_action_just_pressed("R_Key") and control == false:
		_toggle()
		#Globals.StoryStage -= 1

	if input_dir.length() > 1.0:
		input_dir = input_dir.normalized()

	velocity = input_dir * speed
	move_and_slide()

	if Input.is_action_just_pressed("Pause") and SceneSwitcher.Destination != 0:
		get_tree().change_scene_to_file("res://Scenes/Levels/Calihan_Ship.tscn")
		#Globals.StoryStage += 1
		_save_pos()

	if Input.is_action_just_pressed("Pause") and SceneSwitcher.Destination == 0:
		get_tree().change_scene_to_file("res://Scenes/Levels/Calihan_Ship.tscn")
		_save_pos()

	if input_dir.length() > 0.01:
		rotation = lerp_angle(
			rotation,
			input_dir.angle() + PI / 2.0,
			rotation_speed * delta
		)

func _toggle():
	if control == true:
		control = false
	else:
		control = true

func _save_pos():
	SceneSwitcher.PlayerShipSpawn = position
