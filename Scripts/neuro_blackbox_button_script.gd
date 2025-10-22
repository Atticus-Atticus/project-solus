extends Button


func _on_mouse_entered() -> void:
	$".".set_text("> Neurological Blackboxes <")

func _on_mouse_exited() -> void:
	$".".set_text("Neurological Blackboxes")

func _on_pressed() -> void:
	$"../../../../LorePanel0".show()
	$"../../../../LorePanel1".hide()
	$"../../../../LorePanel2".hide()
	$"../../../../LorePanel3".hide()
	$"../../../../LorePanel4".hide()
	$"../../../../LorePanel5".hide()
	$"../../../../LorePanel6".hide()
	$"../../../../LorePanel7".hide()
	$"../../../../LorePanel8".hide()
	$"../../../../LorePanel9".hide()
	$"../../../../LorePanel10".hide()
	$"../../../../ChangeMenuSFX".play()
