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
		get_parent()._door()
		await get_tree().create_timer(1.5).timeout
		body.ep = back_exit.global_position
		body._move_through_door()
		front = false

	if body is CharacterBody3D and back == true:
		get_parent()._door()
		await get_tree().create_timer(1.5).timeout
		body.ep = front_exit.global_position
		body._move_through_door()
		back = false

func _exit_trigger(body):
	if body is CharacterBody3D:
		$Area3D.monitoring = false
