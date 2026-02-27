extends Node

var textline = 0
#0 = line 1
#1 = line 2
#2 = line 3
#3 = clear textbox

func _ready() -> void:
	$TextboxContainer/TweenAnimation.play("TextTween")
	$ShipAISpeech.play()
	Globals.PlayerControls = false

func _on_tween_animation_animation_finished(anim_name: StringName) -> void:
	textline += 1
	$ShipAISpeech.stop()


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Dialogue") and textline == 1:
		$TextboxContainer/MarginContainer/HBoxContainer/Start.set_text("GiGi:")
		$TextboxContainer/MarginContainer/HBoxContainer/Label.text = ("Welcome, ") + UserManager.current_username + (". My name is GiGi. Your Personal artificial intelligence assistant.")
		$TextboxContainer/TweenAnimation.play("TextTween")
		$ShipAISpeech.play()

	if Input.is_action_just_pressed("Dialogue") and textline == 2:
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("I'm here to assist you with viewing and navigating decomplied Neurological Blackbox data.")
		$TextboxContainer/TweenAnimation.play("TextTween")
		$ShipAISpeech.play()


	if Input.is_action_just_pressed("Dialogue") and textline == 3:
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("This simulation has been set up to calibrate and prepare you for the viewing of Blackbox data.")
		$TextboxContainer/TweenAnimation.play("TextTween")
		$ShipAISpeech.play()

	if Input.is_action_just_pressed("Dialogue") and textline == 4:
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("You can use the Left Mouse Button to select a location to move to. Please take some time getting used to moving around.")
		$TextboxContainer/TweenAnimation.play("TextTween")
		$ShipAISpeech.play()


	if Input.is_action_just_pressed("Dialogue") and textline == 5:
		Globals.PlayerControls = true
		Globals.CamText = "Tutoral."
		$".".queue_free()
