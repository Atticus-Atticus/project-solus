extends CharacterBody3D
class_name PlayerController

# -------------------------
# TANK CONTROLS
# -------------------------
@export var tank_move_speed: float = 2.5
@export var tank_rotation_speed: float = 3.5
@export var tank_quick_turn_speed: float = 8.0
@export var tank_gravity: float = 9.8

# -------------------------
# MOUSE DIRECTIONAL
# -------------------------
@export var mouse_move_speed: float = 2.5
@export var mouse_decel: float = 10.0
@export var mouse_rotation_speed: float = 3.5
@export var ground_height_offset: float = 0.0

# How long to ignore the mouse after a camera change (for mouse directional mode)
@export var camera_change_lock_time: float = 0.5

# -------------------------
# CAMERA-RELATIVE MOVEMENT
# -------------------------
@export var camrel_speed: float = 2.6
@export var camrel_accel: float = 12.0 
@export var camrel_decel: float = 14.0
@export var camrel_stabilize_speed: float = 10.0
@export var camrel_lock_time: float = 0.25
@export var camrel_invert_forward: bool = true
@export var camrel_invert_right: bool = false
@export var camrel_require_release: bool = true

var basis_stable: Basis = Basis.IDENTITY
var _camrel_cam: Camera3D
var _camrel_cam_prev: Camera3D
var _camrel_locked: bool = false
var _camrel_lock_t: float = 0.0
var _camrel_lock_basis: Basis = Basis.IDENTITY

# -------------------------
# SHARED / OTHER
# -------------------------
var _last_forward: Vector3 = Vector3.FORWARD
var _current_cam: Camera3D = null
var _cam_lock_time_left: float = 0.0

@export var playerPOS := Vector3.ZERO

@onready var anim_tree: AnimationTree = $Body/blockbench_export2/AnimationTree

# quick-turn state for tank controls
var _quick_turning: bool = false
var _quick_turn_target_yaw: float = 0.0


func _ready() -> void:
	_current_cam = get_viewport().get_camera_3d()
	_last_forward = -global_transform.basis.z

	_camrel_cam = _current_cam
	_camrel_cam_prev = _camrel_cam
	if _camrel_cam:
		basis_stable = _camrel_cam.global_transform.basis.orthonormalized()
		_camrel_lock_basis = basis_stable


func _physics_process(delta: float) -> void:
	# Global movement enable/disable
	if not Globals.PlayerControls:
		velocity = Vector3.ZERO
		move_and_slide()
		return

	_update_camera_lock(delta)

	match Globals.InputType:
		1:
			_tank_physics(delta)
		2:
			_mouse_directional_physics(delta)
		3:
			_camera_relative_physics(delta)
		_:
			_tank_physics(delta) # fallback


func _process(delta: float) -> void:
	_update_camera_relative_basis(delta)

	playerPOS = global_position
	
	var speed := velocity.length()
	anim_tree.set("parameters/MovementBlend/blend_position", speed)


# -------------------------
# CAMERA CHANGE LOCK (Mouse directional mode) + EARLY UNLOCK
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
# CAMERA-RELATIVE BASIS UPDATE (smoothing camera changes)
# -------------------------
func _update_camera_relative_basis(delta: float) -> void:
	var current := get_viewport().get_camera_3d()
	if current:
		if current != _camrel_cam_prev:
			_camrel_cam_prev = current
			_camrel_cam = current
			_camrel_locked = true
			_camrel_lock_t = 0.0
			_camrel_lock_basis = basis_stable
		else:
			_camrel_cam = current

		var target_basis: Basis = _camrel_cam.global_transform.basis.orthonormalized()
		basis_stable = basis_stable.slerp(
			target_basis,
			clamp(delta * camrel_stabilize_speed, 0.0, 1.0)
		)


# -------------------------
# helper for angle difference
# -------------------------
func _angle_diff(a: float, b: float) -> float:
	return absf(wrapf(a - b, -PI, PI))


