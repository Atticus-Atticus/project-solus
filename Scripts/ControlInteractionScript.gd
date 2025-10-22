extends StaticBody3D

@onready var text_scene1: PackedScene = preload("res://Scenes/User Interface/Dialogue/ControlDialogueBox.tscn")
@onready var text_scene2: PackedScene = preload("res://Scenes/User Interface/Dialogue/Control2DialogueBox.tscn")
@onready var text_scene3: PackedScene = preload("res://Scenes/User Interface/Dialogue/Control3DialogueBox.tscn")
@onready var text_scene4: PackedScene = preload("res://Scenes/User Interface/Dialogue/Control4DialogueBox.tscn")

func interact():
	if Globals.StoryStage == 4:
		var text1 = text_scene1.instantiate()
		add_child(text1)
		$AnimationPlayerObjective.stop()
	else:
		Globals.ShipMenu = true
		$AnimationPlayerObjective.stop()
