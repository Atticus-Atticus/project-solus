extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Globals.InputType == 1:
		$Panel/Control/Panel2/Controls.text = "Use 'W' to move Forward. Use 'S' to preform a quick turn.
Use 'A' to rotate Left. Use 'D' to rotate Right.
Use 'E' to interact with objects that pulse blue.
Use 'N' to show objective."

	if Globals.InputType == 2:
		$Panel/Control/Panel2/Controls.text = "Use 'W' to move Forward. Use 'S' to move Backwards.
The Subject will always face and move towards the mouse's position
Use 'E' to interact with objects that pulse blue.
Use 'N' to show objective."

	if Globals.InputType == 3:
		$Panel/Control/Panel2/Controls.text = "Use 'W' to move away from Camera. Use 'S' to move towards Camera.
Use 'A' to move Left. Use 'D' to move Right.
Use 'E' to interact with objects that pulse blue.
Use 'N' to show objective."


func _on_x_button_pressed() -> void:
	$AnimationPlayer.play("Close")
	await get_tree().create_timer(1.3).timeout
	queue_free()
