extends Control

@onready var cursor = $ProjectSolusCursor2


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Globals.Lore1 == 0:
		$"DatabasePanel/MarginContainer/VBoxContainer/FotN 1".set_disabled(true)
	if Globals.Lore1 == 1:
		$"DatabasePanel/MarginContainer/VBoxContainer/FotN 1".set_disabled(false)

	if Globals.lore2 == 0:
		$"DatabasePanel/MarginContainer/VBoxContainer/FCC 2".set_disabled(true)
	if Globals.lore2 == 1:
		$"DatabasePanel/MarginContainer/VBoxContainer/FCC 2".set_disabled(false)

	if Globals.lore7 == 0:
		$"DatabasePanel/MarginContainer/VBoxContainer/AbndShip 7".set_disabled(true)
	if Globals.lore7 == 1:
		$"DatabasePanel/MarginContainer/VBoxContainer/AbndShip 7".set_disabled(false)

	if Globals.lore8 == 0:
		$"DatabasePanel/MarginContainer/VBoxContainer/Brimpie Orb 8".set_disabled(true)
	if Globals.lore8 == 1:
		$"DatabasePanel/MarginContainer/VBoxContainer/Brimpie Orb 8".set_disabled(false)

	if Globals.lore9 == 0:
		$"DatabasePanel/MarginContainer/VBoxContainer/Simulation 9".set_disabled(true)
	if Globals.lore9 == 1:
		$"DatabasePanel/MarginContainer/VBoxContainer/Simulation 9".set_disabled(false)

	if Globals.lore10 == 0:
		$"DatabasePanel/MarginContainer/VBoxContainer/LifeBeyondScale 10".set_disabled(true)
	if Globals.lore10 == 1:
		$"DatabasePanel/MarginContainer/VBoxContainer/LifeBeyondScale 10".set_disabled(false)

	if Globals.KeysFound == 2:
		$MarginContainer/VBoxContainer/EncryptionFile.set_disabled(false)

	if Input.is_action_just_pressed("Pause"):
		Globals.PlayerControls = true
		$".".queue_free()

	#cursor.position = get_global_mouse_position()
