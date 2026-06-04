extends StaticBody3D

var switch = false
@export var root = Node3D

func interact():
	if Globals.radio_freq == 0:
		pass
	else:
		switch = true
		Globals.radio_freq -= 1
		await get_tree().create_timer(0.1).timeout
		switch = false
		root.update_marker_position()

func _process(delta: float) -> void:
	if switch == true:
		$OmniLight3D.show()
	else:
		$OmniLight3D.hide()
