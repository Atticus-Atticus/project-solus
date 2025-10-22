extends StaticBody3D

#this is the foundation for all dialogue boxes

@onready var text_scene: PackedScene = preload("res://Scenes/User Interface/Dialogue/LockedDoor2DialogueBox.tscn")
#change this to the required dialogue box scene

func interact():
	var text_temp = text_scene.instantiate()
	add_child(text_temp)
