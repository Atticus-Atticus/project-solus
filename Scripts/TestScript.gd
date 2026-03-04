extends Node3D

@onready var pause_menu = $PauseMenu

@onready var text_scene1: PackedScene = preload("res://Scenes/User Interface/Dialogue/AbandonedShipDialogueBox.tscn")

var supplies = 0
#max is 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(SceneSwitcher.PlayerSpawn)
	$AirlockDoorSFX.play()
	$Timer.start()

	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

	Globals.VisitedShip = 1

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Pause"):
		pausemenu()


func pausemenu():
	if Globals.paused:
		pause_menu.hide()
		Globals.PlayerControls = true
		$AudioStreamPlayer.play()
		#Engine.time_scale = 1
	else:
		pause_menu.show()
		Globals.PlayerControls = false
		$AudioStreamPlayer.stop()
		#Engine.time_scale = 0
	Globals.paused = !Globals.paused


func _on_timer_timeout() -> void:
	$Timer.queue_free()
	var text1 = text_scene1.instantiate()
	add_child(text1)
