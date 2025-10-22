extends Button

func _on_mouse_entered() -> void:
	$".".set_text("> Config Program <")

func _on_mouse_exited() -> void:
	$".".set_text("Config Program")
