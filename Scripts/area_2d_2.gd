extends Area2D

@onready var anim: AnimationPlayer = $"../../Camera2D/Panel/AnimationPlayer"
@onready var info_label: Label = $"../../Camera2D/Panel/Label"



func _on_body_entered(body: Node2D) -> void:
	info_label.set_text("
              INFO PANEL


PLANET: Brimpie - 2

SYSTEM: Brimpie

CLASSIFICATION: Rocky Body (Terraformed to Earth-Like)

POPULATION: 100.4 Million [estimate]

PURPOSE:
Wheat Agriculture and Synthetic Protein Production

ATMOSPHERE: Contamination Detected

GRAVITY: 0.8 G

TEMPERATURE: 20°C

LANDING CLEARANCE: ERROR")
	anim.play("open")


func _on_body_exited(body: Node2D) -> void:
	anim.play_backwards("open")
