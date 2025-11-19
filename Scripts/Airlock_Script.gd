extends StaticBody3D

var SuppliesFound = randi() % 30 + 1

func interact():
	Globals.PlayerSupplies += SuppliesFound
	Globals.supplies2 += 1
	print(SuppliesFound, " Supplies found!")
	#$OmniLight3D.hide()
	$"../AnimatedSprite3D17".hide()
	#$CollisionShape3D.set_visible(false)
	await get_tree().create_timer(2.5).timeout
	$CollisionShape3D.queue_free()
	$"../AudioStreamPlayer3D".play()
	Globals.CamText = "Search the station for any supplies. " + str(Globals.supplies2) + "/3"
	Globals.PlayerControls = true
