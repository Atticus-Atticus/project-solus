extends Area3D

signal proximity_changed(distance: float)
signal proximity_entered()
signal proximity_exited()

@export var use_horizontal_distance: bool = true
@export var radius_override: float = 0.0
@export var debug: bool = true

var actor: CharacterBody3D = null
var radius: float = 1.0

func _ready() -> void:
	monitoring = true
	monitorable = true
	if collision_mask == 0:
		# For debugging, see everything on any layer. Tighten later if you want.
		collision_mask = 0xFFFF

	var col := get_node_or_null("CollisionShape3D") as CollisionShape3D
	if col and col.shape is SphereShape3D:
		radius = (col.shape as SphereShape3D).radius
	elif radius_override > 0.0:
		radius = radius_override


	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _physics_process(_delta: float) -> void:
	if actor == null:
		return
	var center: Vector3 = global_transform.origin
	var p: Vector3 = actor.global_transform.origin
	if use_horizontal_distance:
		p.y = center.y
	var d: float = center.distance_to(p)
	proximity_changed.emit(d)

func _on_body_entered(body: Node) -> void:
	if body is CharacterBody3D:
		actor = body
		proximity_entered.emit()
		# Emit an initial distance immediately
		_physics_process(0.0)

func _on_body_exited(body: Node) -> void:
	if body == actor:
		actor = null
		proximity_exited.emit()
