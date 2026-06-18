extends Button

func _on_mouse_entered() -> void:
	$".".set_text(">> Return to Menu <<")

func _on_mouse_exited() -> void:
	$".".set_text("> Return to Menu <")

func _on_pressed() -> void:
	Globals._restart()
	get_tree().change_scene_to_file("res://Scenes/User Interface/Menus/MainMenu.tscn")
