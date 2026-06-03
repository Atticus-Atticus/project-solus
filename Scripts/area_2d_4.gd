extends Area2D

@onready var anim: AnimationPlayer = $"../../Camera2D/Panel/AnimationPlayer"
@onready var info_label: Label = $"../../Camera2D/Panel/Label"



func _on_body_entered(body: Node2D) -> void:
	info_label.set_text("
              INFO PANEL


PLANET: Brimpie - 4

SYSTEM: Brimpie

CLASSIFICATION: Class-2 Gas Giant

POPULATION: 14,500 [estimate]

PURPOSE:
Long Range Communications and System Wide Monitoring

ATMOSPHERE: N/A

GRAVITY: 2.9 G

TEMPERATURE: -195°C

LANDING CLEARANCE: ERROR

WARNING:
HIGH RADITION LEVELS DETECTED!")
	anim.play("open")


func _on_body_exited(body: Node2D) -> void:
	anim.play_backwards("open")
