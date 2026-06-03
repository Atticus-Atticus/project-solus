extends Control



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if SceneSwitcher.Destination == 1:
		$Label2.set_text("R.C.S Talbot

'R' to cancel
docking.")

	elif SceneSwitcher.Destination == 2:
		$Label2.set_text("Brimpie Orbital

'R' to cancel
docking.")

	else:
		$Label2.set_text("None")

	if Input.is_action_just_pressed("R_Key"):
		$Label2.set_text("None")
		SceneSwitcher.Destination = 0
