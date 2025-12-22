extends Control

@onready var cursor = $ProjectSolusCursor2


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	cursor.position = get_global_mouse_position()

	if Globals.InputType == 1:
		$Panel2/Label2.text = "
Use 'W' to move Forward. Use 'S' to preform a quick turn.
Use 'A' to rotate Left. Use 'D' to rotate Right.
Use 'E' to interact with objects that pulse blue.

Objects that glow green will progress the subject's memory.
Please ignore any hallucinatory overalls that may be present."

	if Globals.InputType == 2:
		$Panel2/Label2.text = "
Use 'W' to move Forward. Use 'S' to move Backwards.
The Subject will always face and move towards the mouse's position
Use 'E' to interact with objects that pulse blue.

Objects that glow green will progress the subject's memory.
Please ignore any hallucinatory overalls that may be present."

	if Globals.InputType == 3:
		$Panel2/Label2.text = "
Use 'W' to move away from Camera. Use 'S' to move towards Camera.
Use 'A' to move Left. Use 'D' to move Right.
Use 'E' to interact with objects that pulse blue.

Objects that glow green will progress the subject's memory.
Please ignore any hallucinatory overalls that may be present."
