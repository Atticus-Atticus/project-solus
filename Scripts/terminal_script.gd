extends Control

@onready var output: RichTextLabel = $Output
@onready var command_input: LineEdit = $CommandInput

@onready var calihan_panel = $CalihanPanel
@onready var naomi_panel = $NaomiPanel
@onready var amy_panel = $AmyPanel

var commands: Dictionary
var argument: String
var records: Dictionary
var current_panel: Control


func _ready() -> void:
	commands = {
		"help": help_command,
		"?": help_command,
		
		"clear": clear_command,
		"cls": clear_command,
		
		"echo": echo_command,
		"say": echo_command,
		
		"show": show_command,
		"view": show_command,
		"open": show_command,
		
		"close": close_command,
		"hide": close_command,
		
		"alien": alien_command,
		
		"player.additem": no_command,
		"/give": no_command,
	}

	records = {
		"calihan": calihan_panel,
		"naomi": naomi_panel,
		"amy": amy_panel
	}

	command_input.text_submitted.connect(_on_command_submitted)
	command_input.grab_focus()


func _on_command_submitted(text: String) -> void:
	var cleaned_text := text.strip_edges()
	if cleaned_text.is_empty():
		command_input.clear()
		command_input.grab_focus()
		return

	var parts = text.strip_edges().split(" ", false)

	var command: String = parts[0].to_lower()

	argument = " ".join(parts.slice(1))

	output.append_text("> " + text + "\n")

	if commands.has(command):
		commands[command].call()
	else:
		output.append_text("Unknown command: " + command + "\n")

	command_input.clear()
	command_input.grab_focus()


func help_command() -> void:
	output.append_text("""
AVAILABLE COMMANDS:

HELP - Displays available commands.

""")

func clear_command():
	output.clear()

func echo_command():
	output.append_text(argument + "\n")

func show_command():
	var record_name = argument.to_lower()

	if records.has(record_name):
		if current_panel:
			current_panel.hide()

		current_panel = records[record_name]
		current_panel.show()
	else:
		output.append_text("Record not found: " + argument + "\n")

func close_command():
	if current_panel:
		current_panel.hide()
		current_panel = null
	else:
		output.append_text("No record currently open.\n")

func alien_command():
	output.append_text("no gleeby deebys here" + "\n")

func no_command():
	var random_number = randi_range(0, 5)
	if random_number == 0:
		output.append_text("no" + "\n")
	elif random_number == 1:
		output.append_text("nuh uh" + "\n")
	elif random_number == 2:
		output.append_text("I SAID NO!" + "\n")
	elif random_number == 3:
		output.append_text("yeah nah" + "\n")
	elif random_number == 4:
		output.append_text("nope. sorry" + "\n")
	elif random_number == 5:
		output.append_text("not happening" + "\n")
