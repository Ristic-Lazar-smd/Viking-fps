extends CharacterBody3D
#mozda optimizuj jednog dana :)
@onready var neck = $Neck
@onready var head  = $Neck/Head
@onready var eyes: Node3D = $Neck/Head/Eyes
@onready var player_cam: Camera3D = $Neck/Head/Eyes/PlayerCam
@onready var standing_collision = $StandingCollision
@onready var crouching_collision = $CrouchingCollision
@onready var raycast_standup = $RayCast3D
@onready var head_bob_anim: AnimationPlayer = $Neck/Head/Eyes/HeadBobAnim



#SPEEDS
@export var walking_speed = 5.0
@export var sprint_speed = 10.0
@export var crouch_speed = 3.0
@export var jump_speed = 4.5
@export var jump_boost_speed = 15.0

@export var mouse_sens = 0.15
@export var gravity = 12
@export var crouch_depth = -0.5

var current_speed = walking_speed
var direction = Vector3.ZERO
var lerp_speed = 10.0
var free_look_tilt = 3.5
var last_input_dir = Vector3.ZERO
#slide vars
var slide_timer = 0.0
var slide_timer_max = 1.0
var slide_direction = Vector2.ZERO
var slide_speed
var can_slide=true
var can_jump_boost = true
#Head bobbing vars
@export_group("Head bob vars")
@export var head_bobbing_walking_speed = 14.0
@export var head_bobbing_sprinting_speed = 22.0
@export var head_bobbing_crouching_speed = 10.0
@export var head_bobbing_walking_intensity = 0.1
@export var head_bobbing_sprinting_intensity = 0.2
@export var head_bobbing_crouching_intensity = 0.05

var head_bobbing_speed = 10.0
var head_bobbing_intensity = 0.2
var head_bobbing_vector = Vector2.ZERO
var head_bobbing_index = 0.0

#states
var is_sprinting = false
var is_free_looking = false
var is_sliding = false
var is_crouching = false

var last_player_velocity = Vector2.ZERO


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		cameraMove(event)

