extends Node3D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Globals.StoryStage == 3:
		$StaticBody3D/AnimationPlayerObjective.play("ObjectiveFlash")
	else:
		$StaticBody3D/AnimationPlayerObjective.stop()
