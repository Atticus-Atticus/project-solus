extends StaticBody3D

@export var Root: Node3D


func interact():
	Root._check_code()
	$"../Enter/AnimationPlayer".play("Press")
