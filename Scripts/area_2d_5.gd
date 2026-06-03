extends Area2D

@onready var anim: AnimationPlayer = $"../../Camera2D/Panel/AnimationPlayer"
@onready var info_label: Label = $"../../Camera2D/Panel/Label"



func _on_body_entered(body: Node2D) -> void:
	info_label.set_text("
              INFO PANEL


PLANET: Brimpie - 5

SYSTEM: Brimpie

CLASSIFICATION: Metal Rich Rocky Body

POPULATION: N/A

PURPOSE:
Mining and Mineral Processing

ATMOSPHERE: Contamination Detected

GRAVITY: 0.8 G

TEMPERATURE: 278°C

LANDING CLEARANCE: RESTRICTED

NOTE: 
Planet destroyed in mining accident. Travel is prohibited.")
	anim.play("open")


func _on_body_exited(body: Node2D) -> void:
	anim.play_backwards("open")
