extends Button

func _on_mouse_entered() -> void:
	$".".set_text("> Run Program <")

func _on_mouse_exited() -> void:
	$".".set_text("Run Program")

func _on_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/User Interface/Menus/MenuStartScreen.tscn")
	Globals.StoryStage += 1
