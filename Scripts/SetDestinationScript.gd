extends StaticBody3D

func interact():
	if Globals.active == true:
		$Control.set_visible(true)
#shows ChooseDesintationUI
