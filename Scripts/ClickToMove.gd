extends CharacterBody3D

@onready var nav_agent: NavigationAgent3D = $NavigationAgent3D

@export var speed: float = 5.0

func _process(delta: float) -> void:
	if nav_agent.is_target_reached():
		velocity = Vector3.ZERO
		return

	move_to_point(delta)

func move_to_point(delta: float) -> void:
	var target_pos: Vector3 = nav_agent.get_next_path_position()
	var direction: Vector3 = global_position.direction_to(target_pos)

	face_direction(target_pos)

	velocity = direction * speed
	move_and_slide()

func face_direction(target: Vector3) -> void:
	look_at(Vector3(target.x, global_position.y, target.z), Vector3.UP)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("LMB"):
		var cam: Camera3D = get_viewport().get_camera_3d()
		if cam == null:
			return

		var mouse_pos: Vector2 = get_viewport().get_mouse_position()
		var ray_length: float = 10000.0
		var from: Vector3 = cam.project_ray_origin(mouse_pos)
		var to: Vector3 = from + cam.project_ray_normal(mouse_pos) * ray_length

		var space := get_world_3d().direct_space_state
		var query := PhysicsRayQueryParameters3D.create(from, to)

		# IMPORTANT: don't hit yourself (or your hitboxes/areas)
		query.exclude = [self]  # if this complains, use: [get_rid()]

		# Usually floors/walls are bodies, not areas. Turn areas off unless needed.
		query.collide_with_bodies = true
		query.collide_with_areas = false

		# OPTIONAL but recommended: only raycast against "walkable" layers
		# query.collision_mask = 1 << 0   # example: layer 1

		var result: Dictionary = space.intersect_ray(query)

		if result.is_empty():
			return  # clicked empty space -> do nothing

		var hit_pos: Vector3 = result["position"]
		nav_agent.target_position = hit_pos
