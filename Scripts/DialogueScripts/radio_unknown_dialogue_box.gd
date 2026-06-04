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
	$ShipAISpeech.stop()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Dialogue") and textline == 1:
		$TextboxContainer/MarginContainer/HBoxContainer/Start.set_text("Radio:")
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("...")
		$TextboxContainer/TweenAnimation.play("TextTween")
		$Morse.play()

	if Input.is_action_just_pressed("Dialogue") and textline == 2:
		Globals.PlayerControls = true
		$".".queue_free()
