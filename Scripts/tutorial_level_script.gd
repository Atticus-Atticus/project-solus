extends Node3D

@onready var pause_menu = $PauseMenu
@onready var text: PackedScene = preload("res://Scenes/User Interface/Dialogue/Tutorial1DialogueBox.tscn")
@onready var cursor = $ProjectSolusCursor2


# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#var LoadedText = text.instantiate()
	#add_child(LoadedText)


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Pause"):
		pausemenu()


func pausemenu():
	if Globals.paused:
		pause_menu.hide()
		#Engine.time_scale = 1
	else:
		pause_menu.show()
		#Engine.time_scale = 0
	Globals.paused = !Globals.paused
