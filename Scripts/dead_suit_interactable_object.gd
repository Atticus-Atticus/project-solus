extends StaticBody3D

#@export var text_scene: PackedScene
@onready var scene1: PackedScene = preload("res://Scenes/User Interface/Dialogue/SuitDialogue.tscn")
@onready var scene2: PackedScene = preload("res://Scenes/User Interface/Dialogue/Suit2Dialogue.tscn")

@export var trigger = Area3D
@export var supply = StaticBody3D

var in_dialogue = false

func interact():
	if in_dialogue:
		return
	if trigger.monitoring:
		return # already armed
	trigger.monitoring = true

func _show_dialogue():
	if Globals.Suit == false:
		var loadedscene1 = scene1.instantiate()
		add_child(loadedscene1)
	if Globals.Suit == true:
		var loadedscene2 = scene2.instantiate()
		add_child(loadedscene2)
