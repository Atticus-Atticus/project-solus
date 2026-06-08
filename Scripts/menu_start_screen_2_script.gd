extends Control

@onready var cursor = $ProjectSolusCursor2

func _ready() -> void:
	#Engine.max_fps = 30
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

	if Globals.TutorialComplete == true:
		$"Panel/Tutorial Finished".text("Complete")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#if Input.is_action_just_pressed("Enter"):
		#get_tree().change_scene_to_file("res://Scenes/Levels/DreamCutscene1.tscn")

	cursor.position = get_global_mouse_position()


func _on_change_menu_sfx_tree_exited() -> void:
	$MenuSFX.stop()





func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/DreamCutscene1.tscn")
	Globals.StoryStage += 1

func _on_button_mouse_entered() -> void:
	$CalihanPanel/Button.set_text(">> View subject's memories <<")


func _on_button_mouse_exited() -> void:
	$CalihanPanel/Button.set_text("> View subject's memories <")
