extends Node

var textline = 0

func _ready() -> void:
	$TextboxContainer/TweenAnimation.play("TextTween")
	Globals.PlayerControls = false

func _on_tween_animation_animation_finished(anim_name: StringName) -> void:
	textline += 1

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Dialogue") and textline == 1:
		Globals.KeysFound += 1
		Globals.PlayerControls = true
		$".".queue_free()
