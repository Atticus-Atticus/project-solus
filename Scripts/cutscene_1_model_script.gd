extends Node3D

@onready var anim: AnimationPlayer = $AnimationPlayer
const TARGET := "Anim2"
const TARGET2 := "Anim4"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("Anim1Loop")
	anim.animation_finished.connect(_on_anim_finished)

#make proess happen once
# Called every frame. 'delta' is the elapsed time since the previous frame.
var done1 = false
var done2 = false
func _process(delta: float) -> void:
	if Globals.CutScene1Anim == 1 and done1 == false:
		$AnimationPlayer.play("Anim2")
		done1 = true

	if Globals.CutScene1Anim == 2 and done2 == false:
		$AnimationPlayer.play("Anim4")
		done1 = true

func _on_anim_finished(name: StringName) -> void:
	if name == TARGET:
		$AnimationPlayer.play("Anim3Loop")
	if name == TARGET2:
		Globals.CutScene1Finished = 1
