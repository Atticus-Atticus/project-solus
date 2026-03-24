extends Area3D

@onready var ErrorScreen: PackedScene = preload("res://Scenes/User Interface/ErrorScreen.tscn")


func _ready() -> void:
	if Globals.NaomiShip1 == true:
		$"..".queue_free()


func _on_body_entered(body: CharacterBody3D) -> void:
	if Globals.NaomiShip1 == false:
		Globals.NaomiShip1 = true
		var Loaded = ErrorScreen.instantiate()
		add_child(Loaded)
		await get_tree().create_timer(1).timeout
		$"..".hide()
