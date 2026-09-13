extends StaticBody3D


func interact() -> void:
	get_parent()._door()
	if get_parent().interacted == false:
		get_parent().interacted = true
		await get_tree().create_timer(10).timeout
		get_parent().interacted = false
