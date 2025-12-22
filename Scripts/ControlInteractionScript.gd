extends StaticBody3D

@onready var text_scene1: PackedScene = preload("res://Scenes/User Interface/Dialogue/ControlDialogueBox.tscn")
@onready var text_scene2: PackedScene = preload("res://Scenes/User Interface/Dialogue/Control2DialogueBox.tscn")

func interact() -> void:
	if Globals.StoryStage < 4:
		add_child(text_scene2.instantiate())

	elif Globals.StoryStage == 4:
		add_child(text_scene1.instantiate())

	else:
		Globals.ShipMenu = true

	$AnimationPlayerObjective.stop()
