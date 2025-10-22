extends StaticBody3D

@onready var text_scene2: PackedScene = preload("res://Scenes/User Interface/Dialogue/Control2DialogueBox.tscn")


func interact():
	var text2 = text_scene2.instantiate()
	add_child(text2)
