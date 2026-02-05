extends Button

func _on_mouse_entered() -> void:
	$".".set_text(">> Subject 1: Calihan Lonan <<")

func _on_mouse_exited() -> void:
	$".".set_text("> Subject 1: Calihan Lonan <")

func _on_pressed() -> void:
	pass
