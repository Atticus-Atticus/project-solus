extends AnimatedSprite3D

@export var area_path: NodePath        # drag your Area3D here, or leave empty if it's named "Area3D"
@export var normalize_distance: bool = true  # true: alpha = 1 - d/max_distance, false: alpha = clamp(d,0..1)
@export var max_distance: float = 2.5  # used when normalize_distance = true
@export var debug: bool = false

func _ready() -> void:
	visible = false
	var area: Area3D = (get_node(area_path) if area_path != NodePath() else get_node_or_null("Area3D")) as Area3D
	if area == null:
		push_warning("[InteractIndicator] No Area3D found (set area_path or name it 'Area3D').")
		return

	area.proximity_entered.connect(_on_enter)
	area.proximity_exited.connect(_on_exit)
	area.proximity_changed.connect(_on_dist)

func _on_enter() -> void:
	visible = true
	if !is_playing():
		play()

func _on_exit() -> void:
	visible = false
	if is_playing():
		stop()

func _on_dist(d: float) -> void:
	var alpha: float
	if normalize_distance:
		var t: float = clamp(d / max(max_distance, 0.001), 0.0, 1.0) # 0 near .. 1 far
		alpha = 1.0 - t                                              # near opaque, far transparent
	else:
		alpha = clamp(d, 0.0, 1.0)                                   # raw distance → alpha

	var c := modulate
	c.a = alpha
	modulate = c

	if debug:
		# print("distance=", d, " alpha=", alpha)
		pass
