extends Node

var code = "0000"

#func _process(delta: float) -> void:
	#if Input.is_action_just_pressed("Debug"):
		#_generate_code()

func _generate_code():
	var random_code = "%04d" % randi_range(0, 9999)
	code = random_code
	print(code)
