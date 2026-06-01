extends Area2D

@onready var button: Button = get_parent()
var in_area = false


func _on_body_entered(body: Node2D) -> void:
	if button.disabled:
		return

	if body is CharacterBody2D:
		button._on_mouse_entered()
		in_area = true


func _on_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		if not button.disabled:
			button._on_mouse_exited()

		in_area = false


func _process(delta: float) -> void:
	if button.disabled:
		return

	if in_area and Input.is_action_just_pressed("Interact"):
		button._on_pressed()
