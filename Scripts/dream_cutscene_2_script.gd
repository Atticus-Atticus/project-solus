extends Node3D

@onready var ErrorScreen: PackedScene = preload("res://Scenes/User Interface/ErrorScreen.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(14.5333).timeout
	var Loaded = ErrorScreen.instantiate()
	add_child(Loaded)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Skip"):
		get_tree().change_scene_to_file("res://Scenes/User Interface/Menus/DreamCrashScreen.tscn")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	#var Loaded = ErrorScreen.instantiate()
	#add_child(Loaded)
	#await get_tree().create_timer(14.5333).timeout
	get_tree().change_scene_to_file("res://Scenes/User Interface/Menus/DreamCrashScreen.tscn")
