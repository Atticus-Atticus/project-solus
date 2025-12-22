extends Control



func _ready() -> void:
	$ColorRect.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Enter"):
		$ColorRect2/AnimationPlayer.play("FadeToBlack")

func _on_change_menu_sfx_tree_exited() -> void:
	$MenuSFX.stop()

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	$ColorRect/AnimationPlayer.play("FlashingSquare")

func _on_animation_finished(anim_name: StringName) -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/Calihan_Ship_Cutscene.tscn")
