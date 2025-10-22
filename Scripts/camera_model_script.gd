extends Node3D

var in_trigger = false 
#used to determin whether something has entered the trigger. default false
var character 
#used to determin what the camera will look at

func _process(delta: float) -> void:
	if in_trigger and character != null:
		$Hinge.look_at(character.global_transform.origin)
		$Hinge/Camera3D.make_current()
#gets the hinge to look at the character...
#and makes the corrisponding camera3D as the current viewport
