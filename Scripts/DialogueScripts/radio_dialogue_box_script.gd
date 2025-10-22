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
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("Radio: *STATIC*")
		$TextboxContainer/TweenAnimation.play("TextTween")
		$RadioStatic.play()

	if Input.is_action_just_pressed("Dialogue") and textline == 2:
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("Calihan: As I thought. Just an old buffer...")
		$TextboxContainer/TweenAnimation.play("TextTween")
		$CalihanSpeed.play()

	if Input.is_action_just_pressed("Dialogue") and textline == 3:
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("Radio: *STATIC* Calihan?")
		$TextboxContainer/TweenAnimation.play("TextTween")
		$NaomiSpeech.play()

	if Input.is_action_just_pressed("Dialogue") and textline == 4:
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("Calihan: *gasp* Na-Naomi?")
		$TextboxContainer/TweenAnimation.play("TextTween")
		$CalihanSpeed.play()

	if Input.is_action_just_pressed("Dialogue") and textline == 5:
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("Radio: *STATIC* Calihan...")
		$TextboxContainer/TweenAnimation.play("TextTween")
		$NaomiSpeech.play()

	if Input.is_action_just_pressed("Dialogue") and textline == 6:
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("Calihan: Naomi... I... I thought I lost you.")
		$TextboxContainer/TweenAnimation.play("TextTween")
		$CalihanSpeed.play()

	if Input.is_action_just_pressed("Dialogue") and textline == 7:
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("Radio: *STATIC* Come home, Calihan...")
		$TextboxContainer/TweenAnimation.play("TextTween")
		$NaomiSpeech.play()

	if Input.is_action_just_pressed("Dialogue") and textline == 8:
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("Calihan: Naomi, our home is... I... I can come back and get you out.")
		$TextboxContainer/TweenAnimation.play("TextTween")
		$CalihanSpeed.play()

	if Input.is_action_just_pressed("Dialogue") and textline == 9:
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("Calihan: Just hold on. I'll be there in-")
		$TextboxContainer/TweenAnimation.play("TextTween")
		$CalihanSpeed.play()

	if Input.is_action_just_pressed("Dialogue") and textline == 10:
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("Radio: *STATIC* no...")
		$TextboxContainer/TweenAnimation.play("TextTween")
		$NaomiSpeech.play()

	if Input.is_action_just_pressed("Dialogue") and textline == 11:
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("Radio: *STATIC* come to... new home...")
		$TextboxContainer/TweenAnimation.play("TextTween")
		$NaomiSpeech.play()

	if Input.is_action_just_pressed("Dialogue") and textline == 12:
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("Radio: *STATIC* to... me...")
		$TextboxContainer/TweenAnimation.play("TextTween")
		$NaomiSpeech.play()

	if Input.is_action_just_pressed("Dialogue") and textline == 13:
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("Radio: *STATIC* Calihan... My Love...")
		$TextboxContainer/TweenAnimation.play("TextTween")
		$NaomiSpeech.play()

	if Input.is_action_just_pressed("Dialogue") and textline == 14:
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("Calihan: Naomi, My Star...")
		$TextboxContainer/TweenAnimation.play("TextTween")
		$CalihanSpeed.play()

	if Input.is_action_just_pressed("Dialogue") and textline == 15:
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("Calihan: Please. Tell me where you are and I'll come to you.")
		$TextboxContainer/TweenAnimation.play("TextTween")
		$CalihanSpeed.play()

	if Input.is_action_just_pressed("Dialogue") and textline == 16:
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("Radio: *STATIC*")
		$TextboxContainer/TweenAnimation.play("TextTween")

	if Input.is_action_just_pressed("Dialogue") and textline == 17:
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("Calihan: Naomi?")
		$TextboxContainer/TweenAnimation.play("TextTween")
		$CalihanSpeed.play()

	if Input.is_action_just_pressed("Dialogue") and textline == 18:
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("Radio: *STATIC*")
		$TextboxContainer/TweenAnimation.play("TextTween")

	if Input.is_action_just_pressed("Dialogue") and textline == 19:
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("Ship AI: Closing Comms Channel")
		$TextboxContainer/TweenAnimation.play("TextTween")
		$ShipBeep.play()
		$ShipAISpeech.play()
		$RadioStatic.stop()

	if Input.is_action_just_pressed("Dialogue") and textline == 20:
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("Calihan: Damn this ship! Why does it never work when I need it to?")
		$TextboxContainer/TweenAnimation.play("TextTween")
		$CalihanSpeed.play()

	if Input.is_action_just_pressed("Dialogue") and textline == 21:
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("Ship AI: Incoming Attachment.")
		$TextboxContainer/TweenAnimation.play("TextTween")
		$ShipBeep.play()
		$ShipAISpeech.play()

	if Input.is_action_just_pressed("Dialogue") and textline == 22:
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("Calihan: Coordinates? Is that where you are, Naomi?")
		$TextboxContainer/TweenAnimation.play("TextTween")
		$CalihanSpeed.play()

	if Input.is_action_just_pressed("Dialogue") and textline == 23:
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("Calihan: I'll be there soon. I promise.")
		$TextboxContainer/TweenAnimation.play("TextTween")
		$CalihanSpeed.play()

	if Input.is_action_just_pressed("Dialogue") and textline == 24:
		Globals.CamText = "Use the ship's controls to choose a destination"
		Globals.PlayerControls = true
		$".".queue_free()
