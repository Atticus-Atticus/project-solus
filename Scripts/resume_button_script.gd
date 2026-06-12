extends Button

#@onready var scene: PackedScene = preload("res://Scenes/User Interface/Menus/Options.tscn")

func _on_mouse_entered() -> void:
	$".".set_text(">> Resume <<")

func _on_mouse_exited() -> void:
	$".".set_text("> Resume <")
