extends Node3D

@export var yaw_speed := 1.5
@export var pitch_speed := 1.5
@export var pitch_min_deg := -35.0
@export var pitch_max_deg := 35.0
@export var starting_rotation: Vector3

var in_trigger := false
var character: Node3D = null

@onready var yaw_pivot: Node3D = $YawPivot
@onready var pitch_pivot: Node3D = $YawPivot/PitchPivot
@onready var cam: Camera3D = $YawPivot/PitchPivot/Camera3D


func _ready() -> void:
	yaw_pivot.set_rotation_degrees(starting_rotation)

func _process(delta: float) -> void:
	if not (in_trigger and character):
		return

	#YAW (horizontal)
	var to_target := character.global_position - yaw_pivot.global_position
	to_target.y = 0.0
	if to_target.length() > 0.001:
		var desired_yaw := atan2(to_target.x, to_target.z) # radians
		yaw_pivot.rotation.y = lerp_angle(yaw_pivot.rotation.y, desired_yaw, 1.0 - exp(-yaw_speed * delta))

	#PITCH (vertical)
	var to_target_full := character.global_position - pitch_pivot.global_position
	var flat_dist := Vector2(to_target_full.x, to_target_full.z).length()
	var desired_pitch := -atan2(to_target_full.y, flat_dist)
	var min_r := deg_to_rad(pitch_min_deg)
	var max_r := deg_to_rad(pitch_max_deg)
	desired_pitch = clamp(desired_pitch, min_r, max_r)

	pitch_pivot.rotation.x = lerp_angle(pitch_pivot.rotation.x, desired_pitch, 1.0 - exp(-pitch_speed * delta))

	# make current
	if not cam.is_current():
		cam.make_current()

	# Zoom (clamp added so it can't go silly)
	if Input.is_action_just_pressed("CameraZoomIn"):
		cam.fov = clamp(cam.fov + 10.0, 30.0, 110.0)
	if Input.is_action_just_pressed("CameraZoomOut"):
		cam.fov = clamp(cam.fov - 10.0, 30.0, 110.0)
