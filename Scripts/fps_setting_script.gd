extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_option_button_item_selected(index: int) -> void:
	match index:
		0:
			Engine.max_fps = 30
		1:
			Engine.max_fps = 60
		2:
			Engine.max_fps = 120
		3:
			Engine.max_fps = 0
