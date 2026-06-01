extends Button

func _on_mouse_entered() -> void:
	$".".set_text("> Click here to shut down terminal <")

func _on_mouse_exited() -> void:
	$".".set_text("Click here to shut down terminal")

func _on_pressed() -> void:
	$"../../../ChangeMenuSFX".play()
	Globals.PlayerControls = true
	get_tree().change_scene_to_file("res://Scenes/Levels/Calihan_Ship.tscn")
