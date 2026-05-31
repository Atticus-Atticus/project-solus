extends StaticBody3D

@export var interactable = StaticBody3D

func interact():
	Globals.lore9 = 1
	print("Datadrive found!")
	#$CollisionShape3D.set_visible(false)
	await get_tree().create_timer(2.5).timeout
	$Datadrive.hide()
	$OmniLight3D.hide()
	$AudioStreamPlayer3D.play()
	interactable._remove()
