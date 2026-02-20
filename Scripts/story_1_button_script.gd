extends Button

func _on_mouse_entered() -> void:
	$".".set_text(">> Subject 1: Calihan Lonan <<")

func _on_mouse_exited() -> void:
	$".".set_text("> Subject 1: Calihan Lonan <")

func _on_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/DreamCutscene1.tscn")
