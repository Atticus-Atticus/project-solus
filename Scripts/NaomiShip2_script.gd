extends Area3D

@onready var ErrorScreen: PackedScene = preload("res://Scenes/User Interface/ErrorScreen.tscn")


func _ready() -> void:
	if Globals.NaomiOnShip == false:
		$"..".queue_free()
	if Globals.NaomiShip2 == true:
		$"..".queue_free()


func _on_body_entered(body: CharacterBody3D) -> void:
	if Globals.NaomiShip2 == false:
		Globals.NaomiShip2 = true
		var Loaded = ErrorScreen.instantiate()
		add_child(Loaded)
		await get_tree().create_timer(1.6).timeout
		$"..".hide()