# -------------------------
# TANK CONTROLS (Backward = smooth quick turn)
# -------------------------
func _tank_physics(delta: float) -> void:
	# If we're currently in a quick-turn, rotate toward the target and block normal input
	if _quick_turning:
		var diff := _angle_diff(rotation.y, _quick_turn_target_yaw)

		rotation.y = lerp_angle(
			rotation.y,
			_quick_turn_target_yaw,
			tank_quick_turn_speed * delta
		)

		# close enough -> snap and finish
		if diff < 0.02:
			rotation.y = _quick_turn_target_yaw
			_quick_turning = false

		# no horizontal movement during quick turn, just gravity
		if not is_on_floor():
			velocity.y -= tank_gravity * delta
		else:
			velocity.y = 0.0

		velocity.x = 0.0
		velocity.z = 0.0

		move_and_slide()
		return

	var input_dir := Vector2.ZERO

	# Forward only moves forward now
	if Input.is_action_pressed("Forward"):
		input_dir.y += 1.0
	# Left / Right still rotate
	if Input.is_action_pressed("Right"):
		input_dir.x -= 1.0
	if Input.is_action_pressed("Left"):
		input_dir.x += 1.0

	# Backward is now a smooth quick-turn button (no backward walking)
	if Input.is_action_just_pressed("Backward"):
		_quick_turn_target_yaw = rotation.y + PI
		_quick_turning = true
		return

	# Normal tank rotation
	rotation.y += input_dir.x * tank_rotation_speed * delta

	# Move forward in facing direction
	var forward: Vector3 = -transform.basis.z
	forward.y = 0.0
	forward = forward.normalized()
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


# -------------------------
# CAMERA-RELATIVE MOVEMENT
# -------------------------
func _camera_relative_physics(delta: float) -> void:
	if _camrel_cam == null:
		return

	var ix: float = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	var iy: float = Input.get_action_strength("Forward") - Input.get_action_strength("Backward")
	var input_vec := Vector2(ix, iy)
	if input_vec.length() > 1.0:
		input_vec = input_vec.normalized()
	var moving := input_vec.length() > 0.01

	# sticky mapping / require-release logic
	if _camrel_locked:
		_camrel_lock_t += delta
		if camrel_require_release:
			# stay locked while the player is still holding movement after a camera change
			if not moving: 
				_camrel_locked = false
		else:
			# time-based unlock
			if _camrel_lock_t > camrel_lock_time or not moving:
				_camrel_locked = false

	var use_basis: Basis = _camrel_lock_basis if _camrel_locked else basis_stable

	var fwd: Vector3 = -use_basis.z if camrel_invert_forward else use_basis.z
	var right: Vector3 = -use_basis.x if camrel_invert_right else use_basis.x
	fwd.y = 0.0
	right.y = 0.0
	fwd = fwd.normalized()
	right = right.normalized()

	var move_dir: Vector3 = right * input_vec.x + fwd * input_vec.y

	# acceleration / deceleration for smoother feel
	var target_vx := move_dir.x * camrel_speed
	var target_vz := move_dir.z * camrel_speed
	var ramp := camrel_accel if moving else camrel_decel
	velocity.x = move_toward(velocity.x, target_vx, ramp * delta)
	velocity.z = move_toward(velocity.z, target_vz, ramp * delta)

	# face movement when actually moving
	if moving and move_dir.length() > 0.001:
		var yaw := atan2(-move_dir.x, -move_dir.z)
		rotation.y = lerp_angle(rotation.y, yaw, delta * 10.0)

	# Gravity (same style as mouse directional)
	if not is_on_floor():
		velocity += get_gravity() * delta

	move_and_slide()


# -------------------------
# POSITION HELPERS
# -------------------------
func get_player_pos():
	SceneSwitcher.PlayerSpawn = playerPOS

func get_player_pos2():
	Globals.HallwayPos = playerPOS
