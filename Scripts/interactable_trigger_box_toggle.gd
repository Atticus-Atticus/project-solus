extends Area3D

@onready var text_scene1: PackedScene = preload("res://Scenes/User Interface/Dialogue/RunDialogueBox.tscn")

func _on_body_entered(body: Node3D) -> void:
	var text1 = text_scene1.instantiate()
	add_child(text1)
	Globals.StoryStage += 1
