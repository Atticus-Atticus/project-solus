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
#10 = line 11
#11 = clear textbox

func _ready() -> void:
	$TextboxContainer/TweenAnimation.play("TextTween")
	$ShipAISpeech.play()
	Globals.PlayerControls = false

func _on_tween_animation_animation_finished(anim_name: StringName) -> void:
	textline += 1
	$CalihanSpeech.stop()
	$ShipAISpeech.stop()
	$ShipBeep.stop()
	$SpacerSpeech.stop()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Dialogue") and textline == 1:
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("Estimated travel time: 14 Cycles")
		$TextboxContainer/TweenAnimation.play("TextTween")
		$ShipAISpeech.play()

	if Input.is_action_just_pressed("Dialogue") and textline == 2:
		$TextboxContainer/MarginContainer/HBoxContainer/Start.set_text("Calihan:")
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("*Sigh of relief* I'll see you soon, Naomi.")
		$TextboxContainer/TweenAnimation.play("TextTween")
		$CalihanSpeech.play()

	if Input.is_action_just_pressed("Dialogue") and textline == 3:
		$TextboxContainer/MarginContainer/HBoxContainer/Start.set_text("Ship_Com:")
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("2 new contacts detected")
		$TextboxContainer/TweenAnimation.play("TextTween")
		$ShipBeep.play()
		$ShipAISpeech.play()

	if Input.is_action_just_pressed("Dialogue") and textline == 4:
		$TextboxContainer/MarginContainer/HBoxContainer/Start.set_text("Calihan:")
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("WHAT!?")
		$TextboxContainer/TweenAnimation.play("TextTween")
		$CalihanSpeech.play()

	if Input.is_action_just_pressed("Dialogue") and textline == 5:
		$TextboxContainer/MarginContainer/HBoxContainer/Start.set_text("Unknown:")
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("Hey Hey Farseeing Courier. Do you have a package for us?")
		$TextboxContainer/TweenAnimation.play("TextTween")
		$SpacerSpeech.play()

	if Input.is_action_just_pressed("Dialogue") and textline == 6:
		$TextboxContainer/MarginContainer/HBoxContainer/Start.set_text("Ship_Com:")
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("Alert. Weapons lock detected.")
		$TextboxContainer/TweenAnimation.play("TextTween")
		$ShipBeep.play()
		$ShipAISpeech.play()

	if Input.is_action_just_pressed("Dialogue") and textline == 7:
		$TextboxContainer/MarginContainer/HBoxContainer/Start.set_text("Calihan:")
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("No. No. No!")
		$TextboxContainer/TweenAnimation.play("TextTween")
		$CalihanSpeech.play()

	if Input.is_action_just_pressed("Dialogue") and textline == 8:
		$TextboxContainer/MarginContainer/HBoxContainer/Start.set_text("Ship_Com:")
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("Projectile launch detected. Impact alert.")
		$TextboxContainer/TweenAnimation.play("TextTween")
		$ShipAISpeech.play()
		$Alarm.play()

	if Input.is_action_just_pressed("Dialogue") and textline == 9:
		Globals.StoryStage += 1
		Globals.PlayerControls = true
		$".".queue_free()
		
