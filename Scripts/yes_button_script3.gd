extends Button

func _on_mouse_entered() -> void:
	$".".set_text("> Yes <")

func _on_mouse_exited() -> void:
	$".".set_text("  Yes  ")

func _on_pressed() -> void:
	Globals.Destination = 2
	SceneSwitcher.Destination = 2
	Globals.ShipMenu = false
