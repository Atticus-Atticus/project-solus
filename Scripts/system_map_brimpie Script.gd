extends Node2D

#@onready var cursor = $ProjectSolusCursor2
#
## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#cursor.position = get_global_mouse_position()
#
	#if Globals.VisitedShip == 1:
		#$AbandonedShipButton.set_disabled(true)
#
	#if Globals.VisitedStation == 1:
		#$BrimpieOrbitalButton.set_disabled(true)
#
	#if Globals.supplies1 == 1 and Globals.supplies2 == 3:
		#$AvalonSystemButton.set_disabled(false)
