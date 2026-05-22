extends CharacterBody3D

@export var move_speed: float = 2.0
@export var turn_speed: float = 3.0
@export var stopping_distance: float = 0.4
@export var random_range: float = 8.0
@export var wait_time_min: float = 1.0
@export var wait_time_max: float = 3.0

@onready var nav_agent: NavigationAgent3D = $NavigationAgent3D

var target_position: Vector3
var is_waiting: bool = false
var is_turning: bool = false


func _ready() -> void:
	randomize()
	nav_agent.target_desired_distance = stopping_distance
	_pick_random_location()


func _physics_process(delta: float) -> void:
	if is_waiting:
		velocity = Vector3.ZERO
		move_and_slide()
		return

	if nav_agent.is_navigation_finished():
		velocity = Vector3.ZERO
		move_and_slide()
		_wait_then_pick_new_location()
		return

	var next_path_position: Vector3 = nav_agent.get_next_path_position()
	var direction: Vector3 = next_path_position - global_position
	direction.y = 0.0

	if direction.length() < 0.05:
		velocity = Vector3.ZERO
		move_and_slide()
		return

	direction = direction.normalized()

	var facing_direction: Vector3 = -global_transform.basis.z
	facing_direction.y = 0.0
	facing_direction = facing_direction.normalized()

	var angle_to_target: float = facing_direction.signed_angle_to(direction, Vector3.UP)

	# Turn on the spot first
	if abs(angle_to_target) > 0.1:
		velocity = Vector3.ZERO
		rotate_y(clamp(angle_to_target, -turn_speed * delta, turn_speed * delta))
	else:
		# Move forward only once mostly facing the target
		velocity = -global_transform.basis.z * move_speed

	move_and_slide()


func _pick_random_location() -> void:
	var random_offset := Vector3(
		randf_range(-random_range, random_range),
		0.0,
		randf_range(-random_range, random_range)
	)

	var random_position := global_position + random_offset

	# Find nearest valid point on the navmesh
	var map_rid: RID = get_world_3d().navigation_map
	target_position = NavigationServer3D.map_get_closest_point(map_rid, random_position)

	nav_agent.target_position = target_position


func _wait_then_pick_new_location() -> void:
	if is_waiting:
		return

	is_waiting = true

	var timer_time := randf_range(wait_time_min, wait_time_max)
	await get_tree().create_timer(timer_time).timeout

	is_waiting = false
	_pick_random_location()
