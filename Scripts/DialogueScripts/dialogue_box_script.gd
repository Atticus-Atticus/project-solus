extends Node

@onready var textbox_container = $TextboxContainer
@onready var start_symbol = $TextboxContainer/MarginContainer/HBoxContainer/Start
@onready var end_symbol = $TextboxContainer/MarginContainer/HBoxContainer/End
@onready var label = $TextboxContainer/MarginContainer/HBoxContainer/Label

enum State {
	READY,
	READING,
	FINISHED
}

var current_state = State.READY
var text_queue = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Starting state: State.READY")
	hide_textbox()
	queue_text("If you're ready this...")
	queue_text("it means...")
	queue_text("the...")
	queue_text("TEXT BOXES ARE WORKING!!!")
	queue_text("...")
	queue_text("...")
	queue_text("...")
	queue_text("Box: The f**k you looking at?")

func _process(delta: float) -> void:
	match current_state:
			State.READY:
				if !text_queue.is_empty():
					display_text()
			State.READING:
				$AudioStreamPlayer.play()
				if Input.is_action_just_pressed("Dialogue"):
					label.visible_ratio = 1.0
					$TextboxContainer/TweenAnimation.speed_scale = 99.0
					change_state(State.FINISHED)
			State.FINISHED:
				$AudioStreamPlayer.stop()
				if Input.is_action_just_pressed("Dialogue"):
					$TextboxContainer/TweenAnimation.speed_scale = 2.5
					change_state(State.READY)
					hide_textbox()

func queue_text(next_text):
	text_queue.push_back(next_text)

func hide_textbox():
	start_symbol.text = ""
	end_symbol.text = ""
	label.text = ""
	textbox_container.hide()
	Globals.PlayerControls = true
	Globals.InDialogue = false

func show_text():
	start_symbol.text = ">"
	textbox_container.show()
	Globals.PlayerControls = false
	Globals.InDialogue = true

func display_text():
	var next_text = text_queue.pop_front()
	label.text = next_text
	change_state(State.READING)
	show_text()
	$TextboxContainer/TweenAnimation.play("TextTween")

func _on_tween_animation_animation_finished(anim_name: StringName) -> void:
	end_symbol.text = "v"
	change_state(State.FINISHED)

func change_state(next_state):
	current_state = next_state
	match current_state:
		State.READY:
			print("Changing state to: State.READY")
		State.READING:
			print("Changing state to: State.READING")
		State.FINISHED:
			print("Changing state to: State.FINISHED")
