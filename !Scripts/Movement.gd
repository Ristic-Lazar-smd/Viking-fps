extends CharacterBody3D

#mozda optimizuj jednog dana :)
@onready var neck = $Neck
@onready var head  = $Neck/Head
@onready var player_cam = $Neck/Head/PlayerCam
@onready var standing_collision = $StandingCollision
@onready var crouching_collision = $CrouchingCollision
@onready var raycast_standup = $RayCast3D

@export var walking_speed = 5.0
@export var sprint_speed = 10
@export var crouch_speed = 3.0
@export var jump_speed = 4.5
@export var gravity = 12
@export var mouse_sens = 0.15
@export var crouch_depth = -0.5

var current_speed = walking_speed
var direction = Vector3.ZERO
var lerp_speed = 10.0
var free_look_tilt = 3.5
#slide vars
var slide_timer = 0.0
var slide_timer_max = 1.0
var slide_direction = Vector2.ZERO
@export var max_slide_speed = 15
var slide_speed = 15
#var has_boost = false
#states
var is_walking = false
var is_crouching = false
var is_sprinting = false
var is_free_looking = false
var is_sliding = false


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event: InputEvent) -> void:
	#Mouse input logic
	if event is InputEventMouseMotion:
		if is_free_looking:
			neck.rotate_y(deg_to_rad(-event.relative.x * mouse_sens))
			neck.rotation.y = clamp(neck.rotation.y,deg_to_rad(-80),deg_to_rad(80))
		else:
			rotate_y(deg_to_rad(-event.relative.x * mouse_sens))
		head.rotate_x(deg_to_rad(-event.relative.y * mouse_sens))
		head.rotation.x = clamp(head.rotation.x,deg_to_rad(-89),deg_to_rad(89))

func _physics_process(delta):
	var input_dir := Input.get_vector("left", "right", "up", "down")
	#CROUCH AND SPRINT LOGIC START
	if Input.is_action_pressed("crouch") && is_on_floor() || is_sliding && is_on_floor():
		current_speed = crouch_speed
		head.position.y = lerp(head.position.y,crouch_depth,delta * lerp_speed)
		crouching_collision.disabled = false
		standing_collision.disabled = true
		#slide
		if is_sprinting:
			is_sliding = true
			slide_speed = max_slide_speed
			slide_timer = slide_timer_max
		#if !has_boost:
		#	is_sliding = true
		#	slide_timer = slide_timer_max
		#states
		is_walking = false
		is_sprinting = false
		#has_boost = false #za slide
		is_crouching = true
	elif !raycast_standup.is_colliding():
		head.position.y = lerp(head.position.y,0.0,delta * lerp_speed)
		crouching_collision.disabled = true
		standing_collision.disabled = false
		if  Input.is_action_pressed("sprint") and is_on_floor():
			if current_speed < sprint_speed: current_speed = sprint_speed
			#states
			is_walking = false
			is_sprinting = true
			#has_boost = true
			is_crouching = false
		elif !Input.is_action_pressed("sprint") and is_on_floor():
			current_speed = walking_speed
			#states
			is_walking = true
			is_sprinting = false
			#has_boost = false
			is_crouching = false

	#FREE LOOK LOGIC
	if Input.is_action_pressed("free_look"):
		is_free_looking = true
		player_cam.rotation.z = -deg_to_rad(neck.rotation.y * free_look_tilt)
	else: 
		is_free_looking = false
		neck.rotation.y = lerp(neck.rotation.y,0.0,delta*lerp_speed)
		player_cam.rotation.z =lerp(player_cam.rotation.z, 0.0, delta*lerp_speed)
	
	#SLIDE LOGIC
	if is_sliding:
		#has_boost = false
		slide_timer -= delta
		if slide_timer <= 0:
			is_sliding = false
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		if is_sliding:
			slide_timer = slide_timer_max
			if current_speed < sprint_speed: current_speed = sprint_speed
			slide_speed = current_speed
		velocity.y += jump_speed
		is_sliding = false
		is_crouching = false
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Get the input direction and handle the movement/deceleration.
	direction =  lerp(direction,(transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized(),delta*lerp_speed)
	
	if direction:
		velocity.x = direction.x * current_speed
		velocity.z = direction.z * current_speed
		if is_sliding:
			velocity.x = direction.x * slide_timer * slide_speed
			velocity.z = direction.z * slide_timer * slide_speed
		
	else:
		velocity.x = move_toward(velocity.x, 0, current_speed)
		velocity.z = move_toward(velocity.z, 0, current_speed)
	
	#print("speed",current_speed)
	#print(slide_speed)
	move_and_slide()
#ako pokusam da slajdujem a ne sprintam onda samo prokliza bez dodavanja slide speeda
