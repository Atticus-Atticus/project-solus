extends Control

@onready var btn: Button = $Panel/CompassToggle

func _ready() -> void:
	# Auto-wire signals (safe even if already connected in editor)
	btn.pressed.connect(_on_button_pressed)
	btn.mouse_entered.connect(_on_button_mouse_entered)
	btn.mouse_exited.connect(_on_button_mouse_exited)
	_update_label(false)  # start in non-hover look

func _on_button_pressed() -> void:
	Globals.Compass = not Globals.Compass
	_update_label(_is_mouse_over_button())

func _on_button_mouse_entered() -> void:
	_update_label(true)

func _on_button_mouse_exited() -> void:
	_update_label(false)

func _update_label(hovered: bool) -> void:
	var state := "Enabled" if Globals.Compass else "Disabled"
	btn.text = (">>%s<<" % state) if hovered else ("  %s  " % state)

func _is_mouse_over_button() -> bool:
	var mp := get_viewport().get_mouse_position()
	return btn.get_global_rect().has_point(mp)
