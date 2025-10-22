extends Control

@onready var cursor = $ProjectSolusCursor2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	cursor.position = get_global_mouse_position()

	if Input.is_action_just_pressed("Pause"):
		get_tree().change_scene_to_file("res://Scenes/User Interface/Menus/MainMenu.tscn")
