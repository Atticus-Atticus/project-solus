extends Button

func _on_mouse_entered() -> void:
	$".".set_text("> Resume Program <")

func _on_mouse_exited() -> void:
	$".".set_text("Resume Program")

func _on_pressed() -> void:
	$"../../..".hide()
	Engine.time_scale = 1
	$"../../../DatabasePanel".hide()
	$"../../../LorePanel1".hide()
	$"../../../LorePanel2".hide()
	$"../../../LorePanel3".hide()
	$"../../../LorePanel4".hide()
	$"../../../LorePanel5".hide()
	$"../../../LorePanel6".hide()
	$"../../../LorePanel7".hide()
	$"../../../LorePanel8".hide()
	$"../../../ChangeMenuSFX".play()
	Globals.paused = false
	
