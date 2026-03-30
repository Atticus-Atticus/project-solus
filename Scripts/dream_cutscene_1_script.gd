extends Node3D

@onready var LoadText: PackedScene = preload("res://Scenes/User Interface/Dialogue/DreamCutscene1Dialogue.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#var LoadedText = LoadText.instantiate()
	#add_child(LoadedText)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Globals.CutScene1Finished == 1:
		get_tree().change_scene_to_file("res://Scenes/Levels/Dream_Level.tscn")

	if Input.is_action_just_pressed("Skip"):
		get_tree().change_scene_to_file("res://Scenes/Levels/Dream_Level.tscn")
