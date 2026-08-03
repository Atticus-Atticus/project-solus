extends Area3D

func enter_trigger(body):
#body is the object that has entered the trigger
	if body is CharacterBody3D:
		get_parent().character = body
		get_parent().in_trigger = true
		$AudioStreamPlayer.play()
		$"CRT Shader Static".show()
		await get_tree().create_timer(0.2).timeout
		$"CRT Shader Static".hide()
		get_parent()._make_cam_current()
#change varibles in CameraModelScript

func exit_trigger(body):
#body is the object that has exited the trigger
	if body is CharacterBody3D:
		get_parent().character = null
		get_parent().in_trigger = false
#change varibles in CameraModelScript
