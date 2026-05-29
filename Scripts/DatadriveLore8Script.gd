extends StaticBody3D

@export var interactable = StaticBody3D

func interact():
	Globals.lore10 = 1
	print("Datadrive found!")
	#$CollisionShape3D.set_visible(false)
	$Datadrive.hide()
	$OmniLight3D.hide()
	$AudioStreamPlayer3D.play()
	interactable._remove()
