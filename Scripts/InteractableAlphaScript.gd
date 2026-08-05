extends Area3D

@export_category("Highlight Targets")
@export var objects: Array[MeshInstance3D] = []

@export_category("Fade Settings")
@export_range(0.0, 1.0, 0.01) var centre_alpha := 1.0
@export_range(0.0, 1.0, 0.01) var edge_alpha := 0.0
@export var max_distance := 4.0

@export_category("Player Detection")
@export var player_group := "player"

var player: Node3D


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

	_set_highlight_alpha(0.0)


func _physics_process(_delta: float) -> void:
	if not is_instance_valid(player):
		return

	var distance := global_position.distance_to(player.global_position)
	var distance_ratio = clamp(
		distance / max(max_distance, 0.001),
		0.0,
		1.0
	)

	var alpha = lerp(centre_alpha, edge_alpha, distance_ratio)
	_set_highlight_alpha(alpha)


func _on_body_entered(body: Node3D) -> void:
	if not body.is_in_group(player_group):
		return

	player = body

	# Update immediately instead of waiting for the next physics frame.
	var distance := global_position.distance_to(player.global_position)
	var ratio = clamp(distance / max(max_distance, 0.001), 0.0, 1.0)
	_set_highlight_alpha(lerp(centre_alpha, edge_alpha, ratio))


func _on_body_exited(body: Node3D) -> void:
	if body != player:
		return

	player = null
	_set_highlight_alpha(0.0)


func _set_highlight_alpha(alpha: float) -> void:
	var safe_alpha = clamp(alpha, 0.0, 1.0)

	for mesh_instance in objects:
		if not is_instance_valid(mesh_instance):
			continue

		var value: Variant = mesh_instance.get_instance_shader_parameter(
			"shine_color"
		)

		var shine_color := Color.WHITE

		if value is Color:
			shine_color = value

		shine_color.a = safe_alpha

		mesh_instance.set_instance_shader_parameter(
			"shine_color",
			shine_color
		)
