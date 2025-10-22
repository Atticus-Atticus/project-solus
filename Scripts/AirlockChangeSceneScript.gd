extends StaticBody3D

@onready var text_scene0: PackedScene = preload("res://Scenes/User Interface/Dialogue/NoAirlockDialogueBox.tscn")

func interact():
	if SceneSwitcher.Destination == 0:
		var text1 = text_scene0.instantiate()
		add_child(text1)
		
	if SceneSwitcher.Destination == 1:
		get_tree().change_scene_to_file("res://Scenes/Levels/Abandoned_Ship.tscn")
		$AnimationPlayerObjective.stop()
		
	if SceneSwitcher.Destination == 2:
		get_tree().change_scene_to_file("res://Scenes/Levels/Brimpie_Orbital.tscn")
		$AnimationPlayerObjective.stop()

	Globals.NaomiOnShip = true
