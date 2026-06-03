extends Button

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Pause"):
		get_parent().hide
		$"..".hide
		$"../../ChangeMenuSFX".play()

func _on_mouse_entered() -> void:
	pass

func _on_mouse_exited() -> void:
	pass

func _on_pressed() -> void:
	$"..".hide()
	$"../../ChangeMenuSFX".play()
