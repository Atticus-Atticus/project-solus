extends Node3D

@export var cam: Camera3D



func _ready() -> void:
	cam._make_active()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Tab") or event.is_action_pressed("Pause"):
		cam._exit_cam()
		await get_tree().create_timer(1).timeout
		#cam.hide()
		get_tree().change_scene_to_file("res://Scenes/Levels/Calihan_Ship.tscn")
