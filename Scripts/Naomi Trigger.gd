extends Area3D

@onready var ErrorScreen: PackedScene = preload("res://Scenes/User Interface/ErrorScreen.tscn")
var gone = false


func _on_body_entered(body: CharacterBody3D) -> void:
	if gone == false:
		gone = true
		var Loaded = ErrorScreen.instantiate()
		add_child(Loaded)
		await get_tree().create_timer(1).timeout
		$"..".hide()
