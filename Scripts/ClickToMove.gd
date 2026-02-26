extends CharacterBody3D

@onready var nav_agent: NavigationAgent3D = $NavigationAgent3D
@export var speed: float = 2.5
@export var ray_length: float = 10000.0

var holding_click := false

func _process(delta: float) -> void:
	if not Globals.PlayerControls:
		velocity = Vector3.ZERO
		return

	if nav_agent.is_target_reached():
		velocity = Vector3.ZERO
		return

	if holding_click and Input.get_last_mouse_velocity().length() > 0.0:
		_update_target_from_mouse()

	move_to_point(delta)

func _input(event: InputEvent) -> void:
	if not Globals.PlayerControls:
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
		hit_object.call("interact")

func _update_target_from_mouse() -> void:
	var result := _get_mouse_raycast()
	if result.is_empty():
		return

	var hit_pos: Vector3 = result["position"]
	nav_agent.target_position = hit_pos
