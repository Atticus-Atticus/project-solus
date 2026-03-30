extends Control

var textline = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$TextboxContainer/TweenAnimation.play("BlackToFade")
	

func _on_animation_finished(anim_name: StringName) -> void:
	textline += 1
	$CalihanSpeech.stop()
	$NaomiSpeech.stop()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if textline == 1:
		$TextboxContainer/TweenAnimation.play("TextTween")
		$NaomiSpeech.play()
		#NaomiSpeech doesn't play here for some reason.

	if Input.is_action_just_pressed("Dialogue") and textline == 2:
		$TextboxContainer/MarginContainer/HBoxContainer/Label.visible_ratio = 0.0
		$TextboxContainer/MarginContainer/HBoxContainer/Start.set_text("Calihan:")
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("Mhmm...")
		$TextboxContainer/TweenAnimation.play("TextTweenACTUAL")
		$CalihanSpeech.play()

	if Input.is_action_just_pressed("Dialogue") and textline == 3:
		$TextboxContainer/MarginContainer/HBoxContainer/Label.visible_ratio = 0.0
		$TextboxContainer/MarginContainer/HBoxContainer/Start.set_text("Naomi:")
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("You promise to be back as soon as possible?")
		$TextboxContainer/TweenAnimation.play("TextTween")
		$NaomiSpeech.play()

	if Input.is_action_just_pressed("Dialogue") and textline == 4:
		$TextboxContainer/MarginContainer/HBoxContainer/Label.visible_ratio = 0.0
		$TextboxContainer/MarginContainer/HBoxContainer/Start.set_text("Calihan:")
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("Mhmm...")
		$TextboxContainer/TweenAnimation.play("TextTween")
		$CalihanSpeech.play()

	if Input.is_action_just_pressed("Dialogue") and textline == 5:
		Globals.CutScene1Anim = 1
		$TextboxContainer/MarginContainer/HBoxContainer/Label.visible_ratio = 0.0
		$TextboxContainer/MarginContainer/HBoxContainer/Start.set_text("Naomi:")
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("Before you leave...")
		$TextboxContainer/TweenAnimation.play("TextTween")
		$NaomiSpeech.play()

	if Input.is_action_just_pressed("Dialogue") and textline == 6:
		$TextboxContainer/MarginContainer/HBoxContainer/Label.visible_ratio = 0.0
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("We need to talk about something.")
		$TextboxContainer/TweenAnimation.play("TextTween")
		$NaomiSpeech.play()

	if Input.is_action_just_pressed("Dialogue") and textline == 7:
		$TextboxContainer/MarginContainer/HBoxContainer/Label.visible_ratio = 0.0
		$TextboxContainer/MarginContainer/HBoxContainer/Start.set_text("Calihan:")
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("About what?")
		$TextboxContainer/TweenAnimation.play("TextTween")
		$CalihanSpeech.play()

	if Input.is_action_just_pressed("Dialogue") and textline == 8:
		$TextboxContainer/MarginContainer/HBoxContainer/Label.visible_ratio = 0.0
		$TextboxContainer/MarginContainer/HBoxContainer/Start.set_text("Naomi:")
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("Don't worry. It's just a talk.")
		$TextboxContainer/TweenAnimation.play("TextTween")
		$NaomiSpeech.play()

	if Input.is_action_just_pressed("Dialogue") and textline == 9:
		$TextboxContainer/MarginContainer/HBoxContainer/Label.visible_ratio = 0.0
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("Meet me in the bedroom when you're ready.")
		$TextboxContainer/TweenAnimation.play("TextTween")
		$NaomiSpeech.play()

	if Input.is_action_just_pressed("Dialogue") and textline == 10:
		$TextboxContainer.hide()
		Globals.CutScene1Anim = 2
		Globals.PlayerControls = true
		$Timer.start()


func _on_timer_timeout() -> void:
	$TextboxContainer/TweenAnimation.play("FadeToBlack")
