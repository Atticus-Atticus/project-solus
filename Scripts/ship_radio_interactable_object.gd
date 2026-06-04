extends StaticBody3D

#@export var text_scene: PackedScene
@onready var text_scene1: PackedScene = preload("res://Scenes/User Interface/Dialogue/RadioDialogueBox.tscn")
@onready var text_scene2: PackedScene = preload("res://Scenes/User Interface/Dialogue/Radio2DialogueBox.tscn")

@export var player = CharacterBody3D
@export var trigger = Area3D

var in_dialogue = false

func _ready() -> void:
	$"TextboxContainer".hide()

func interact():
	if in_dialogue:
		return
	if trigger.monitoring:
		return # already armed
	trigger.monitoring = true

func _show_dialogue():
	#var roll = randi() % 20 + 1
#
	#if roll == 10:
		#Globals.PlayerControls = false
		#$AudioStreamPlayer3D.play()
		#$"TextboxContainer".show()
		#$"TextboxContainer/TweenAnimation".play("TextTween")

	if Globals.StoryStage < 3:
		var text2 = text_scene2.instantiate()
		add_child(text2)
	else:
		get_tree().change_scene_to_file("res://Scenes/User Interface/ShipRadio.tscn")
		player.get_player_pos()

func _on_audio_stream_player_3d_finished() -> void:
	Globals.PlayerControls = true
	$"../TextboxContainer".hide()
