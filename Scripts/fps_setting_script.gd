extends Control

var fps_button_group := ButtonGroup.new()

@onready var refresh_button = $"Panel/MarginContainer/VBoxContainer/Lock to Refresh Rate"
@onready var fps_30_button = $"Panel/MarginContainer/VBoxContainer/30"
@onready var fps_60_button = $"Panel/MarginContainer/VBoxContainer/60"
@onready var fps_120_button = $"Panel/MarginContainer/VBoxContainer/120"
@onready var fps_144_button = $"Panel/MarginContainer/VBoxContainer/144"
@onready var unlimited_button = $"Panel/MarginContainer/VBoxContainer/No Limit"


func _ready() -> void:
	refresh_button.button_group = fps_button_group
	fps_30_button.button_group = fps_button_group
	fps_60_button.button_group = fps_button_group
	fps_120_button.button_group = fps_button_group
	fps_144_button.button_group = fps_button_group
	unlimited_button.button_group = fps_button_group


func _on_lock_to_refresh_rate_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		var screen = DisplayServer.window_get_current_screen()
		var refresh_rate = DisplayServer.screen_get_refresh_rate(screen)
		if refresh_rate > 0:
			Engine.max_fps = int(refresh_rate)
		else:
			Engine.max_fps = 0 #Unlimited fps if refresh rate couldn't be detected
		refresh_button.set_text(">> match refresh rate <<")
	else:
		refresh_button.set_text("> match refresh rate <")


func _on_30_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		Engine.max_fps = 30
		fps_30_button.set_text(">> 30 fps <<")
	else:
		fps_30_button.set_text("> 30 fps <")


func _on_60_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		Engine.max_fps = 60
		fps_60_button.set_text(">> 60 fps <<")
	else:
		fps_60_button.set_text("> 60 fps <")


func _on_120_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		Engine.max_fps = 120
		fps_120_button.set_text(">> 120 fps <<")
	else:
		fps_120_button.set_text("> 120 fps <")


func _on_144_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		Engine.max_fps = 144
		fps_144_button.set_text(">> 144 fps <<")
	else:
		fps_144_button.set_text("> 144 fps <")


func _on_no_limit_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		Engine.max_fps = 0
		unlimited_button.set_text(">> uncapped fps <<")
	else:
		unlimited_button.set_text("> uncapped fps <")
