extends StaticBody3D

@onready var text_scene1: PackedScene = preload("res://Scenes/User Interface/Dialogue/RadioDialogueBox.tscn")
@onready var text_scene2: PackedScene = preload("res://Scenes/User Interface/Dialogue/Radio2DialogueBox.tscn")

func _ready() -> void:
	$"../TextboxContainer".hide()


func interact():
	var roll = randi() % 20 + 1

	if roll == 10:
		Globals.PlayerControls = false
		$"../AudioStreamPlayer3D".play()
		$"../TextboxContainer".show()
		$"../TextboxContainer/TweenAnimation".play("TextTween")

	if Globals.StoryStage == 3:
		var text1 = text_scene1.instantiate()
		add_child(text1)
		Globals.StoryStage += 1
	else:
		var text2 = text_scene2.instantiate()
		add_child(text2)

func _process(delta: float) -> void:
	var audio = $"../AudioStreamPlayer3D"
	
	if Input.is_action_just_pressed("Dialogue") and audio.is_playing():
		audio.stop()
		Globals.PlayerControls = true
		$"../TextboxContainer".hide()

func _on_audio_stream_player_3d_finished() -> void:
	Globals.PlayerControls = true
	$"../TextboxContainer".hide()
