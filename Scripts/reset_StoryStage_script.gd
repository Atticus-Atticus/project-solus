extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SceneSwitcher.PlayerSpawn = null
	Globals._restart()


	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

	$WelcomeLabel.text = UserManager.get_welcome_message()

@onready var cursor = $ProjectSolusCursor2

func _process(delta: float) -> void:
	cursor.position = get_global_mouse_position()
