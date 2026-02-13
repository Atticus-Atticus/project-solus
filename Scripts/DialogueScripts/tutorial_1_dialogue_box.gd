extends Node

var textline = 0
#0 = line 1
#1 = line 2
#2 = line 3
#3 = clear textbox

func _ready() -> void:
	$TextboxContainer/MarginContainer/HBoxContainer/Label.text = ("* Welcome, ") + UserManager.current_username + (", to the Neurological Blackbox Virtual Simulator.")
	$TextboxContainer/TweenAnimation.play("TextTween")
	$ShipAISpeech.play()
	Globals.PlayerControls = false

func _on_tween_animation_animation_finished(anim_name: StringName) -> void:
	textline += 1
	$ShipAISpeech.stop()


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Dialogue") and textline == 1:
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("* This simulation is used to calibrate and prepare you for the viewing of Blackbox Data.")
		$TextboxContainer/TweenAnimation.play("TextTween")
		$ShipAISpeech.play()

	if Input.is_action_just_pressed("Dialogue") and textline == 2:
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("* Please take your time to get used to moving around.")
		$TextboxContainer/TweenAnimation.play("TextTween")
		$ShipAISpeech.play()

	if Input.is_action_just_pressed("Dialogue") and textline == 3:
		Globals.PlayerControls = true
		Globals.CamText = "Tutoral."
		$".".queue_free()
