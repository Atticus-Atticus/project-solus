extends Area3D

var gone = false

func _ready() -> void:
	$ColorRect2.hide()
	$Label.hide()

func _on_body_entered(body: CharacterBody3D) -> void:
	if gone == false:
		gone = true
		$ColorRect2.show()
		$Label.show()
		await get_tree().create_timer(1).timeout
		$ColorRect2.hide()
		$Label.hide()
		$"..".hide()
