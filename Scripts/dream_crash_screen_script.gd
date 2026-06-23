extends Control


func _ready() -> void:
	$ColorRect.hide()
	var roll = randi() % 500 + 1
	print(roll)
	if roll == 250:
		$StartUpText.set_text("












Something has gone wrong. 
Very very wrong.

If this is the first time you've seen this error screen, stop and take a moment to appreciate how lucky you are to get a 1 in 500 chance hidden screen. 
If this screen appears again, follow these steps:

Make sure the device has power.
Turn it off and on again.
Say you're sorry for making the device work too hard.
Hope and pray that a patch is released soon.


Technical information:
*** STOP: 0x534F4C5553


WARNING:
Further playback crashes may cause permanent observer cognitive damage.



Press ENTER to attempt restart.")
	else:
		$StartUpText.set_text("












Blackbox memory playback has encountered a critical error and system has been shut down to prevent damage.

If this is the first time you've seen this error screen, restart the system. 
If this screen appears again, follow these steps:

Check to make sure any hardware or software is properly installed.
Contact a registered NBB technician.


Technical information:
*** STOP: 0x534F4C5553


WARNING:
Further playback crashes may cause permanent observer cognitive damage.



Press ENTER to attempt restart.")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Enter"):
		$ColorRect2/AnimationPlayer.play("FadeToBlack")


func _on_change_menu_sfx_tree_exited() -> void:
	$MenuSFX.stop()

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	$ColorRect/AnimationPlayer.play("FlashingSquare")

func _on_animation_finished(anim_name: StringName) -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/Calihan_Ship_Cutscene.tscn")
