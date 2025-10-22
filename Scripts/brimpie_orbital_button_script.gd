extends TextureButton


func _on_pressed() -> void:
	$"../AbandonedShipButton".set_pressed(false)
	$"../AvalonSystemButton".set_pressed(false)
	$"../Are You Sure? BRIM".show()
	$"../Destination".set_text("Brimpie Orbital")
