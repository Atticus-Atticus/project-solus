extends CharacterBody3D
class_name PlayerController

# -------------------------
# TANK CONTROLS
# -------------------------
@export var tank_move_speed: float = 2.5
@export var tank_rotation_speed: float = 3.5
@export var tank_gravity: float = 9.8

# -------------------------
# MOUSE DIRECTIONAL
# -------------------------
@export var mouse_move_speed: float = 2.5
@export var mouse_decel: float = 10.0
@export var mouse_rotation_speed: float = 3.5
@export var ground_height_offset: float = 0.0

# How long to ignore the mouse after a camera change
@export var camera_change_lock_time: float = 0.5

var _last_forward: Vector3 = Vector3.FORWARD
var _current_cam: Camera3D = null
var _cam_lock_time_left: float = 0.0

@export var playerPOS = 0

@onready var anim_tree = $Body/blockbench_export2/AnimationTree

func _ready() -> void:
	_current_cam = get_viewport().get_camera_3d()
	_last_forward = -global_transform.basis.z


func _physics_process(delta: float) -> void:
	_update_camera_lock(delta)

	if Globals.InputType:
		_mouse_directional_physics(delta)
	else:
		_tank_physics(delta)


# -------------------------
# CAMERA CHANGE LOCK + EARLY UNLOCK
# -------------------------
func _update_camera_lock(delta: float) -> void:
	var cam := get_viewport().get_camera_3d()

	if cam != _current_cam:
		_current_cam = cam
		_cam_lock_time_left = camera_change_lock_time
		_last_forward = -global_transform.basis.z  # keep current facing

	if _cam_lock_time_left > 0.0:
		var holding_movement := (
			Input.is_action_pressed("Forward") or 
			Input.is_action_pressed("Backward")
		)

		# Early unlock if W/S is released
		if not holding_movement:
			_cam_lock_time_left = 0.0
		else:
			_cam_lock_time_left -= delta
			if _cam_lock_time_left < 0.0:
				_cam_lock_time_left = 0.0


# -------------------------
# TANK CONTROLS
# -------------------------
func _tank_physics(delta: float) -> void:
	var input_dir := Vector2.ZERO

	if Input.is_action_pressed("Backward"):
		input_dir.y -= 1.0
	if Input.is_action_pressed("Forward"):
		input_dir.y += 1.0
	if Input.is_action_pressed("Right"):
		input_dir.x -= 1.0
	if Input.is_action_pressed("Left"):
		input_dir.x += 1.0

	rotation.y += input_dir.x * tank_rotation_speed * delta

	var forward: Vector3 = -transform.basis.z
	var move_dir: Vector3 = forward * input_dir.y

	if not is_on_floor():
		velocity.y -= tank_gravity * delta
	else:
		velocity.y = 0.0

	velocity.x = move_dir.x * tank_move_speed
	velocity.z = move_dir.z * tank_move_speed

	move_and_slide()


# -------------------------
# MOUSE DIRECTIONAL
# -------------------------
func _mouse_directional_physics(delta: float) -> void:
	var cam := _current_cam

	# Only update _last_forward if NOT locked
	if cam and _cam_lock_time_left == 0.0:
		var mp := get_viewport().get_mouse_position()
		var from: Vector3 = cam.project_ray_origin(mp)
		var dir: Vector3 = cam.project_ray_normal(mp)

		var plane_y := global_transform.origin.y + ground_height_offset
		if absf(dir.y) > 0.0001:
			var t := (plane_y - from.y) / dir.y
			if t > 0.0:
				var to: Vector3 = from + dir * t
				var f: Vector3 = to - global_transform.origin
				f.y = 0.0
				if f.length() > 0.1:
					_last_forward = f.normalized()

	var target_yaw := atan2(-_last_forward.x, -_last_forward.z)
	rotation.y = lerp_angle(rotation.y, target_yaw, mouse_rotation_speed * delta)

	var forward_input := 0.0
	if Input.is_action_pressed("Forward"):
		forward_input += 1.0
	if Input.is_action_pressed("Backward"):
		forward_input -= 1.0

	if absf(forward_input) > 0.0:
		var facing := -global_transform.basis.z
		facing.y = 0.0
		var move_vec := facing.normalized() * (forward_input * mouse_move_speed)
		velocity.x = move_vec.x
		velocity.z = move_vec.z
	else:
		velocity.x = move_toward(velocity.x, 0.0, mouse_decel * delta)
		velocity.z = move_toward(velocity.z, 0.0, mouse_decel * delta)

	if not is_on_floor():
		velocity += get_gravity() * delta

	move_and_slide()


func _process(delta: float) -> void:
	playerPOS = global_position
	
	var speed = velocity.length()
	anim_tree.set("parameters/MovementBlend/blend_position", speed)

func get_player_pos():
	SceneSwitcher.PlayerSpawn = playerPOS
	#sace the player position to global variable

func get_player_pos2():
	Globals.HallwayPos = playerPOS
	#same as function above
	#pos2 is now unused
