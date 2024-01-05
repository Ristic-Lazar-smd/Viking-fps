extends CharacterBody3D

@onready var head  = $Head

var current_speed = 5.0
@export var walking_speed = 5.0
@export var sprint_speed = 8.0
@export var crouch_speed = 3.0
@export var jump_speed = 4.5
@export var gravity = 9.8

@export var mouse_sens = 0.25

var lerp_speed = 10.0

var direction = Vector3.ZERO

var crouch_depth = 0.5

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * mouse_sens))
		head.rotate_x(deg_to_rad(-event.relative.y * mouse_sens))
		head.rotation.x = clamp(head.rotation.x,deg_to_rad(-89),deg_to_rad(89))

func _physics_process(delta):
	if Input.is_action_pressed("crouch") and is_on_floor():
		current_speed = crouch_speed
		head.position.y = crouch_depth
	else:
		head.position.y = 1.8
		if Input.is_action_pressed("sprint") and is_on_floor():
			current_speed = sprint_speed
		else:
			crouch_speed = walking_speed
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_speed
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Get the input direction and handle the movement/deceleration.
	var input_dir := Input.get_vector("left", "right", "up", "down")
	direction =  lerp(direction,(transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized(),delta*lerp_speed)
	if direction:
		velocity.x = direction.x * current_speed
		velocity.z = direction.z * current_speed
	else:
		velocity.x = move_toward(velocity.x, 0, current_speed)
		velocity.z = move_toward(velocity.z, 0, current_speed)

	print ("current speed: ",current_speed)
	print ("velocity: ",velocity)
	move_and_slide()
