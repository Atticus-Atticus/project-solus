extends StaticBody3D

#@export var text_scene: PackedScene
@onready var scene: PackedScene = preload("res://Scenes/User Interface/Menus/DataBaseMenu.tscn")

@export var trigger = Area3D

var in_dialogue = false

func interact():
	if in_dialogue:
		return
	if trigger.monitoring:
		return # already armed
	trigger.monitoring = true

func _show_dialogue():
	Globals.PlayerControls = false
	var loadedscene = scene.instantiate()
	add_child(loadedscene)
