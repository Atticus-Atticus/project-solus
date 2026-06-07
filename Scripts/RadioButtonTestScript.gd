extends StaticBody3D

var switch = false
@export var root = Node3D
@export var freq_cylinder: Node3D

func interact():
	if Globals.radio_freq < 200:
		Globals.radio_freq += 1
		freq_cylinder.rotate_x(deg_to_rad(5.0))
		root.update_marker_position()
	else:
		pass
