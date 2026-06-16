extends Node3D

@onready var pause_menu = $PauseMenu

@onready var LoadPlayer: PackedScene = preload("res://Scenes/Objects/Player.tscn")
@onready var Player = $Player/CharacterBody3D

@onready var text: PackedScene = preload("res://Scenes/User Interface/Dialogue/Loop0DialogueBox.tscn")

@onready var cursor = $ProjectSolusCursor2

var timer := 0.0

var playing1 = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var LoadedText = text.instantiate()
	add_child(LoadedText)

func _process(delta: float) -> void:
	if Globals.HallwayLoop == 1:
		get_tree().change_scene_to_file("res://Scenes/Levels/Dream_LevelStage1.tscn")

	if Input.is_action_just_pressed("Pause"):
		pausemenu()

	timer += delta
	if timer >= 2.0:
		timer = 0.0
		var roll = randi() % 30 + 1
		if roll == 10 and playing1 == 0:
			$City/FlyOver.play()
			playing1 = 1

func pausemenu():
	if Globals.paused:
		pause_menu.hide()
		$City/Ambience.play()
		$Music.play()
		Globals.PlayerControls = true
		#Engine.time_scale = 1
	else:
		pause_menu.show()
		Globals.PlayerControls = false
		#Engine.time_scale = 0
		$City/Ambience.stop()
		$Music.stop()
	Globals.paused = !Globals.paused


func _on_fly_over_finished() -> void:
	playing1 = 0
