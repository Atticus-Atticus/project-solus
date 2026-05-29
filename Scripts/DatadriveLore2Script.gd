extends StaticBody3D

@export var interactable = StaticBody3D

func _ready() -> void:
	if Globals.lore2 == 1:
		$Datadrive.queue_free()
		$OmniLight3D.hide()
		interactable._remove()

func interact():
	Globals.lore2 = 1
	print("Datadrive found!")
	#$CollisionShape3D.set_visible(false)
	$Datadrive.hide()
	$OmniLight3D.hide()
	$AudioStreamPlayer3D.play()
	interactable._remove()
