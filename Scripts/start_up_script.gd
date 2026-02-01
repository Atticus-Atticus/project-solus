extends Control

@onready var cursor = $ProjectSolusCursor2
@onready var button = $Login/Panel/EnterButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Login.hide()
	cursor.hide()

	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

func _process(delta: float) -> void:
	cursor.position = get_global_mouse_position()

var has_started := false

func _unhandled_input(event: InputEvent) -> void:
	if has_started:
		return
		
	if event is InputEventMouseMotion:
		return
		
	if event.is_pressed():
		has_started = true
		cursor.show()
		_start_up()

func _start_up():
	$"Blank Background".hide()
	$AnimationPlayer.play("StartUp")
	$StartUpSFX.play()


func _on_start_up_sfx_finished() -> void:
	$MenuSFX.play()


func _on_enter_button_mouse_entered() -> void:
	button.set_text(">> Enter <<")


func _on_enter_button_mouse_exited() -> void:
	button.set_text("> Enter <")


func _on_enter_button_pressed() -> void:
	UserManager.process_entered_username($"Login/Panel/LineEdit User".text)
	get_tree().change_scene_to_file("res://Scenes/User Interface/Menus/MainMenu.tscn")
