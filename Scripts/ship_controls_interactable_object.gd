extends StaticBody3D

#@export var text_scene: PackedScene
@onready var text_scene1: PackedScene = preload("res://Scenes/User Interface/Dialogue/ControlDialogueBox.tscn")
@onready var text_scene2: PackedScene = preload("res://Scenes/User Interface/Dialogue/Control2DialogueBox.tscn")

@export var trigger = Area3D

var in_dialogue = false

func interact():
	if in_dialogue:
		return
	if trigger.monitoring:
		return # already armed
	trigger.monitoring = true

func _show_dialogue():
	if Globals.StoryStage < 4:
		add_child(text_scene2.instantiate())

	elif Globals.StoryStage == 4:
		add_child(text_scene1.instantiate())

	else:
		Globals.ShipMenu = true
