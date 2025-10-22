extends CharacterBody3D

@onready var NavAgent : NavigationAgent3D = $NavigationAgent3D
var speed = 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(NavAgent.is_target_reached()):
		return
	
	MoveToPoint(delta, speed)
	pass

func MoveToPoint(delta, speed):
	var targetPos = NavAgent.get_next_path_position()
	var direction = global_position.direction_to(targetPos)
	facedirection(targetPos)
	velocity = direction * speed
	move_and_slide()

func facedirection(direction):
	look_at(Vector3(direction.x, global_position.y, direction.z), Vector3.UP)

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("LMB"):
		var camera = get_tree().get_nodes_in_group("Security Cams")[0]
		var mousepos = get_viewport().get_mouse_position()
		var raylength = 100
		var from = camera.project_ray_origin(mousepos)
		var to = from + camera.project_ray_normal(mousepos) * raylength
		var space = get_world_3d().direct_space_state
		var rayquery = PhysicsRayQueryParameters3D.new()
		rayquery.from = from
		rayquery.to = to
		rayquery.collide_with_areas = true
		var result = space.intersect_ray(rayquery)
		print(result)
		
		NavAgent.target_position = result.position
