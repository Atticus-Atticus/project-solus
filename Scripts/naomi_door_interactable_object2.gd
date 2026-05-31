extends StaticBody3D

#@export var text_scene: PackedScene

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
	Globals.HallwayLoop += 1

func _remove():
	queue_free()
