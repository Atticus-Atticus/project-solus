extends Node3D

var playing = 0

func _ready() -> void:
	playing = 0

# Called when the node enters the scene tree for the first time.
func _process(delta: float) -> void:
	if Globals.StoryStage == 4 and playing == 0:
		playing = 1
		$StaticBody3D/AnimationPlayerObjective.play("ObjectiveFlash")

	if Globals.StoryStage == 6 and playing == 0:
		playing = 1
		$StaticBody3D/AnimationPlayerObjective.play("ObjectiveFlash")

	if Globals.StoryStage == 7 and playing == 0:
		playing = 1
		$StaticBody3D/AnimationPlayerObjective.play("ObjectiveFlash")
