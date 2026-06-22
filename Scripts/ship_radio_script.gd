extends Node3D

var signals_array := [113, 50, 182, 69]

@onready var text_scene1: PackedScene = preload("res://Scenes/User Interface/Dialogue/RadioDialogueBox.tscn")

@onready var signal_display = $"Freq Screen/SubViewport/Control2/Label4"
@export var radio_screen = Label
@export var marker = Control

@export var freq_cylinder: Node3D

@export var min_freq: float = 0.0
@export var max_freq: float = 200.0

@export var marker_left_x: float = 40.0
@export var marker_right_x: float = 1240.0

var message_up = false
var in_area = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_marker_position()
	signal_display.set_text("No Signal Detected")

	if Globals.NaomiMessages != 0:
		$"Freq Screen/SubViewport/Control2/NaomiSignal".hide()
		signals_array[0] = 999

	$"Automated Signal".volume_db = -80
	$"Morse Signal".volume_db = -80
	$"Morse Signal2".volume_db = -80

	$"CRT Shader Static".show()
	await get_tree().create_timer(0.2).timeout
	$"CRT Shader Static".hide()


func _on_button_freq_mouse_entered() -> void:
	in_area = true


func _on_button_freq_mouse_exited() -> void:
	in_area = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	radio_screen.text = str(Globals.radio_freq)

	if Globals.radio_freq == signals_array[0] and Globals.NaomiMessages == 0 and message_up == false:
		signal_display.set_text("Long Range Comm")
		var text1 = text_scene1.instantiate()
		add_child(text1)
		Globals.StoryStage += 1
		message_up = true

	if Globals.NaomiMessages != 0:
		$"Freq Screen/SubViewport/Control2/NaomiSignal".hide()
		signals_array[0] = 999

	if Globals.radio_freq == signals_array[1]:
		$"Automated Signal".volume_db = 0
		signal_display.set_text("Automated Broadcast")
	else:
		$"Automated Signal".volume_db = -80

	if Globals.radio_freq == signals_array[2]:
		$"Morse Signal".volume_db = -2
		signal_display.set_text("Signal Detected")
	else:
		$"Morse Signal".volume_db = -80

	if Globals.radio_freq == signals_array[3]:
		$"Morse Signal2".volume_db = -2
		signal_display.set_text("No Signal Detected")
	else:
		$"Morse Signal2".volume_db = -80

	if Globals.radio_freq not in signals_array:
		signal_display.set_text("No Signal Detected")

	if Input.is_action_just_pressed("Pause"):
		get_tree().change_scene_to_file("res://Scenes/Levels/Calihan_Ship.tscn")
		Globals.PlayerControls = true

	if Input.is_action_just_pressed("M_Wheel UP") and Globals.radio_freq < 200 and in_area == true:
		Globals.radio_freq += 1
		freq_cylinder.rotate_x(deg_to_rad(5.0))
		update_marker_position()

	if Input.is_action_just_pressed("M_Wheel DOWN") and Globals.radio_freq > 0 and in_area == true:
		Globals.radio_freq -= 1
		freq_cylinder.rotate_x(deg_to_rad(-5.0))
		update_marker_position()

	#if Input.is_action_just_pressed("Debug"):
		#print(marker.position)


func update_marker_position() -> void:
	var t: float = inverse_lerp(0.0, 200.0, Globals.radio_freq)
	t = clampf(t, 0.0, 1.0)

	var target_x: float = lerpf(marker_left_x, marker_right_x, t)

	marker.position.x = target_x - (marker.size.x / 2.0)
