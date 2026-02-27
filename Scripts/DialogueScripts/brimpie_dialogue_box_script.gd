extends Node

var textline = 0
#0 = line 1
#1 = line 2
#2 = line 3
#3 = clear textbox

func _ready() -> void:
	$TextboxContainer/TweenAnimation.play("TextTween")
	$CalihanSpeech.play()
	Globals.PlayerControls = false

func _on_tween_animation_animation_finished(anim_name: StringName) -> void:
	textline += 1
	$CalihanSpeech.stop()


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Dialogue") and textline == 1:
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("It's been a long time since I last set foot here.")
		$TextboxContainer/TweenAnimation.play("TextTween")
		$CalihanSpeech.play()

	if Input.is_action_just_pressed("Dialogue") and textline == 2:
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("*sigh* I don't want to stay here too long.")
		$TextboxContainer/TweenAnimation.play("TextTween")
		$CalihanSpeech.play()

	if Input.is_action_just_pressed("Dialogue") and textline == 3:
		Globals.CamText = "Search the station for any supplies. 0/3"
		Globals.PlayerControls = true
		$".".queue_free()
