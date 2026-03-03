extends Area3D

@export var area: Area3D

func _ready() -> void:
	area.set_deferred("monitoring", false)

func _entered_trigger(body: Node3D) -> void:
	if body is CharacterBody3D and get_parent().in_dialogue == false:
		get_parent()._show_dialogue()
		print("player is in trigger")

func _exit_trigger(body: Node3D) -> void:
	get_parent().in_dialogue = false
	area.set_deferred("monitoring", false)
	print("player has left trigger")

func _process(delta: float) -> void:
	print(area.monitoring)
