extends Button

func _on_mouse_entered() -> void:
	$".".set_text("> No <")

func _on_mouse_exited() -> void:
	$".".set_text("  No  ")

func _on_pressed() -> void:
	$"..".hide()
	$"../../AvalonSystemButton".set_pressed(false)
	$"../../AbandonedShipButton".set_pressed(false)
	$"../../BrimpieOrbitalButton".set_pressed(false)
	$"../../Destination".set_text("None")
