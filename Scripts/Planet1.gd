extends Area2D

@onready var anim: AnimationPlayer = $"../../Camera2D/Panel/AnimationPlayer"
@onready var info_label: Label = $"../../Camera2D/Panel/Label"



func _on_body_entered(body: Node2D) -> void:
	info_label.set_text("
              INFO PANEL


PLANET: Brimpie - 1

SYSTEM: Brimpie

CLASSIFICATION: Barren Planet

POPULATION: 250,000 [estimate]

PURPOSE:
Power Generation and Distribution

ATMOSPHERE: Contamination Detected

GRAVITY: 0.6 G

TEMPERATURE: 155°C

LANDING CLEARANCE: ERROR")
	anim.play("open")


func _on_body_exited(body: Node2D) -> void:
	anim.play_backwards("open")
