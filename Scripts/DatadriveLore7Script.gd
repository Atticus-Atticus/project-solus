extends StaticBody3D


func interact():
	Globals.lore9 = 1
	print("Datadrive found!")
	#$CollisionShape3D.set_visible(false)
	$CollisionShape3D.queue_free()
	$OmniLight3D.hide()
	$"../AudioStreamPlayer3D".play()
