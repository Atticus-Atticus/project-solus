extends Control


func _ready() -> void:
	$ColorRect.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Enter"):
		get_tree().change_scene_to_file("res://Scenes/Levels/DreamCutscene1.tscn")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	$ColorRect.show()
	$ColorRect/AnimationPlayer.play("FlashingSquare")
