extends StaticBody3D

#@export var text_scene: PackedScene
@onready var text_scene1: PackedScene = preload("res://Scenes/User Interface/Dialogue/RadioDialogueBox.tscn")
@onready var text_scene2: PackedScene = preload("res://Scenes/User Interface/Dialogue/Radio2DialogueBox.tscn")

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
	var roll = randi() % 20 + 1

	if roll == 10:
		Globals.PlayerControls = false
		$AudioStreamPlayer3D.play()
		$"TextboxContainer".show()
		$"TextboxContainer/TweenAnimation".play("TextTween")

	if Globals.StoryStage == 3:
		var text1 = text_scene1.instantiate()
		add_child(text1)
		Globals.StoryStage += 1
	else:
		var text2 = text_scene2.instantiate()
		add_child(text2)

func _on_audio_stream_player_3d_finished() -> void:
	Globals.PlayerControls = true
	$"../TextboxContainer".hide()
