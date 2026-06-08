extends Button

func _on_mouse_entered() -> void:
	$".".set_text(">> Subject 1 - The Fool <<")

func _on_mouse_exited() -> void:
	$".".set_text("> Subject 1 - The Fool <")

func _on_pressed() -> void:
	$"../../CalihanPanel/AnimationPlayer".play("Show")
	$"../../AmyPanel".hide()
