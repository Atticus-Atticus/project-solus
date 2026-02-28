extends CharacterBody3D

@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var nav_agent: NavigationAgent3D = $NavigationAgent3D

@export var speed: float = 2.5
@export var ray_length: float = 10000.0

@export var turn_speed := 8.0      # higher = faster rotation
@export var arrive_dist := 2    # how close counts as "reached"

var holding_click := false
var ep: Vector3
#ep is set by the door interactable
#ap is the location of the marker3D in the door interactable scene that the player moves to after the door opens

var _auto_move := false

func _physics_process(delta: float) -> void:
	# If controls are OFF and we're NOT in an auto-move sequence, fully stop.
	if not Globals.PlayerControls and not _auto_move:
		velocity = Vector3.ZERO
		return

	if nav_agent.is_target_reached():
		velocity = Vector3.ZERO
		return

	# Only allow "hold click updates destination" when player controls are enabled
	if Globals.PlayerControls and holding_click and Input.get_last_mouse_velocity().length() > 0.0:
		_update_target_from_mouse()

	move_to_point(delta)

	#if nav_agent.target_position == ep:
		#_auto_move = false
		#Globals.PlayerControls = true

	if Input.is_action_just_pressed("Debug"):
		get_tree().reload_current_scene()


func _input(event: InputEvent) -> void:
	# If controls are disabled BUT we're auto-moving, ignore input completely.
	if not Globals.PlayerControls:
		if _auto_move:
			return
		holding_click = false
		nav_agent.target_position = global_position
		return

	if event.is_action_pressed("LMB"):
		holding_click = true
		_try_interact_under_mouse()
		_update_target_from_mouse()
	elif event.is_action_released("LMB"):
		holding_click = false

func move_to_point(delta: float) -> void:
	var target_pos: Vector3 = nav_agent.get_next_path_position()
	var direction: Vector3 = global_position.direction_to(target_pos)

	face_direction(target_pos)

	velocity = direction * speed
	move_and_slide()

func face_direction(target: Vector3) -> void:
	look_at(Vector3(target.x, global_position.y, target.z), Vector3.UP)

func _get_mouse_raycast() -> Dictionary:
	var cam: Camera3D = get_viewport().get_camera_3d()
	if cam == null:
		return {}

	var mouse_pos: Vector2 = get_viewport().get_mouse_position()
	var from: Vector3 = cam.project_ray_origin(mouse_pos)
	var to: Vector3 = from + cam.project_ray_normal(mouse_pos) * ray_length

	var space := get_world_3d().direct_space_state
	var query := PhysicsRayQueryParameters3D.create(from, to)
	query.exclude = [self]
	query.collide_with_bodies = true
	query.collide_with_areas = false

	return space.intersect_ray(query)

func _try_interact_under_mouse() -> void:
	var result := _get_mouse_raycast()
	if result.is_empty():
		return

	var hit_object: Object = result.get("collider")
	if hit_object != null and hit_object.has_method("interact"):
		hit_object.call("interact")

func _update_target_from_mouse() -> void:
	var result := _get_mouse_raycast()
	if result.is_empty():
		return

	var hit_pos: Vector3 = result["position"]
	nav_agent.target_position = hit_pos


func _move_through_door() -> void:
	Globals.PlayerControls = false
	_auto_move = true
	holding_click = false

	#if anim_player:
		#anim_player.play("Interact")
		#await anim_player.animation_finished
#commented out as animation player hasn't been added yet

	nav_agent.target_position = ep
	await _wait_until_reached(ep)

	_auto_move = false
	Globals.PlayerControls = true
	ep = Vector3.ZERO


func _wait_until_reached(target_pos: Vector3) -> void:
	while global_position.distance_to(target_pos) > arrive_dist:
		await get_tree().process_frame
