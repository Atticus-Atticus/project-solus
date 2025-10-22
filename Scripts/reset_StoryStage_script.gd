extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.StoryStage = 0
	SceneSwitcher.PlayerSpawn = null
	Engine.time_scale = 1
	Globals.Lore1 = 0
	Globals.lore2 = 0
	Globals.lore7 = 0
	Globals.lore8 = 0
	Globals.PlayerSupplies = 0

	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

@onready var cursor = $ProjectSolusCursor2

func _process(delta: float) -> void:
	cursor.position = get_global_mouse_position()
