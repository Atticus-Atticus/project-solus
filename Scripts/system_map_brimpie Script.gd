extends Node2D

@export var cam = Camera2D
@export var ship = CharacterBody2D


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	
	if Globals.VisitedShip == 1:
		$Area2D/Area2D6/AbShip.set_deferred("disabled", true)
		$Planets/Ship/AnimatedSprite2D.hide()

	if Globals.VisitedStation == 1:
		$Area2D/Area2D7/BpStation.set_deferred("disabled", true)
		$Planets/Station/AnimatedSprite2D.hide()

	if SceneSwitcher.PlayerShipSpawn != null:
		ship.position = SceneSwitcher.PlayerShipSpawn

	if Globals.StoryStage >= 7:
		$Planets/AvalonStar.show()
		$Area2D/Area2D8.show()
		$Area2D/Area2D8/CollisionShape2D.set_deferred("disabled", false)
	else:
		$Planets/AvalonStar.hide()
		$Area2D/Area2D8.hide()
		$Area2D/Area2D8/CollisionShape2D.set_deferred("disabled", true)
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
