extends Control

@onready var current = $Panel/Label2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Globals.InputType == false:
		current.text = "Tank Controls"
	else:
		current.text = "Mouse Directional"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_mouse_ctrl_pressed() -> void:
	Globals.InputType = true
	current.text = "Mouse Directional"
	$ChangeMenuSFX.play()


func _on_tank_ctrl_pressed() -> void:
	Globals.InputType = false
	current.text = "Tank Controls"
	$ChangeMenuSFX.play()
