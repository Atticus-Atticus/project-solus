extends StaticBody3D

@export var Interactable = StaticBody3D

var SuppliesFound = randi() % 30 + 1

func interact():
	Globals.PlayerSupplies += SuppliesFound
	Globals.supplies1 += 1
	print(SuppliesFound, " Supplies found!")
	#$OmniLight3D.hide()
	#$CollisionShape3D.set_visible(false)
	await get_tree().create_timer(2.5).timeout
	$CollisionShape3D.queue_free()
	$AudioStreamPlayer3D.play()
	Globals.CamText = "Return to your ship"
	Globals.PlayerControls = true
	Interactable._remove()
	
	#queue.free by itself makes the RayCastScript has_method die
	#no clue why
