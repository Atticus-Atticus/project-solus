extends StaticBody3D

func _ready() -> void:
	if Globals.lore2 == 1:
		$CollisionShape3D.queue_free()
		$OmniLight3D.hide()

func interact():
	Globals.lore2 = 1
	print("Datadrive found!")
	#$CollisionShape3D.set_visible(false)
	$CollisionShape3D.queue_free()
	$OmniLight3D.hide()
	$"../AudioStreamPlayer3D".play()