func _physics_process(delta):
	var input_dir := Input.get_vector("left", "right", "up", "down")
	# Get the input direction and handle the movement/deceleration.
	_movementHandler(delta, input_dir)
	
	#CROUCH AND SPRINT LOGIC START
	if Input.is_action_pressed("crouch") && is_on_floor() || is_sliding:
		current_speed = lerp(current_speed, crouch_speed, delta * lerp_speed)
		head.position.y = lerp(head.position.y,crouch_depth,delta * lerp_speed)
		crouching_collision.disabled = false
		standing_collision.disabled = true
		#slide
		if is_sprinting:
			is_crouching = false
			is_sliding = true
			slide_speed = current_speed
			slide_timer = slide_timer_max
		is_crouching = true
		is_sprinting = false
	#Walk and sprint
	elif !raycast_standup.is_colliding():
		head.position.y = lerp(head.position.y,0.0,delta * lerp_speed)
		crouching_collision.disabled = true
		standing_collision.disabled = false
		is_crouching = false
		if  Input.is_action_pressed("sprint") and is_on_floor():
			current_speed = lerp(current_speed, sprint_speed, delta * lerp_speed)
			is_sprinting = true
			can_jump_boost = true
		elif !Input.is_action_pressed("sprint") and is_on_floor():
			current_speed = lerp(current_speed, walking_speed, delta * lerp_speed)
			is_sprinting = false

	#FREE LOOK LOGIC-------------------------------------
	if Input.is_action_pressed("free_look"):
		is_free_looking = true
		player_cam.rotation.z = -deg_to_rad(neck.rotation.y * free_look_tilt)
	else: 
		is_free_looking = false
		neck.rotation.y = lerp(neck.rotation.y,0.0,delta*lerp_speed)
		player_cam.rotation.z =lerp(player_cam.rotation.z, 0.0, delta*lerp_speed)
	
	#SLIDE TIMER
	if is_sliding:
		slide_timer -= delta
		if slide_timer <= 0:
			is_sliding = false
			can_slide = true
		
	#SLIDE LOGIC
	if ((round(abs(velocity.x) + abs(velocity.y) + abs(velocity.z))>walking_speed)&&(Input.is_action_pressed("crouch") && is_on_floor()) && can_slide):
		can_slide = false
		is_sliding = true
		slide_speed = current_speed
		slide_timer = slide_timer_max
		
	#JUMP LOGIC
	if Input.is_action_just_pressed("jump") and is_on_floor():
		is_sprinting = false
		if is_sliding:
			can_slide = true
			if current_speed < jump_boost_speed && can_jump_boost: 
				current_speed = lerp(current_speed,jump_boost_speed,delta*lerp_speed)
				can_jump_boost = false
		velocity.y += jump_speed
		is_sliding = false
	if not is_on_floor():
		velocity.y -= gravity * delta
		
	#HEAD BOB LOGIC----------------------------------
	if is_sprinting:
		head_bobbing_intensity = head_bobbing_sprinting_intensity
		head_bobbing_index += head_bobbing_sprinting_speed * delta
	elif is_crouching:
		head_bobbing_intensity = head_bobbing_crouching_intensity
		head_bobbing_index += head_bobbing_crouching_speed * delta
	else:
		head_bobbing_intensity = head_bobbing_walking_intensity
		head_bobbing_index += head_bobbing_walking_speed * delta
	if is_on_floor() && !is_sliding && input_dir != Vector2.ZERO:
		head_bobbing_vector.y = sin(head_bobbing_index)
		head_bobbing_vector.x = sin(head_bobbing_index/2)+0.5
		eyes.position.y = lerp(eyes.position.y,head_bobbing_vector.y*(head_bobbing_intensity/2.0),delta*lerp_speed)
		eyes.position.x = lerp(eyes.position.x,head_bobbing_vector.x*(head_bobbing_intensity),delta*lerp_speed)
	else:
		eyes.position.x = lerp(eyes.position.x,0.0,delta*lerp_speed)
		eyes.position.y = lerp(eyes.position.y,0.0,delta*lerp_speed)
	
	#Head bob animation on landing
	if is_on_floor() && last_player_velocity.y < 0:
		print("bob")
		head_bob_anim.stop()
		head_bob_anim.play("player_land")
		
	
#--FUNCS--
func _movementHandler(delta,input_dir):
	direction =  lerp(direction,(transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized(),delta*lerp_speed)
	
	#jump zadrzi momentum
	if input_dir != Vector2.ZERO:
		last_input_dir = Vector3(input_dir.x, 0, input_dir.y)
	if input_dir == Vector2.ZERO && (Input.is_action_just_pressed("jump") and is_on_floor()):
		last_input_dir = Vector3.ZERO
	if !is_on_floor() && input_dir == Vector2.ZERO:
		direction =  lerp(direction,(transform.basis * last_input_dir).normalized(),delta*lerp_speed)
		
	#slide slow down rate
	if is_sliding: current_speed =  sqrt(1 - pow(slide_timer - 1, 2)) * slide_speed
	
	if direction:
		velocity.x = direction.x * current_speed
		velocity.z = direction.z * current_speed
	else:
		velocity.x = move_toward(velocity.x, 0, current_speed)
		velocity.z = move_toward(velocity.z, 0, current_speed)
	last_player_velocity = velocity
	move_and_slide()


func cameraMove(event: InputEvent): #Mouse input logic
	if is_free_looking:
		neck.rotate_y(deg_to_rad(-event.relative.x * mouse_sens))
		neck.rotation.y = clamp(neck.rotation.y,deg_to_rad(-80),deg_to_rad(80))
	else:
		rotate_y(deg_to_rad(-event.relative.x * mouse_sens))
	head.rotate_x(deg_to_rad(-event.relative.y * mouse_sens))
	head.rotation.x = clamp(head.rotation.x,deg_to_rad(-89),deg_to_rad(89))
