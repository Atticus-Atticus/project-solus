extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SceneSwitcher.PlayerSpawn = null
	Globals._restart()



	$WelcomeLabel.text = UserManager.get_welcome_message()

@onready var cursor = $ProjectSolusCursor2
