extends TextureButton


func _on_pressed() -> void:
	$"../BrimpieOrbitalButton".set_pressed(false)
	$"../AbandonedShipButton".set_pressed(false)
	$"../Destination".set_text("The Avalon System")
	$"../Are You Sure? Ava".show()
