extends StaticBody3D

@export var text_scene0: PackedScene

@export var player = CharacterBody3D

@export var trigger = Area3D

var in_dialogue = false

func interact():
	if in_dialogue:
		return
	if trigger.monitoring:
		return # already armed
	trigger.monitoring = true

func _show_dialogue():
	if SceneSwitcher.Destination == 0:
		var text1 = text_scene0.instantiate()
		add_child(text1)
		
	if SceneSwitcher.Destination == 1:
		get_tree().change_scene_to_file("res://Scenes/Levels/Abandoned_Ship.tscn")
		player.get_player_pos()
		#$AnimationPlayerObjective.stop()
		
	if SceneSwitcher.Destination == 2:
		get_tree().change_scene_to_file("res://Scenes/Levels/Brimpie_Orbital.tscn")
		player.get_player_pos()
		#$AnimationPlayerObjective.stop()
	#Globals.NaomiOnShip = true
