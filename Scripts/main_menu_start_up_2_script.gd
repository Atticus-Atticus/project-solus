extends Control

func _ready() -> void:
	$WelcomeLabel.text = UserManager.get_welcome_message()

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	get_tree().change_scene_to_file("res://Scenes/User Interface/Menus/MainMenu.tscn")
