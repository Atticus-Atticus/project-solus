extends Control

# Scenes where W should point along +Z
const POS_Z_SCENES := [
	"Dream_Level",
	"Dream_LevelStage1",
	"Dream_LevelStage2",
	"Dream_LevelStage3",
]

# Scenes where W should point along -Z
const NEG_Z_SCENES := [
	"Calihan_Ship",
	"Abandoned_Ship",
	"Brimpie_Orbital",
]

@onready var rose: Node = $CompassWidget
@onready var letters: Array[Node] = [$CompassW, $CompassA, $CompassS, $CompassD]

func _ready() -> void:
	_set_pivot_center(rose)
	for n in letters:
		_set_pivot_center(n)

	var scene_name := get_tree().current_scene.name
	var desired_forward := Vector3.ZERO

	if POS_Z_SCENES.has(scene_name):
		desired_forward = Vector3(0, 0, 1)   # W = +Z
	elif NEG_Z_SCENES.has(scene_name):
		desired_forward = Vector3(0, 0, -1)  # W = -Z
	else:
		desired_forward = Vector3(0, 0, 1)   # sensible default

	# Map world-forward vector to a UI rotation (up = W)
	var angle := -atan2(desired_forward.x, desired_forward.z)

	_set_rotation(rose, angle)
	for n in letters:
		_set_rotation(n, -angle)  # keep letters upright

# ---- helpers (Control/Node2D safe) ----
func _set_rotation(n: Node, r: float) -> void:
	if n is Node2D:
		(n as Node2D).rotation = r
	elif n is Control:
		(n as Control).rotation = r

func _set_pivot_center(n: Node) -> void:
	if n is Control:
		var c := n as Control
		c.pivot_offset = c.size * 0.5
