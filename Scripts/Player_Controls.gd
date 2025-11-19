extends CharacterBody3D
class_name PlayerController

# -------------------------
# TANK CONTROLS
# -------------------------
@export var tank_move_speed: float = 2.5
@export var tank_rotation_speed: float = 2.5
@export var tank_gravity: float = 9.8

# -------------------------
# MOUSE DIRECTIONAL
# -------------------------
@export var mouse_move_speed: float = 2.5
@export var mouse_decel: float = 10.0
@export var mouse_rotation_speed: float = 7.0
@export var ground_height_offset: float = 0.0 # offset from the player's current Y if needed

var _last_forward: Vector3 = Vector3.FORWARD


func _physics_process(delta: float) -> void:
	# Toggle controls with Debug
	#if Input.is_action_just_pressed("Debug"):
		#Globals.InputType = !Globals.InputType
		#var mode_name := "Mouse Directional" if Globals.InputType else "Tank Controls"
		#print("InputType switched to: ", mode_name)

	# If Globals.InputType is false then controls
	# If Globals.InputType is true then mouse directional
	if Globals.InputType:
		_mouse_directional_physics(delta)
	else:
		_tank_physics(delta)


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

	# Rotate left/right
	rotation.y += input_dir.x * tank_rotation_speed * delta

	# Forward/backward movement in facing direction
	var forward: Vector3 = -transform.basis.z
	var move_dir: Vector3 = forward * input_dir.y

	# Gravity (tank mode uses its own gravity value)
	if not is_on_floor():
		velocity.y -= tank_gravity * delta
	else:
		velocity.y = 0.0

	# Apply movement
	velocity.x = move_dir.x * tank_move_speed
	velocity.z = move_dir.z * tank_move_speed

	move_and_slide()


# -------------------------
# MOUSE DIRECTIONAL LOGIC
# -------------------------
func _mouse_directional_physics(delta: float) -> void:
	# --- 1) Face the mouse by intersecting ray with a horizontal plane ---
	var cam: Camera3D = get_viewport().get_camera_3d()
	if cam:
		var mp: Vector2 = get_viewport().get_mouse_position()
		var from: Vector3 = cam.project_ray_origin(mp)
		var dir: Vector3 = cam.project_ray_normal(mp)

		var plane_y: float = global_transform.origin.y + ground_height_offset
		# Solve from.y + t*dir.y = plane_y => t = (plane_y - from.y) / dir.y
		if absf(dir.y) > 0.0001:
			var t: float = (plane_y - from.y) / dir.y
			if t > 0.0:
				var to: Vector3 = from + dir * t
				var f: Vector3 = to - global_transform.origin
				f.y = 0.0
				if f.length() > 0.1:
					_last_forward = f.normalized()

	# Smoothly rotate body toward _last_forward (character faces its -Z)
	var target_yaw: float = atan2(-_last_forward.x, -_last_forward.z)
	rotation.y = lerp_angle(rotation.y, target_yaw, mouse_rotation_speed * delta)

	# --- 2) W/S movement along facing ---
	var forward_input: float = 0.0
	if Input.is_action_pressed("Forward"):
		forward_input += 1.0
	if Input.is_action_pressed("Backward"):
		forward_input -= 1.0

	if absf(forward_input) > 0.0:
		var facing: Vector3 = -global_transform.basis.z
		facing.y = 0.0
		facing = facing.normalized()
		var move_vec: Vector3 = facing * (forward_input * mouse_move_speed)
		velocity.x = move_vec.x
		velocity.z = move_vec.z
	else:
		velocity.x = move_toward(velocity.x, 0.0, mouse_decel * delta)
		velocity.z = move_toward(velocity.z, 0.0, mouse_decel * delta)

	# Gravity (mouse mode uses built-in gravity helper, like your original)
	if not is_on_floor():
		velocity += get_gravity() * delta

	move_and_slide()
