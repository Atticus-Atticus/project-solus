extends TextureButton


func _on_pressed() -> void:
	$"../BrimpieOrbitalButton".set_pressed(false)
	$"../AvalonSystemButton".set_pressed(false)
	$"../Are You Sure? ABSHIP".show()
	$"../Destination".set_text("Abandoned Ship")
