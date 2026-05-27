extends StaticBody3D

@onready var scene: PackedScene = preload("res://Scenes/User Interface/Dialogue/DatrabaseKeyFoundDialogue.tscn")
@onready var scene2: PackedScene = preload("res://Scenes/User Interface/Dialogue/DatrabaseKeyFound2Dialogue.tscn")

var HasKey = false

func _ready() -> void:
	$ServerBlockOn.show()
	$ServerBlockOff.hide()

func interact():
	if HasKey == false:
		var loadedscene = scene.instantiate()
		add_child(loadedscene)
		HasKey = true
		$ServerBlockOn.hide()
		$ServerBlockOff.show()
		$"../OmniLight3D".hide()
		$"../SpotLight3D".hide()
		$"../AnimationPlayer".stop()
	else:
		return
