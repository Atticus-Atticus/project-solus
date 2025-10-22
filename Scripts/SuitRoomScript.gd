extends Area3D

func _ready() -> void:
	$"../Area3D2".hide()
	$"../Area3D3".hide()


func _on_body_entered(body):
	if body is CharacterBody3D:
		$"../AnimationPlayer".play("Move Triggers")
		print("Trigger 1 working")
