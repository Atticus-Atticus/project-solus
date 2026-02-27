extends Node

var textline = 0
#0 = line 1
#1 = line 2
#2 = line 3
#3 = clear textbox

func _ready() -> void:
	$TextboxContainer/TweenAnimation.play("TextTween")
	$CalihanSpeed.play()
	Globals.PlayerControls = false

func _on_tween_animation_animation_finished(anim_name: StringName) -> void:
	textline += 1
	$CalihanSpeed.stop()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Dialogue") and textline == 1:
		$TextboxContainer.hide()
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("...")
		$TextboxContainer/TweenAnimation.play("TextTween")
		$Scream.play()

	if Input.is_action_just_pressed("Dialogue") and textline == 2:
		$TextboxContainer.show()
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("Nevermind. Time to go.")
		$TextboxContainer/TweenAnimation.play("TextTween")
		$CalihanSpeed.play()
		

	if Input.is_action_just_pressed("Dialogue") and textline == 3:
		Globals.CamText = "Return to your ship"
		Globals.PlayerControls = true
		$".".queue_free()

func _on_scream_finished() -> void:
		$TextboxContainer.show()
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("Nevermind. Time to go.")
		$TextboxContainer/TweenAnimation.play("TextTween")
		$CalihanSpeed.play()
