extends Button

func _on_mouse_entered() -> void:
	$".".set_text(">> EXIT PROGRAM <<")

func _on_mouse_exited() -> void:
	$".".set_text("> EXIT PROGRAM <")

func _on_pressed() -> void:
	get_tree().quit()
