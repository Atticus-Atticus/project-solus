extends Area2D

@onready var anim: AnimationPlayer = $"../../Camera2D/Panel/AnimationPlayer"
@onready var info_label: Label = $"../../Camera2D/Panel/Label"

@export var PlayerShip = CharacterBody2D

var in_trigger2 = false


func _on_body_entered(body: Node2D) -> void:
	info_label.set_text("
              INFO PANEL


STATION: Brimpie Orbital

REGISTRATION: BP-592-1

MODEL: Hector Class Orbital Station

PURPOSE: Main Hub of Trade Commerical Services

SCAN RESULTS:

LIFE SIGNS: UNKNOWN HUMANOIDS DETECTED

STATE: ACTIVE

AUTOMATED DOCKING RESPONSE: GRANTED

PRESS 'E' TO BEGIN DOCKING SEQUENCE")
	anim.play("open")
	in_trigger2 = true


func _on_body_exited(body: Node2D) -> void:
	anim.play_backwards("open")
	in_trigger2 = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Interact") and in_trigger2 == true:
		SceneSwitcher.Destination = 2
		PlayerShip._toggle()
