extends Node

var textline = 0
#0 = line 1
#1 = line 2
#2 = line 3
#3 = line 4
#4 = clear textbox

func _ready() -> void:
	$TextboxContainer/TweenAnimation.play("TextTween")
	$CalihanSpeed.play()
	Globals.PlayerControls = false

func _on_tween_animation_animation_finished(anim_name: StringName) -> void:
	textline += 1
	$CalihanSpeed.stop()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Dialogue") and textline == 1:
		$TextboxContainer/MarginContainer/HBoxContainer/Label.set_text("Calihan: Hold on, Naomi. I'll be there soon.")
		$TextboxContainer/TweenAnimation.play("TextTween")
		$CalihanSpeed.play()

	if Input.is_action_just_pressed("Dialogue") and textline == 2:
		Globals.CamText = "Use the ship's controls to travel to the next system"
		Globals.PlayerControls = true
		#Globals.StoryStage += 1
		$".".queue_free()
