extends StaticBody3D


@onready var text_scene: PackedScene = preload("res://Scenes/User Interface/Dialogue/BedSideDialogueBox.tscn")
#change this to the required dialogue box scene

func interact():
	var text_temp = text_scene.instantiate()
	add_child(text_temp)
