extends CharacterBody3D

@export var nav_agent: NavigationAgent3D
@export var anim_player: AnimationPlayer
@export var anim_tree: AnimationTree
@export var max_anim_speed: float = 2.5

@export var speed: float = 2.5
@export var ray_length: float = 10000.0
@export var gravity: float = 20.0

@export var turn_speed: float = 8.0
@export var arrive_dist: float = 0.1 
@export var door_arrive_dist: float = 0.6

@export var playerPOS := Vector3.ZERO

var holding_click := false
var sp: Vector3
var ep: Vector3

var _auto_move := false
var anim_blend_value: float = 0.0

func get_player_pos():
	SceneSwitcher.PlayerSpawn = playerPOS

func get_player_pos2():
	Globals.HallwayPos = playerPOS

func _ready() -> void:
	if anim_tree != null:
		anim_tree.active = true

	_stop_movement()


func _stop_movement() -> void:
	holding_click = false
	_auto_move = false

	velocity = Vector3.ZERO

	if nav_agent != null:
		nav_agent.target_position = global_position

		# Optional but useful: force the agent to forget old pathing
		await get_tree().physics_frame
		nav_agent.target_position = global_position

func _process(delta: float) -> void:
	_update_animation(delta)
	playerPOS = global_position


func _update_animation(delta: float) -> void:
	if anim_tree == null:
		return

	var horizontal_velocity := Vector3(velocity.x, 0.0, velocity.z)
	var current_speed := horizontal_velocity.length()

	var target_blend := clampf(current_speed / max_anim_speed, 0.0, 1.0)

	anim_blend_value = lerpf(
		anim_blend_value,
		target_blend,
		1.0 - exp(-10.0 * delta)
	)

	anim_tree.set("parameters/BlendSpace1D/blend_position", anim_blend_value)


func _physics_process(delta: float) -> void:
	if nav_agent == null:
		return

	_apply_gravity(delta)

	# If controls are OFF and we're NOT in an auto-move sequence, fully stop horizontal movement.
	if not Globals.PlayerControls and not _auto_move:
		velocity.x = 0.0
		velocity.z = 0.0
		move_and_slide()
		return

	# Only allow "hold click updates destination" when player controls are enabled.
	if Globals.PlayerControls and holding_click:
		_update_target_from_mouse()

	# Stop when close enough to target.
	if global_position.distance_to(nav_agent.target_position) <= arrive_dist:
		velocity.x = 0.0
		velocity.z = 0.0
		move_and_slide()
		return

	move_to_point(delta)


func _input(event: InputEvent) -> void:
	# If controls are disabled BUT we're auto-moving, ignore input completely.
	if not Globals.PlayerControls:
		if _auto_move:
			return

		holding_click = false

		if nav_agent != null:
			nav_agent.target_position = global_position

		return

	if event.is_action_pressed("LMB"):
		holding_click = true
		_try_interact_under_mouse()
		_update_target_from_mouse()

	elif event.is_action_released("LMB"):
		holding_click = false


func _apply_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= gravity * delta
	else:
		velocity.y = 0.0


func move_to_point(delta: float) -> void:
	var target_pos: Vector3 = nav_agent.get_next_path_position()

	var direction: Vector3 = target_pos - global_position
	direction.y = 0.0

	# If the next nav point is basically underneath/above us,
	# use the final target instead.
	if direction.length() < 0.05:
		direction = nav_agent.target_position - global_position
		direction.y = 0.0

	# Only stop if there is truly no usable direction.
	# Do NOT use arrive_dist here, because this is only the next path point.
	if direction.length() < 0.05:
		velocity.x = 0.0
		velocity.z = 0.0
		move_and_slide()
		return

	direction = direction.normalized()

	face_direction(global_position + direction, delta)

	velocity.x = direction.x * speed
	velocity.z = direction.z * speed

	move_and_slide()


func face_direction(target: Vector3, delta: float) -> void:
	var look_target := Vector3(target.x, global_position.y, target.z)
	var direction := look_target - global_position

	if direction.length() < 0.05:
		return

	direction = direction.normalized()

	# + PI fixes Calihan facing backwards.
	var target_rotation := atan2(direction.x, direction.z) + PI

	rotation.y = lerp_angle(
		rotation.y,
		target_rotation,
		1.0 - exp(-turn_speed * delta)
	)


func _get_mouse_raycast() -> Dictionary:
	var cam: Camera3D = get_viewport().get_camera_3d()
	if cam == null:
		return {}

	var mouse_pos: Vector2 = get_viewport().get_mouse_position()
	var from: Vector3 = cam.project_ray_origin(mouse_pos)
	var to: Vector3 = from + cam.project_ray_normal(mouse_pos) * ray_length

	var space := get_world_3d().direct_space_state
	var query := PhysicsRayQueryParameters3D.create(from, to)

	query.exclude = [self]
	query.collide_with_bodies = true
	query.collide_with_areas = false

	return space.intersect_ray(query)


func _try_interact_under_mouse() -> void:
	var result := _get_mouse_raycast()
	if result.is_empty():
		return

	var hit_object: Object = result.get("collider")
	if hit_object != null and hit_object.has_method("interact"):
		hit_object.call("interact")


func _update_target_from_mouse() -> void:
	var result := _get_mouse_raycast()
	if result.is_empty():
		return

	var hit_pos: Vector3 = result["position"]

	var nav_map: RID = get_world_3d().navigation_map
	var closest_nav_point: Vector3 = NavigationServer3D.map_get_closest_point(nav_map, hit_pos)

	nav_agent.target_position = closest_nav_point

	#print("Raw hit: ", hit_pos)
	#print("Nav target: ", closest_nav_point)
	#print("Reachable: ", nav_agent.is_target_reachable())
	#print("Path: ", nav_agent.get_current_navigation_path())

func _move_through_door() -> void:
	Globals.PlayerControls = false
	_auto_move = true
	holding_click = false

	await get_tree().create_timer(1.5).timeout

	var nav_map: RID = get_world_3d().navigation_map
	var door_target: Vector3 = NavigationServer3D.map_get_closest_point(nav_map, ep)

	nav_agent.target_position = door_target
	await _wait_until_reached_flat(door_target, door_arrive_dist)

	velocity.x = 0.0
	velocity.z = 0.0
	move_and_slide()

	ep = Vector3.ZERO
	sp = Vector3.ZERO

	_auto_move = false
	Globals.PlayerControls = true

func _pick_up() -> void:
	Globals.PlayerControls = false
	holding_click = false

	if nav_agent != null:
		nav_agent.target_position = global_position

	velocity.x = 0.0
	velocity.z = 0.0
	move_and_slide()

	if anim_tree != null:
		anim_tree.set(
			"parameters/OneShot/request",
			AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE
		)

	await get_tree().create_timer(2.5).timeout

	Globals.PlayerControls = true

func _wait_until_reached_flat(target_pos: Vector3, distance: float) -> void:
	while true:
		var current_flat := Vector2(global_position.x, global_position.z)
		var target_flat := Vector2(target_pos.x, target_pos.z)

		if current_flat.distance_to(target_flat) <= distance:
			break

		await get_tree().process_frame
