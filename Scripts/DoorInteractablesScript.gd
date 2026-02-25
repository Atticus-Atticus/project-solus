extends StaticBody3D

@export var exit_point: Marker3D = null

func _ready() -> void:
	$Area3D.monitoring = false
	$Block.disabled = false

func interact():
	$Area3D.monitoring = true
	$Block.disabled = true


func _enter_trigger(body):
	if body is CharacterBody3D:
		get_parent()._door()


func _exit_trigger(body):
	if body is CharacterBody3D:
		$Area3D.monitoring = false
		$Block.disabled = false
