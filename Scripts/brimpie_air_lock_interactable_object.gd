extends StaticBody3D

#@export var text_scene0: PackedScene
@onready var text_scene1: PackedScene = preload("res://Scenes/User Interface/Dialogue/ReturnToShipDialogueBox.tscn")

@export var trigger = Area3D

var in_dialogue = false

func interact():
	if in_dialogue:
		return
	if trigger.monitoring:
		return # already armed
	trigger.monitoring = true

func _show_dialogue():
	if Globals.supplies2 == 3:
		get_tree().change_scene_to_file("res://Scenes/Levels/Calihan_Ship.tscn")
		Globals.StoryStage += 1
		Globals.lore8 = 1
	else:
		var text1 = text_scene1.instantiate()
		add_child(text1)
