class_name Controls extends CharacterBody3D


const SPEED = 2.7
const JUMP_VELOCITY = 4.5
@export var PlayerPOS = 0

@onready var anim_tree = $Body/blockbench_export2/AnimationTree

var last_direction = Vector3.FORWARD
@export var rotation_speed = 5
#changes the player body to face the direction it's moving

func _physics_process(delta: float) -> void:
	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("Left", "Right", "Foward", "Backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction && Globals.PlayerControls == true:
		last_direction = direction
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	$Body.rotation.y = lerp_angle($Body.rotation.y, atan2(-last_direction.x, -last_direction.z), delta * rotation_speed)
#changes the player body to face the direction it's moving

	if not is_on_floor():
		velocity += get_gravity() * delta

	move_and_slide()


func _process(delta: float) -> void:
	PlayerPOS = global_position
	if Input.is_action_just_pressed("Debug"):
		print(Globals.StoryStage)
#getting player position every tick

	var speed = velocity.length()
	anim_tree.set("parameters/MovementBlend/blend_position", speed)

func get_player_pos():
	SceneSwitcher.PlayerSpawn = PlayerPOS
#save player position to global varaible in SceneSwitcher.gd
func get_player_pos2():
	Globals.HallwayPos = PlayerPOS
#save player position to global varaible in Globals.gd
