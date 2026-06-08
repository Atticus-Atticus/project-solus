extends Button

func _on_mouse_entered() -> void:
	$".".set_text(">> Subject 2 - Temperance <<")

func _on_mouse_exited() -> void:
	$".".set_text("> Subject 2 - Temperance <")

func _on_pressed() -> void:
	$"../../AmyPanel/AnimationPlayer".play("Show")
	$"../../CalihanPanel".hide()
