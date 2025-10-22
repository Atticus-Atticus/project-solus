extends Control

@onready var cursor = $ProjectSolusCursor2

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Enter"):
		get_tree().change_scene_to_file("res://Scenes/User Interface/Menus/MenuEndScreen2.tscn")

	cursor.position = get_global_mouse_position()
