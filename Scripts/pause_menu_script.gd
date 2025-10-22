extends Control

@onready var cursor = $ProjectSolusCursor2


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	cursor.position = get_global_mouse_position()
