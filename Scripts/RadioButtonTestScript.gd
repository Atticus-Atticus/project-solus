extends StaticBody3D

var switch = false

func interact():
	switch = true
	Globals.radio_freq += 1
	await get_tree().create_timer(0.1).timeout
	switch = false

func _process(delta: float) -> void:
	if switch == true:
		$"../OmniLight3D".show()
	else:
		$"../OmniLight3D".hide()
