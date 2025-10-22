extends Node3D


func _ready() -> void:
	$blockbench_export/AnimationPlayer2.stop()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Skip"):
		get_tree().change_scene_to_file("res://Scenes/Levels/Calihan_Ship.tscn")


func _on_animation_player_1_animation_finished(anim_name: StringName) -> void:
	$blockbench_export/AnimationPlayer2.play("WakeUp/Wake Up")


func _on_animation_player_2_animation_finished(anim_name: StringName) -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/Calihan_Ship.tscn")
