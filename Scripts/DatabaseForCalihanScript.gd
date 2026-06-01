extends Area2D

@onready var button: Button = get_parent()
var in_area = false


func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and Globals.KeysFound == 2:
		button._on_mouse_entered()
		in_area = true

func _on_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D and Globals.KeysFound == 2:
		button._on_mouse_exited()
		in_area = false

func _process(delta: float) -> void:
	if in_area == true and Input.is_action_just_pressed("Interact") and Globals.KeysFound == 2:
		button._on_pressed()
