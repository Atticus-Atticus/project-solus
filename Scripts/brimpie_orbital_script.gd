extends Node3D

@onready var pause_menu = $PauseMenu

@onready var text_scene1: PackedScene = preload("res://Scenes/User Interface/Dialogue/BrimpieDialogueBox.tscn")
@onready var text_scene2: PackedScene = preload("res://Scenes/User Interface/Dialogue/EnoughDialogueBox.tscn")

var TextOnScreen = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AirlockDoorSFX.play()
	var text1 = text_scene1.instantiate()
	add_child(text1)

	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

	Globals.VisitedStation = 1

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Pause"):
		pausemenu()

	if Globals.supplies2 == 3 and TextOnScreen == 0:
		var text2 = text_scene2.instantiate()
		add_child(text2)
		TextOnScreen = 1


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
