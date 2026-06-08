extends Node3D


func _ready() -> void:
	update_shadows()

func _process(delta: float) -> void:
	update_shadows()

func update_shadows() -> void:
	$"SM_Prop_LightBar_02/OmniLight With Shadows".shadow_enabled = Globals.shadows
