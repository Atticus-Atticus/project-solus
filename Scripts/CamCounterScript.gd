extends Label

var last_text := ""


func _ready() -> void:
	update_cam_text()


func _process(delta: float) -> void:
	if Globals.CamText != last_text:
		update_cam_text()

	if Globals.CamText == "Ship Cam":
		$".".hide()
	else:
		$".".show()

func update_cam_text() -> void:
	last_text = Globals.CamText
	text = Globals.CamText
