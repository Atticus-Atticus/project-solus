extends StaticBody3D

@onready var scene: PackedScene = preload("res://Scenes/User Interface/Menus/DataBaseMenu.tscn")

func interact():
	Globals.PlayerControls = false
	var loadedscene = scene.instantiate()
	add_child(loadedscene)
