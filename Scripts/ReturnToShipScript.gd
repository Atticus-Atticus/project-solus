extends StaticBody3D

@onready var text_scene1: PackedScene = preload("res://Scenes/User Interface/Dialogue/ReturnToShipDialogueBox.tscn")

func interact():
	if Globals.supplies1 == 1:
		Globals.StoryStage += 1
		get_tree().change_scene_to_file("res://Scenes/Levels/Calihan_Ship.tscn")
		Globals.lore7 = 1
	else:
		var text1 = text_scene1.instantiate()
		add_child(text1)

func _process(delta: float) -> void:
	if Globals.supplies1 == 1:
		$AnimationPlayerObjective.play("ObjectiveFlash")
