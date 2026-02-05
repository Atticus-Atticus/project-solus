extends Button

@onready var scene: PackedScene = preload("res://Scenes/User Interface/Menus/Options.tscn")

func _on_mouse_entered() -> void:
	$".".set_text(">> OPTIONS <<")

func _on_mouse_exited() -> void:
	$".".set_text("> OPTIONS <")

func _on_pressed() -> void:
	var LoadedScene = scene.instantiate()
	add_child(LoadedScene)
