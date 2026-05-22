extends StaticBody3D

#@export var text_scene: PackedScene

@export var trigger = Area3D

var in_dialogue = false

func interact():
	if in_dialogue:
		return
	if trigger.monitoring:
		return # already armed
	trigger.monitoring = true

func _show_dialogue():
	$"CRT Shader Static".show()
	$"Timer".start()

func _on_timer_timeout() -> void:
	Globals.HallwayLoop += 1
