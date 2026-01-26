extends Control

@onready var cursor = $ProjectSolusCursor2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("StartUp")
	$StartUpSFX.play()
	$Login.hide()

	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

func _process(delta: float) -> void:
	cursor.position = get_global_mouse_position()


func _on_start_up_sfx_finished() -> void:
	$MenuSFX.play()
