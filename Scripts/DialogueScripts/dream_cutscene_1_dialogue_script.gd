extends Node

var textline = 0

func _ready() -> void:
	$TextboxContainer/TweenAnimation.play("TextTween2")
	Globals.PlayerControls = false

func _on_tween_animation_animation_finished(anim_name: StringName) -> void:
	textline += 1
	$CalihanSpeech.stop()
	$NaomiSpeech.stop()

func _process(delta: float) -> void:
	if textline == 1:
		$TextboxContainer/TweenAnimation.play("TextTweenACTUAL")
		$NaomiSpeech.play()
		$NaomiSpeech.play()

	if Input.is_action_just_pressed("Dialogue") and textline == 2:
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("Calihan: Mhmm...")
		$TextboxContainer/TweenAnimation.play("TextTweenACTUAL")
		$CalihanSpeech.play()

	if Input.is_action_just_pressed("Dialogue") and textline == 3:
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("Naomi: You promise to be back as soon as possible?")
		$TextboxContainer/TweenAnimation.play("TextTweenACTUAL")
		$NaomiSpeech.play()

	if Input.is_action_just_pressed("Dialogue") and textline == 4:
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("Calihan: Mhmm...")
		$TextboxContainer/TweenAnimation.play("TextTweenACTUAL")
		$CalihanSpeech.play()

	if Input.is_action_just_pressed("Dialogue") and textline == 5:
		Globals.CutScene1Anim = 1
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("Naomi: Before you leave...")
		$TextboxContainer/TweenAnimation.play("TextTweenACTUAL")
		$NaomiSpeech.play()

	if Input.is_action_just_pressed("Dialogue") and textline == 6:
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("Naomi: We need to talk about something.")
		$TextboxContainer/TweenAnimation.play("TextTweenACTUAL")
		$NaomiSpeech.play()

	if Input.is_action_just_pressed("Dialogue") and textline == 7:
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("Calihan: About what?")
		$TextboxContainer/TweenAnimation.play("TextTweenACTUAL")
		$CalihanSpeech.play()

	if Input.is_action_just_pressed("Dialogue") and textline == 8:
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("Naomi: Don't worry. It's just a talk.")
		$TextboxContainer/TweenAnimation.play("TextTweenACTUAL")
		$NaomiSpeech.play()

	if Input.is_action_just_pressed("Dialogue") and textline == 9:
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("Naomi: Meet me in the bedroom when you're ready.")
		$TextboxContainer/TweenAnimation.play("TextTweenACTUAL")
		$NaomiSpeech.play()

	if Input.is_action_just_pressed("Dialogue") and textline == 10:
		$TextboxContainer.hide()
		Globals.CutScene1Anim = 2
		Globals.PlayerControls = true
		$Timer.start()


func _on_timer_timeout() -> void:
	$TextboxContainer/TweenAnimation.play("ScreenTween")
