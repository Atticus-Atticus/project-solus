extends Node


var textline = 0

func _ready() -> void:
	$TextboxContainer/TweenAnimation.play("TextTween")
	$CalihanSpeech.play()
	Globals.PlayerControls = false

func _on_tween_animation_animation_finished(anim_name: StringName) -> void:
	textline += 1
	$CalihanSpeech.stop()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Dialogue") and textline == 1:
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("* After Earth's old governments fell, the Terran Parliament rose from the ashes and lifted humanity to the stars.")
		$TextboxContainer/TweenAnimation.play("TextTween")


	if Input.is_action_just_pressed("Dialogue") and textline == 2:
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("* Humanity took its place among the stars. But under the rule of the Terran Parliament, became fractured and weak. And humamity suffered suffered for it.")
		$TextboxContainer/TweenAnimation.play("TextTween")

	if Input.is_action_just_pressed("Dialogue") and textline == 3:
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("* After a series of failed rebellions against the Terran Parliament, a handful of small systems from unified to form the Solarian Coalition.")
		$TextboxContainer/TweenAnimation.play("TextTween")

	if Input.is_action_just_pressed("Dialogue") and textline == 4:
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("* In the end, the Solarian Coalition stood above all and became the leaders humanity needed. Placing prosperity above all.")
		$TextboxContainer/TweenAnimation.play("TextTween")

	if Input.is_action_just_pressed("Dialogue") and textline == 5:
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("Calihan: Long Live the Coalition.")
		$TextboxContainer/TweenAnimation.play("TextTween")
		$CalihanSpeech.play()

	if Input.is_action_just_pressed("Dialogue") and textline == 6:
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("Calihan: The rest of us just get to watch.")
		$TextboxContainer/TweenAnimation.play("TextTween")
		$CalihanSpeech.play()

	if Input.is_action_just_pressed("Dialogue") and textline == 7:
		Globals.PlayerControls = true
		$".".queue_free()
