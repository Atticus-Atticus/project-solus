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
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("Radio: *STATIC* Ca...lihan...?")
		$TextboxContainer/TweenAnimation.play("TextTween")
		$RadioStatic.play()

	if Input.is_action_just_pressed("Dialogue") and textline == 2:
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("Calihan: Naomi?")
		$TextboxContainer/TweenAnimation.play("TextTween")
		$CalihanSpeed.play()

	if Input.is_action_just_pressed("Dialogue") and textline == 3:
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("Radio: *STATIC* ...come...home...")
		$TextboxContainer/TweenAnimation.play("TextTween")
		$NaomiSpeech.play()

	if Input.is_action_just_pressed("Dialogue") and textline == 4:
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("Calihan: I... I can't. Our home is gone. Where are you and I'll-")
		$TextboxContainer/TweenAnimation.play("TextTween")
		$CalihanSpeed.play()

	if Input.is_action_just_pressed("Dialogue") and textline == 5:
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("Radio: *STATIC* ...new... home... here... with me...")
		$TextboxContainer/TweenAnimation.play("TextTween")
		$NaomiSpeech.play()

	if Input.is_action_just_pressed("Dialogue") and textline == 6:
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("Calihan: Naomi, please. Where are you?")
		$TextboxContainer/TweenAnimation.play("TextTween")
		$CalihanSpeed.play()

	if Input.is_action_just_pressed("Dialogue") and textline == 7:
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("Radio: *STATIC*")
		$TextboxContainer/TweenAnimation.play("TextTween")
		$NaomiSpeech.play()

	if Input.is_action_just_pressed("Dialogue") and textline == 8:
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("Ship AI: Closing Comms Channel")
		$TextboxContainer/TweenAnimation.play("TextTween")
		$ShipBeep.play()
		$ShipAISpeech.play()
		$RadioStatic.stop()

	if Input.is_action_just_pressed("Dialogue") and textline == 9:
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("Calihan: Damn this ship! Why does it never work when I need it to?")
		$TextboxContainer/TweenAnimation.play("TextTween")
		$CalihanSpeed.play()

	if Input.is_action_just_pressed("Dialogue") and textline == 10:
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("Ship AI: Incoming Attachment.")
		$TextboxContainer/TweenAnimation.play("TextTween")
		$ShipBeep.play()
		$ShipAISpeech.play()

	if Input.is_action_just_pressed("Dialogue") and textline == 11:
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("Calihan: Coordinates? Naomi... Hold on...")
		$TextboxContainer/TweenAnimation.play("TextTween")
		$CalihanSpeed.play()

	if Input.is_action_just_pressed("Dialogue") and textline == 12:
		Globals.CamText = "Use the ship's controls to choose a destination"
		Globals.PlayerControls = true
		$".".queue_free()
