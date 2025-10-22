extends Node3D


@onready var radio_screen = $MeshInstance3D2/SubViewport/Control/Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	radio_screen.text = str(Globals.radio_freq)
