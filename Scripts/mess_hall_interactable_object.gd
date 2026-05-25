extends StaticBody3D

#@export var text_scene: PackedScene

@onready var text_scene1: PackedScene = preload("res://Scenes/User Interface/Dialogue/PlayerSupplyDialogueBox.tscn")
#@onready var text_scene2: PackedScene = preload("res://Scenes/User Interface/Dialogue/PlayerNoSupplyDialogueBox.tscn") UNUSED!
@onready var eat_text: PackedScene = preload("res://Scenes/User Interface/Dialogue/EatSomethingDialogueBox.tscn")

@export var trigger = Area3D

var in_dialogue = false

func interact():
	if in_dialogue:
		return
	if trigger.monitoring:
		return # already armed
	trigger.monitoring = true

func _show_dialogue():
	if Globals.PlayerSupplies == 0 && Globals.StoryStage == 2:
		var text_temp3 = eat_text.instantiate()
		add_child(text_temp3)
		Globals.StoryStage += 1
	else:
		var text_temp1 = text_scene1.instantiate()
		add_child(text_temp1)
