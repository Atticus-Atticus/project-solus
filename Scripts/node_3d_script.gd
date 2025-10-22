extends StaticBody3D

func interact():
	$"../CRT Shader Static".show()
	$"../Timer".start()

func _on_timer_timeout() -> void:
	Globals.HallwayLoop += 1
