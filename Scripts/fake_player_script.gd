extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$StaticBody3D/Body/blockbench_export/AnimationPlayer2.play("CaliMations/Cali_Walk")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
