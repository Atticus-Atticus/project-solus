extends Control



# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	match SceneSwitcher.Destination:
		1:
			$Label2.set_text("R.C.S Talbot

'R' to cancel
docking.")
		2:
			$Label2.set_text("Brimpie Orbital

'R' to cancel
docking.")
		3:
			$Label2.set_text("The Avalon System

'R' to cancel
journey.")
		_:
			$Label2.set_text("None")

	if Input.is_action_just_pressed("R_Key"):
		$Label2.set_text("None")
		SceneSwitcher.Destination = 0
