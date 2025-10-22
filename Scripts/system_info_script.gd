extends Button

func _on_mouse_entered() -> void:
	$".".set_text("> More Info <")


func _on_mouse_exited() -> void:
	$".".set_text("  More Info  ")


func _on_pressed() -> void:
	$SystemInfoPage.show()
	$"../ChangeMenuSFX".play()
