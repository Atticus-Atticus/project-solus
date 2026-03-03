extends Node3D

var front = false
var back = false

@export var front_exit: Marker3D
@export var back_exit: Marker3D

func _ready() -> void:
	$Area3D.monitoring = false

func _start_monitoring():
	$Area3D.monitoring = true

func _enter_trigger(body):
	if body is CharacterBody3D and front == true:
		body.sp = front_exit.global_position
		body.ep = back_exit.global_position
		body._move_through_door()
		#await get_tree().create_timer(1.5).timeout
		get_parent()._door()
		front = false

	if body is CharacterBody3D and back == true:
		body.sp = back_exit.global_position
		body.ep = front_exit.global_position
		body._move_through_door()
		#await get_tree().create_timer(1.5).timeout
		get_parent()._door()
		back = false

func _exit_trigger(body):
	if body is CharacterBody3D:
		$Area3D.monitoring = false
