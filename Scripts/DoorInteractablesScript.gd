extends Node3D

@export var exit_front: Marker3D
@export var exit_back: Marker3D

var _busy := false

func interact(player: CharacterBody3D, from_front: bool) -> void:
	if _busy:
		return
	_busy = true

	# open the door
	get_parent()._door()

	# choose destination on the opposite side
	var dest := (exit_back.global_position if from_front else exit_front.global_position)

	player.ep = dest
	await player._move_through_door()

	_busy = false
