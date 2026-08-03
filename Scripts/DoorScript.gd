extends Node3D


var toggle = false
#determine whether door is open or not. false = closed and true = open.
var interactable = true
#prevents the player from interacting with the door while it's opening and closing

@export var locked = false
@export var animation_player: AnimationPlayer
@export var trigger_area: Area3D
@export var KeyPad: Node3D


func _ready() -> void:
	if trigger_area == null:
		push_error("Door trigger_area has not been assigned.")
		return
	
	trigger_area.monitoring = false

func _door():
	if interactable == true and locked == false:
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
	elif interactable == true and locked == true:
		KeyPad._open_keypad()
#closes door after 5 seconds when opened

var front = false
var back = false

#@export var front_exit: Marker3D
#@export var back_exit: Marker3D

func _start_monitoring():
	trigger_area.monitoring = true

func _enter_trigger(body):
	if body is CharacterBody3D and front == true:
		#body.sp = front_exit.global_position
		#body.ep = back_exit.global_position
		#body._move_through_door()
		#await get_tree().create_timer(1.5).timeout
		_door()
		front = false

	if body is CharacterBody3D and back == true:
		#body.sp = back_exit.global_position
		#body.ep = front_exit.global_position
		#body._move_through_door()
		#await get_tree().create_timer(1.5).timeout
		_door()
		back = false

func _exit_trigger(body):
	if body is CharacterBody3D:
		$Area3D.monitoring = false
