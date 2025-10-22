extends Node3D


# Called when the node enters the scene tree for the first time.
func _process(delta: float) -> void:
	if Globals.StoryStage == 52:
		$StaticBody3D/AnimationPlayerObjective.play("ObjectiveFlash")
	else:
		$StaticBody3D/AnimationPlayerObjective.stop()
