extends RayCast3D


func _process(delta: float):
	if is_colliding():
		var hitobj = get_collider()
		if hitobj.has_method("interact") && Input.is_action_just_pressed("LMB"):
			hitobj.interact()
