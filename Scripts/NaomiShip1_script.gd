extends Area3D


func _ready() -> void:
	$ColorRect2.hide()

	if Globals.NaomiShip1 == true:
		$"..".queue_free()

func _on_body_entered(body: CharacterBody3D) -> void:
	if Globals.NaomiShip1 == false:
		Globals.NaomiShip1 = true
		$ColorRect2.show()
		await get_tree().create_timer(1).timeout
		$ColorRect2.hide()
		$"..".hide()
