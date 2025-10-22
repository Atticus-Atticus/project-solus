extends StaticBody3D

var switch = false

func interact():
	switch = true
	Globals.radio_freq += 1

func _process(delta: float) -> void:
	if switch == false:
		$"../OmniLight3D".hide()
	else:
		$"../OmniLight3D".show()
