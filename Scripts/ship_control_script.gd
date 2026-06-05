extends Node3D

func _ready() -> void:
	$"CRT Shader Static".show()
	await get_tree().create_timer(0.2).timeout
	$"CRT Shader Static".hide()
