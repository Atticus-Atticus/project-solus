extends Node3D

@onready var pause_menu = $PauseMenu

@onready var LoadPlayer: PackedScene = preload("res://Scenes/Objects/Player.tscn")
@onready var WakeUpText: PackedScene = preload("res://Scenes/User Interface/Dialogue/WakeUpDialogueBox.tscn")
@onready var ReturnText: PackedScene = preload("res://Scenes/User Interface/Dialogue/ReturnedDialogueBox.tscn")
@onready var Return2Text: PackedScene = preload("res://Scenes/User Interface/Dialogue/Returned2DialogueBox.tscn")
@onready var Act1End: PackedScene = preload("res://Scenes/User Interface/Dialogue/Control4DialogueBox.tscn")

var ending1 = 0
var ending2 = 0
var anim1 = 0
var anim2 = 0

func _ready() -> void:
	if SceneSwitcher.PlayerSpawn == null:
		var LoadedPlayer = LoadPlayer.instantiate()
		LoadedPlayer.scale *= 1.2
		add_child(LoadedPlayer)
	else:
		var LoadedPlayer = LoadPlayer.instantiate()
		LoadedPlayer.position = SceneSwitcher.PlayerSpawn
		LoadedPlayer.scale *= 1.2
		add_child(LoadedPlayer)
		$AirlockDoorSFX.play()


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
	$Player/CharacterBody3D.get_player_pos()

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
		#Engine.time_scale = 1
	else:
		pause_menu.show()
		#Engine.time_scale = 0
		$AudioStreamPlayer.stop()
	Globals.paused = !Globals.paused


func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://Scenes/User Interface/Menus/MenuEndScreen.tscn")
