extends Node3D

var toggle = false
#determine whether door is open or not. false = closed and true = open.
var interactable = true
#prevents the player from interacting with the door while it's opening and closing
@export var animation_player: AnimationPlayer

func _door():
	if interactable == true:
		interactable = false
		toggle = !toggle
		if toggle == false:
			animation_player.play("Close")
		if toggle == true:
			animation_player.play("Open")
		await get_tree().create_timer(5.0, false).timeout
		animation_player.play("Close")
		interactable = true
		toggle = false
#closes door after 5 seconds when opened
