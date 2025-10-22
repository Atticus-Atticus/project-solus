extends Control


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Enter"):
		get_tree().change_scene_to_file("res://Scenes/Levels/DreamCutscene1.tscn")

func _on_change_menu_sfx_tree_exited() -> void:
	$MenuSFX.stop()
