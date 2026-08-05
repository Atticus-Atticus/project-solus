extends Node3D

const Max_Code_Length := 4

var Code: String = ""
var ViewingKeyPad = false
var Previous_Camera: Camera3D

@export var buttons: Array[CollisionObject3D]
@export var DoorCode: String = "1234"
@export var Linked_Door: Node3D
@export var Hint: Node3D

@export var RandomCode = false
#setting this to true will make give the locked door a random code.
#leaving it false will allow for the code to be set maunally

func _ready() -> void:
	for button in buttons:
		button.get_node("CollisionShape3D").set_deferred("disabled", true)

	if RandomCode == true:
		_generate_code()

func _open_keypad():
	Previous_Camera = get_viewport().get_camera_3d()
	Globals.PlayerControls = false
	$Camera3D.make_current()
	ViewingKeyPad = true
	for button in buttons:
		button.get_node("CollisionShape3D").set_deferred("disabled", false)

func _close_keypad():
	if is_instance_valid(Previous_Camera):
		Previous_Camera.current = true
	Previous_Camera = null
	Globals.PlayerControls = true
	ViewingKeyPad = false
	for button in buttons:
		button.get_node("CollisionShape3D").set_deferred("disabled", true)

func _update_label():
	$MeshInstance3D3/SubViewport/Control/ColorRect/Label.set_text(Code)

func _check_code():
	if Code == DoorCode:
		print("Door Unlocked")
		$sphere/AnimationPlayer.play("Right")
		await get_tree().create_timer(1).timeout
		_close_keypad()
		Linked_Door.locked = false
		Linked_Door._door()

	elif Code != DoorCode:
		print("Code Incorrect")
		$sphere/AnimationPlayer.play("Wrong")
		Code = ""
		$MeshInstance3D3/SubViewport/Control/ColorRect/Label.set_text("0000")

func _generate_code():
	var random_code = "%04d" % randi_range(0, 9999)
	DoorCode = random_code
	print("Code is: ", DoorCode)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Tab") and ViewingKeyPad == true:
		_close_keypad()
