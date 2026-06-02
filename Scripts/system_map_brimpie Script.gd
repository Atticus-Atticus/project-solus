extends Node2D

@export var cam = Camera2D
@export var ship = CharacterBody2D


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	cam.global_position = ship.global_position

	#cursor.position = get_global_mouse_position()
	#if Globals.VisitedShip == 1:
		#$AbandonedShipButton.set_disabled(true)
	#if Globals.VisitedStation == 1:
		#$BrimpieOrbitalButton.set_disabled(true)
	#if Globals.supplies1 == 1 and Globals.supplies2 == 3:
		#$AvalonSystemButton.set_disabled(false)
