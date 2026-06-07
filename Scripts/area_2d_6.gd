extends Area2D

@onready var anim: AnimationPlayer = $"../../Camera2D/Panel/AnimationPlayer"
@onready var info_label: Label = $"../../Camera2D/Panel/Label"

@export var PlayerShip = CharacterBody2D

var in_trigger = false


func _on_body_entered(body: Node2D) -> void:
	info_label.set_text("
              INFO PANEL


SHIP: R.C.S Talbot

REGISTRATION: TG-907-4

REGISTERED OWNER: Mr F Talbot

SCAN RESULTS:
FUEL: NONE

LIFE SIGNS: NONE

STATE: DERELICT

AUTOMATED DOCKING RESPONSE: GRANTED

PRESS 'E' TO BEGIN DOCKING SEQUENCE")
	anim.play("open")
	in_trigger = true


func _on_body_exited(body: Node2D) -> void:
	anim.play_backwards("open")
	in_trigger = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Interact") and in_trigger == true:
		SceneSwitcher.Destination = 1
		Globals.CamText = "Use the Airlock to enter the other ship"
		PlayerShip._toggle()
