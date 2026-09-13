extends Node3D


var toggle = false
#determine whether door is open or not. false = closed and true = open.
var interactable = true
#prevents the player from interacting with the door while it's opening and closing
var in_zone = false
var interacted = false

@export var out_of_order = false
@export var out_of_order_text: PackedScene
@export var locked = false
@export var animation_player: AnimationPlayer
@export var trigger_area: Area3D
@export var KeyPad: Node3D


func _ready() -> void:
	if trigger_area == null:
		push_error("Door trigger_area has not been assigned.")
		return
	
	#trigger_area.monitoring = false

func _door():
	if interactable == true and locked == false and out_of_order == false and interacted == true and in_zone == true:
		interactable = false
		toggle = !toggle
		if toggle == false:
			animation_player.play("Close")
			$StaticBody3D/CollisionShape3D.set_deferred("disabled", false)
		if toggle == true:
			animation_player.play("Open")
			$StaticBody3D/CollisionShape3D.set_deferred("disabled", true)
		await get_tree().create_timer(5.0, false).timeout
		animation_player.play("Close")
		$StaticBody3D/CollisionShape3D.set_deferred("disabled", false)
		interactable = true
		toggle = false
	elif interactable == true and locked == true and out_of_order == false and interacted == true and in_zone == true:
		KeyPad.cam.show()
		KeyPad._open_keypad()
	elif interactable == true and locked == false and out_of_order == true and interacted == true and in_zone == true:
		var text_temp1 = out_of_order_text.instantiate()
		add_child(text_temp1)
#closes door after 5 seconds when opened

var front = false
var back = false


func _start_monitoring():
	trigger_area.monitoring = true

func _enter_trigger(body):
	if body is CharacterBody3D:
		in_zone = true
	_check_door()


func _exit_trigger(body):
	if body is CharacterBody3D:
		in_zone = false


func _check_door():
	if interacted == true and in_zone == true:
		_door()
