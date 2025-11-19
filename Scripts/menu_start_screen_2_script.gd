extends Control

@onready var cursor = $ProjectSolusCursor2

func _ready() -> void:
	Engine.max_fps = 30
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Enter"):
		get_tree().change_scene_to_file("res://Scenes/User Interface/Menus/MenuStartScreen.tscn")

	cursor.position = get_global_mouse_position()

	if Globals.InputType == false:
		$StartUpText.text = "
> 
> 
> Please select a control method...
>
>
>
>
> 
>
>
> Tank controls are recommended...
>
> Use 'W' to move Forward. Use 'S' to move Backwards.
> Use 'A' to rotate Left. Use 'D' to rotate Right.
> Use 'E' to interact with objects that pulse blue.
>
> Press ENTER to continue...
>
"
	else:
		$StartUpText.text = "
> 
> 
> Please select a control method...
>
>
>
>
> 
>
>
> Tank controls are recommended...
>
> Use 'W' to move Forward. Use 'S' to move Backwards.
> The Subject will always face and move towards the mouse's position
> Use 'E' to interact with objects that pulse blue.
>
> Press ENTER to continue...
>
>"

func _on_change_menu_sfx_tree_exited() -> void:
	$MenuSFX.stop()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	$ColorRect4.show()
	$ColorRect4/AnimationPlayer.play("FlashingSquare")
