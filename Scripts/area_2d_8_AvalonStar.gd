extends Area2D

@onready var anim: AnimationPlayer = $"../../Camera2D/Panel/AnimationPlayer"
@onready var info_label: Label = $"../../Camera2D/Panel/Label"

@export var PlayerShip = CharacterBody2D

var in_trigger2 = false


func _on_body_entered(body: Node2D) -> void:
	info_label.set_text("
              INFO PANEL

SYSTEM: Avalon

DISTANCE: 8.3 ly

E.T.A: 14 Cycles

PLOTTED ROUTE:
> Brimpie (you are here)
> Avalon
> Tau Ceti
> ERROR
> ERROR
> Altair

INTERSTELLAR HIGHWAY STATUS: ERROR

PRESS 'E' TO BEGIN CHARGING FTL DRIVE")
	anim.play("open")
	in_trigger2 = true


func _on_body_exited(body: Node2D) -> void:
	anim.play_backwards("open")
	in_trigger2 = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Interact") and in_trigger2 == true:
		SceneSwitcher.Destination = 3
		Globals.CamText = "Travel to the Avalon System"
		PlayerShip._toggle()
