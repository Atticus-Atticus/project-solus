extends Camera3D

@export var ray_fire_rate: float = 0.15

var ray_timer: float = 0.0


func _process(delta: float) -> void:
	if Input.is_action_pressed("LMB"):
		ray_timer -= delta

		if ray_timer <= 0.0:
			shoot_ray()
			ray_timer = ray_fire_rate
	else:
		ray_timer = 0.0

func shoot_ray():
	var mouse_pos = get_viewport().get_mouse_position()
	var ray_length = 1000
	var from = project_ray_origin(mouse_pos)
	var to = from + project_ray_normal(mouse_pos) * ray_length

	var space = get_world_3d().direct_space_state
	var ray_query = PhysicsRayQueryParameters3D.new()
	ray_query.from = from
	ray_query.to = to

	var raycast_result = space.intersect_ray(ray_query)
	#print(raycast_result)

	if raycast_result:
		var hit_object = raycast_result["collider"]

		if hit_object and hit_object.has_method("interact"):
			hit_object.interact()
