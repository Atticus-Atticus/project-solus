extends StaticBody3D


func interact() -> void:
	get_parent().front = true
	get_parent()._start_monitoring()
