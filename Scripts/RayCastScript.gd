extends RayCast3D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	if is_colliding() and Globals.PlayerControls == true:
		var hitobj = get_collider()
		if hitobj.has_method("interact"):
			$"../InteractableLight".set_visible(true)
		if hitobj.has_method("interact") && Input.is_action_just_pressed("Interact"):
			hitobj.interact()
		if hitobj.has_method("interact") && Input.is_action_just_pressed("Interact") and hitobj.is_in_group("Supplies"):
			$"../blockbench_export2/AnimationTree".set("parameters/OneShot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
			Globals.PlayerControls = false
	else:
		$"../InteractableLight".set_visible(false)
