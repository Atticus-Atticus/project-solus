extends Node

var textline = 0
#0 = line 1
#1 = line 2
#you get how this works
#24 = clear textbox

func _ready() -> void:
	$TextboxContainer/TweenAnimation.play("TextTween")
	$ShipAISpeech.play()
	Globals.PlayerControls = false

func _on_tween_animation_animation_finished(anim_name: StringName) -> void:
	textline += 1
	$CalihanSpeed.stop()
	$NaomiSpeech.stop()
	$ShipAISpeech.stop()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Dialogue") and textline == 1:
		$TextboxContainer/MarginContainer/HBoxContainer/Start.set_text("Radio:")
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("*STATIC* Ca...lihan...?")
		$TextboxContainer/TweenAnimation.play("TextTween")

	if Input.is_action_just_pressed("Dialogue") and textline == 2:
		$TextboxContainer/MarginContainer/HBoxContainer/Start.set_text("Calihan:")
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("Naomi?")
		$TextboxContainer/TweenAnimation.play("TextTween")
		$CalihanSpeed.play()

	if Input.is_action_just_pressed("Dialogue") and textline == 3:
		$TextboxContainer/MarginContainer/HBoxContainer/Start.set_text("Radio:")
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("*STATIC* ...come...home...")
		$TextboxContainer/TweenAnimation.play("TextTween")
		$NaomiSpeech.play()

	if Input.is_action_just_pressed("Dialogue") and textline == 4:
		$TextboxContainer/MarginContainer/HBoxContainer/Start.set_text("Calihan:")
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("I... I can't. Our home is gone. Where are you and I'll-")
		$TextboxContainer/TweenAnimation.play("TextTween")
		$CalihanSpeed.play()

	if Input.is_action_just_pressed("Dialogue") and textline == 5:
		$TextboxContainer/MarginContainer/HBoxContainer/Start.set_text("Radio:")
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("*STATIC* ...new... home... here... with me...")
		$TextboxContainer/TweenAnimation.play("TextTween")
		$NaomiSpeech.play()

	if Input.is_action_just_pressed("Dialogue") and textline == 6:
		$TextboxContainer/MarginContainer/HBoxContainer/Start.set_text("Calihan:")
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("Naomi, please. Where are you?")
		$TextboxContainer/TweenAnimation.play("TextTween")
		$CalihanSpeed.play()

	if Input.is_action_just_pressed("Dialogue") and textline == 7:
		$TextboxContainer/MarginContainer/HBoxContainer/Start.set_text("Radio:")
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("*STATIC*")
		$TextboxContainer/TweenAnimation.play("TextTween")
		$NaomiSpeech.play()

	if Input.is_action_just_pressed("Dialogue") and textline == 8:
		$TextboxContainer/MarginContainer/HBoxContainer/Start.set_text("Ship_Com:")
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("Closing Comms Channel")
		$TextboxContainer/TweenAnimation.play("TextTween")
		$ShipBeep.play()
		$ShipAISpeech.play()
		Globals.NaomiMessages += 1

	if Input.is_action_just_pressed("Dialogue") and textline == 9:
		$TextboxContainer/MarginContainer/HBoxContainer/Start.set_text("Calihan:")
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("Damn this ship! Why does it never work when I need it to?")
		$TextboxContainer/TweenAnimation.play("TextTween")
		$CalihanSpeed.play()

	if Input.is_action_just_pressed("Dialogue") and textline == 10:
		$TextboxContainer/MarginContainer/HBoxContainer/Start.set_text("Ship_Com")
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("Incoming Attachment.")
		$TextboxContainer/TweenAnimation.play("TextTween")
		$ShipBeep.play()
		$ShipAISpeech.play()

	if Input.is_action_just_pressed("Dialogue") and textline == 11:
		$TextboxContainer/MarginContainer/HBoxContainer/Start.set_text("Calihan:")
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("Coordinates? Naomi... Hold on...")
		$TextboxContainer/TweenAnimation.play("TextTween")
		$CalihanSpeed.play()

	if Input.is_action_just_pressed("Dialogue") and textline == 12:
		Globals.CamText = "Use the ship's controls to choose a destination"
		$".".queue_free()
