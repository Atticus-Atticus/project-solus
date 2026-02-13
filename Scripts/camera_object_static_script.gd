extends Node3D

var in_trigger = false 
#used to determin whether something has entered the trigger. default false
var character 
#used to determin what the camera will look at

@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	if in_trigger and character != null:
		$Camera3D.make_current()
#Makes the corrisponding camera3D as the current viewport

# This camera is a static version of the main camera. This one will NOT follow the players movement.
