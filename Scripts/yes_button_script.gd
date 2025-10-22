extends Button

func _on_mouse_entered() -> void:
	$".".set_text("> Yes <")

func _on_mouse_exited() -> void:
	$".".set_text("  Yes  ")

func _on_pressed() -> void:
	Globals.StoryStage += 1
	Globals.ShipMenu = false
