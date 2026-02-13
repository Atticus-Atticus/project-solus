extends Node3D

var toggle = false
var interactable = true
@export var animation_player: AnimationPlayer

func interact():
	if interactable == true:
		if Globals.PlayerHasTutorialKey == true:
			interactable = false
			toggle = !toggle
			if toggle == false:
				animation_player.play("DoorClose")
			if toggle == true:
				animation_player.play("DoorOpen")
			await get_tree().create_timer(1,0, false).timeout
			interactable = true
