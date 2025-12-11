extends Control

@onready var current = $Panel/Label2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Globals.InputType == 1:
		current.text = "Tank Controls"
	if Globals.InputType == 2:
		current.text = "Mouse Directional"
	if Globals.InputType == 3:
		current.text = "Camera Relative"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Globals.InputType == 1:
		current.text = "Tank Controls"
	if Globals.InputType == 2:
		current.text = "Mouse Directional"
	if Globals.InputType == 3:
		current.text = "Camera Relative"


func _on_tank_ctrl_pressed() -> void:
	Globals.InputType = 1
	current.text = "Tank Controls"
	$ChangeMenuSFX.play()


func _on_mouse_ctrl_pressed() -> void:
	Globals.InputType = 2
	current.text = "Mouse Directional"
	$ChangeMenuSFX.play()


func _on_camera_ctrl_pressed() -> void:
	Globals.InputType = 3
	current.text = "Camera Relative"
	$ChangeMenuSFX.play()
