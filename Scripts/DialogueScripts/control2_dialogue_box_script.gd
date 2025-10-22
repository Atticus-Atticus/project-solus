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
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("Calihan: Would it of been too much of an expense for an actual flight seat?")
		$TextboxContainer/TweenAnimation.play("TextTween")
		$CalihanSpeed.play()

	if Input.is_action_just_pressed("Dialogue") and textline == 2:
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("Calihan: eh, I can't complain too much. They did bolt  it to the floor for me.")
		$TextboxContainer/TweenAnimation.play("TextTween")
		$CalihanSpeed.play()

	if Input.is_action_just_pressed("Dialogue") and textline == 3:
		Globals.PlayerControls = true
		$".".queue_free()
