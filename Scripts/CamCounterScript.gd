extends Label

func _process(delta: float) -> void:
	$"../CamLabel".set_text(Globals.CamText)
