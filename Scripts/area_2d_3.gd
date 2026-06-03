extends Area2D

@onready var anim: AnimationPlayer = $"../../Camera2D/Panel/AnimationPlayer"
@onready var info_label: Label = $"../../Camera2D/Panel/Label"



func _on_body_entered(body: Node2D) -> void:
	info_label.set_text("
              INFO PANEL


PLANET: Brimpie - 3

SYSTEM: Brimpie

CLASSIFICATION: Earth-Like Planet

POPULATION: 1.2 billion [estimate]

PURPOSE:
Wheat and Algea Agriculture and Residential

ATMOSPHERE: Contamination Detected

GRAVITY: 1.2 G

TEMPERATURE: 16°C

LANDING CLEARANCE: ERROR

WARNING:
HIGH RADITION LEVELS DETECTED!")
	anim.play("open")


func _on_body_exited(body: Node2D) -> void:
	anim.play_backwards("open")
