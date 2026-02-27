extends StaticBody3D
# If your collision nodes are Area3D instead, tell me and I’ll adjust.


func interact() -> void:
	get_parent().front = true
	get_parent()._start_monitoring()
