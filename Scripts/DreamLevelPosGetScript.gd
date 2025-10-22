extends Area3D


func _on_area_entered(area: Area3D) -> void:
	$"../Player"/CharacterBody3D.get_player_pos2()
	print("this is working.")
	$CollisionShape3D.queue_free()
