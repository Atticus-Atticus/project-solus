extends Label

#this script can be attached to a label node
#this script is used for debug purposes

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Engine.max_fps = 30
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var fps = Engine.get_frames_per_second()
	text = "FPS: " + str(fps)
