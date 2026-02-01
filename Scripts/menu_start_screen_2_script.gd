extends Control

@onready var cursor = $ProjectSolusCursor2

func _ready() -> void:
	#Engine.max_fps = 30
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

	if Globals.TutorialComplete == true:
		$"Panel/Tutorial Finished".text("Complete")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Enter"):
		#get_tree().change_scene_to_file("res://Scenes/User Interface/Menus/MenuStartScreen.tscn")
		get_tree().change_scene_to_file("res://Scenes/Levels/DreamCutscene1.tscn")

	cursor.position = get_global_mouse_position()

	#if Globals.InputType == 1:
		#$StartUpText.text = "
#> 
#> 
#> Please select a control method...
#>
#>
#>
#>
#> 
#>
#>
#>
#> Use 'W' to move Forward. Use 'S' to preform a quick turn.
#> Use 'A' to rotate Left. Use 'D' to rotate Right.
#> Use 'E' to interact with objects that pulse blue.
#>
#> Objects that glow green will progress the subject's memory.
#> Please ignore any hallucinatory overalls that may be present.
#>
#> Press ENTER to continue...
#>"
	#if Globals.InputType == 2:
		#$StartUpText.text = "
#> 
#> 
#> Please select a control method...
#>
#>
#>
#>
#> 
#>
#>
#>
#> Use 'W' to move Forward. Use 'S' to move Backwards.
#> The Subject will always face and move towards the mouse's position
#> Use 'E' to interact with objects that pulse blue.
#>
#> Objects that glow green will progress the subject's memory.
#> Please ignore any hallucinatory overalls that may be present.
#>
#> Press ENTER to continue...
#>"
	#if Globals.InputType == 3:
		#$StartUpText.text = "
#> 
#> 
#> Please select a control method...
#>
#>
#>
#>
#> 
#>
#>
#>
#> Use 'W' to move away from Camera. Use 'S' to move towards Camera.
#> Use 'A' to move Left. Use 'D' to move Right.
#> Use 'E' to interact with objects that pulse blue.
#>
#> Objects that glow green will progress the subject's memory.
#> Please ignore any hallucinatory overalls that may be present.
#>
#> Press ENTER to continue...
#>"

func _on_change_menu_sfx_tree_exited() -> void:
	$MenuSFX.stop()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	$ColorRect4.show()
	$ColorRect4/AnimationPlayer.play("FlashingSquare")
