extends Node3D

@onready var pause_menu = $PauseMenu

@onready var LoadPlayer: PackedScene = preload("res://Scenes/Objects/Player.tscn")
@onready var Player = $Player/CharacterBody3D

var timer := 0.0

var playing1 = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



func _process(delta: float) -> void:
	if Globals.HallwayLoop == 2:
		get_tree().change_scene_to_file("res://Scenes/Levels/Dream_LevelStage2.tscn")

	if Input.is_action_just_pressed("Pause"):
		pausemenu()

	timer += delta
	if timer >= 2.0:
		timer = 0.0
		var roll = randi() % 30 + 1
		if roll == 10 and playing1 == 0:
			$FlyOver.play()
			playing1 = 1

func pausemenu():
	if Globals.paused:
		pause_menu.hide()
		$Ambience.play()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0
		$Ambience.stop()
	Globals.paused = !Globals.paused


func _on_fly_over_finished() -> void:
	playing1 = 0
