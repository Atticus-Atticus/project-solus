extends Node3D

@onready var pause_menu = $PauseMenu

@onready var LoadPlayer: PackedScene = preload("res://Scenes/Objects/Player.tscn")
@onready var WakeUpText: PackedScene = preload("res://Scenes/User Interface/Dialogue/WakeUpDialogueBox.tscn")
@onready var ReturnText: PackedScene = preload("res://Scenes/User Interface/Dialogue/ReturnedDialogueBox.tscn")
@onready var Return2Text: PackedScene = preload("res://Scenes/User Interface/Dialogue/Returned2DialogueBox.tscn")
@onready var Act1End: PackedScene = preload("res://Scenes/User Interface/Dialogue/Control4DialogueBox.tscn")

@export var player = CharacterBody3D

var ending1 = 0
var ending2 = 0
var anim1 = 0
var anim2 = 0

func _ready() -> void:
	Globals.StoryStage += 1

	if SceneSwitcher.PlayerSpawn != null:
		player.position = SceneSwitcher.PlayerSpawn

	if Globals.StoryStage == 1:
		var LoadedText = WakeUpText.instantiate()
		add_child(LoadedText)
		
	if Globals.StoryStage == 6:
		var LoadedText2 = ReturnText.instantiate()
		add_child(LoadedText2)
		
	if Globals.StoryStage == 7:
		var LoadedText3 = Return2Text.instantiate()
		add_child(LoadedText3)
	
	SceneSwitcher.Destination = 0
	Globals.Destination = 0

func _on_child_exiting_tree(node: Node) -> void:
	player.get_player_pos()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Pause"):
		pausemenu()

	if Globals.ShipMenu == true:
		$SystemScreen.show()

	if Globals.ShipMenu == false:
		$SystemScreen.hide()

	if Globals.StoryStage == 8 and ending1 == 0:
		ending1 = 1
		var LoadedText4 = Act1End.instantiate()
		add_child(LoadedText4)

	if Globals.StoryStage == 9 and ending2 == 0:
		ending2 = 1
		$HUD.hide()
		$EndingSFX.play()
		$"CRT Shader Static".show()
		$Timer.start()

	if Globals.Destination == 1 and anim1 == 0:
		anim1 = 1
		$AnimationPlayer.play("MovetoABSHIP")
		Globals.CamText = "Use the airlock to enter the Abandoned Ship"

	if Globals.Destination == 2 and anim2 == 0:
		anim2 = 1
		$AnimationPlayer.play("MovetoBRIM")
		Globals.CamText = "Use the airlock to enter Brimpie Orbital"

func pausemenu():
	if Globals.paused:
		pause_menu.hide()
		$AudioStreamPlayer.play()
		Globals.PlayerControls = true
		#Engine.time_scale = 1
	else:
		pause_menu.show()
		Globals.PlayerControls = false
		#Engine.time_scale = 0
		$AudioStreamPlayer.stop()
	Globals.paused = !Globals.paused


func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://Scenes/User Interface/Menus/MenuEndScreen.tscn")
