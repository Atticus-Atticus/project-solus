extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"CRT Shader Static".show()
	await get_tree().create_timer(0.2).timeout
	$"CRT Shader Static".hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Pause"):
		Globals.PlayerControls = true
		get_tree().change_scene_to_file("res://Scenes/Levels/Calihan_Ship.tscn")
