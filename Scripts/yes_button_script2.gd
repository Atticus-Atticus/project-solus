extends Button

func _on_mouse_entered() -> void:
	$".".set_text("> Yes <")

func _on_mouse_exited() -> void:
	$".".set_text("  Yes  ")

func _on_pressed() -> void:
	Globals.Destination = 1
	SceneSwitcher.Destination = 1
	Globals.ShipMenu = false
