extends StaticBody3D

@onready var scene1: PackedScene = preload("res://Scenes/User Interface/Dialogue/SuitDialogue.tscn")
@onready var scene2: PackedScene = preload("res://Scenes/User Interface/Dialogue/Suit2Dialogue.tscn")

func interact():
	if Globals.Suit == false:
		var loadedscene1 = scene1.instantiate()
		add_child(loadedscene1)
	if Globals.Suit == true:
		var loadedscene2 = scene2.instantiate()
		add_child(loadedscene2)
