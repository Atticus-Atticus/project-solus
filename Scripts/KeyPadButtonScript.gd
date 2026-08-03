extends StaticBody3D

@export var Number: String = "0"
@export var Root: Node3D


func interact():
	if Root.Code.length() >= Root.Max_Code_Length:
		return
	
	Root.Code += Number
	Root._update_label()
	print(Number, " Entered")
