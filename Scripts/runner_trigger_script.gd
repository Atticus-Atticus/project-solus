extends Area3D

var finsihed = false

func _on_body_entered(body: CharacterBody3D) -> void:
	if finsihed == false:
		$"../AnimationPlayerRunner".play("RunnerMove")
		finsihed = true
