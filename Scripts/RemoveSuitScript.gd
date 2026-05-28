extends Area3D


func _on_body_entered(body):
	if body is CharacterBody3D and Globals.Suit == false:
		$"../Fumble".play()
		$"../NavigationRegion3D/Clutter/CollisionShape3D NOSUIT/DeadSpacesuit".hide()
		$"../NavigationRegion3D/Clutter/CollisionShape3D NOSUIT/OmniLight3D".hide()
		Globals.Suit = true
		print("trigger 2 working")
