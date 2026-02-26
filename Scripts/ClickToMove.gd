extends CharacterBody3D

@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var nav_agent: NavigationAgent3D = $NavigationAgent3D

@export var speed: float = 2.5
@export var ray_length: float = 10000.0

@export var turn_speed := 8.0      # higher = faster rotation
@export var arrive_dist := 1    # how close counts as "reached"

var holding_click := false
var ep = null

var _auto_move := false

func _physics_process(delta: float) -> void:
	# If controls are OFF and we're NOT in an auto-move sequence, fully stop.
	if not Globals.PlayerControls and not _auto_move:
		velocity = Vector3.ZERO
		return

	if nav_agent.is_target_reached():
		velocity = Vector3.ZERO
		return

	# Only allow "hold click updates destination" when player controls are enabled
	if Globals.PlayerControls and holding_click and Input.get_last_mouse_velocity().length() > 0.0:
		_update_target_from_mouse()

	move_to_point(delta)
	

func _input(event: InputEvent) -> void:
	if not Globals.PlayerControls:
		holding_click = false
		# Optional: stop any existing click-to-move path
		nav_agent.target_position = global_position
		return

	if event.is_action_pressed("LMB"):
		holding_click = true
		_try_interact_under_mouse()
		_update_target_from_mouse()
	elif event.is_action_released("LMB"):
		holding_click = false

func move_to_point(delta: float) -> void:
	var target_pos: Vector3 = nav_agent.get_next_path_position()
	var direction: Vector3 = global_position.direction_to(target_pos)

	# Face where we're going (works for both click-to-move and auto-move)
	face_direction(target_pos)

	velocity = direction * speed
	move_and_slide()

func face_direction(target: Vector3) -> void:
	look_at(Vector3(target.x, global_position.y, target.z), Vector3.UP)

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
		hit_object.interact()

func _update_target_from_mouse() -> void:
	var result := _get_mouse_raycast()
	if result.is_empty():
		return

	var hit_pos: Vector3 = result["position"]
	nav_agent.target_position = hit_pos


# =========================
# Door sequence
# =========================
func _move_through_door() -> void:
	Globals.PlayerControls = false
	_auto_move = true
	holding_click = false

	# Cancel any click-to-move path cleanly
	nav_agent.target_position = global_position
	velocity = Vector3.ZERO
	await get_tree().physics_frame

	# Move to ep
	nav_agent.target_position = ep
	await _wait_until_reached(ep)

	ep = null
	_auto_move = false
	Globals.PlayerControls = true

#this function is unused
#func _face_position(target_pos: Vector3) -> void:
	#var dir := target_pos - global_position
	#dir.y = 0.0
	#if dir.length() < 0.001:
		#return
	#var target_yaw := atan2(-dir.x, -dir.z)
	#while abs(angle_difference(rotation.y, target_yaw)) > 0.02:
		#rotation.y = lerp_angle(rotation.y, target_yaw, turn_speed * get_process_delta_time())
		#await get_tree().process_frame
#this function is unused


func _wait_until_reached(target_pos: Vector3) -> void:
	while true:
		if global_position.distance_to(target_pos) <= arrive_dist:
			break
		if nav_agent.is_target_reached():
			break
		if nav_agent.is_navigation_finished():
			break

		await get_tree().physics_frame

	velocity = Vector3.ZERO
	nav_agent.target_position = global_position
