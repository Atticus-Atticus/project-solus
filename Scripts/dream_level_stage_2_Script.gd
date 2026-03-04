extends Node3D

@onready var pause_menu = $PauseMenu

@onready var LoadPlayer: PackedScene = preload("res://Scenes/Objects/Player.tscn")
@onready var Player = $Player/CharacterBody3D

@onready var text: PackedScene = preload("res://Scenes/User Interface/Dialogue/Loop2DialogueBox.tscn")

var timer := 0.0

var playing1 = 0
var playing2 = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


func _process(delta: float) -> void:
	if Globals.HallwayLoop == 3:
		get_tree().change_scene_to_file("res://Scenes/Levels/Dream_LevelStage3.tscn")

	if Input.is_action_just_pressed("Pause"):
		pausemenu()

	timer += delta
	if timer >= 2.0:
		timer = 0.0
		var roll = randi() % 30 + 1
		if roll == 10 and playing1 == 0:
			$FlyOver.play()
			playing1 = 1

	timer += delta
	if timer >= 1.0:
		timer = 0.0
		var roll2 = randi() % 30 + 1
		if roll2 == 15 and playing2 == 0:
			$Siren.play()
			playing2 = 1

func pausemenu():
	if Globals.paused:
		pause_menu.hide()
		Globals.PlayerControls = true
		$Ambience.play()
		$Music.play()
		#Engine.time_scale = 1
	else:
		pause_menu.show()
		Globals.PlayerControls = false
		#Engine.time_scale = 0
		$Ambience.stop()
		$Music.stop()
	Globals.paused = !Globals.paused


func _on_siren_finished() -> void:
	playing1 = 0

func _on_fly_over_finished() -> void:
	playing2 = 0


func _on_animation_player_image_flash_animation_finished(anim_name: StringName) -> void:
	var LoadedText = text.instantiate()
	add_child(LoadedText)
