extends Button

func _on_mouse_entered() -> void:
	$".".set_text("> Close Console <")

func _on_mouse_exited() -> void:
	$".".set_text("  Close Console  ")

func _on_pressed() -> void:
	Globals.ShipMenu = false
