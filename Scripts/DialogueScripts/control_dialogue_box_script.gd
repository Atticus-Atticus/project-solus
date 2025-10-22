extends Node

var textline = 0
#0 = line 1
#1 = line 2
#2 = line 3
#3 = line 4
#4 = line 5
#5 = line 6
#6 = line 7
#7 = line 8
#8 = line 9
#9 = line 10
#10 = clear textbox

func _ready() -> void:
	$TextboxContainer/TweenAnimation.play("TextTween")
	$CalihanSpeech.play()
	Globals.PlayerControls = false

func _on_tween_animation_animation_finished(anim_name: StringName) -> void:
	textline += 1
	$CalihanSpeech.stop()
	$ShipAISpeech.stop()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Dialogue") and textline == 1:
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("Ship AI: Displaying Coordinates")
		$TextboxContainer/TweenAnimation.play("TextTween")
		$ShipAISpeech.play()

	if Input.is_action_just_pressed("Dialogue") and textline == 2:
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("Calihan: That's... That's on the other side of Solarian Space!")
		$TextboxContainer/TweenAnimation.play("TextTween")
		$CalihanSpeech.play()

	if Input.is_action_just_pressed("Dialogue") and textline == 3:
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("Calihan: How did she... No. It doesn't matter.")
		$TextboxContainer/TweenAnimation.play("TextTween")
		$CalihanSpeech.play()

	if Input.is_action_just_pressed("Dialogue") and textline == 4:
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("Calihan: I need supplies for the journey.")
		$TextboxContainer/TweenAnimation.play("TextTween")
		$CalihanSpeech.play()

	if Input.is_action_just_pressed("Dialogue") and textline == 5:
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("Calihan: Ship, do a system wide scan and ping anything found.")
		$TextboxContainer/TweenAnimation.play("TextTween")
		$CalihanSpeech.play()

	if Input.is_action_just_pressed("Dialogue") and textline == 6:
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("Ship AI: Displaying scan results to main console.")
		$TextboxContainer/TweenAnimation.play("TextTween")
		$ShipAISpeech.play()

	if Input.is_action_just_pressed("Dialogue") and textline == 7:
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("Calihan: Brimpie Orbital and another ship. They'll do.")
		$TextboxContainer/TweenAnimation.play("TextTween")
		$CalihanSpeech.play()


	if Input.is_action_just_pressed("Dialogue") and textline == 8:
		Globals.StoryStage += 1
		Globals.PlayerControls = true
		Globals.ShipMenu = true
		$".".queue_free()
