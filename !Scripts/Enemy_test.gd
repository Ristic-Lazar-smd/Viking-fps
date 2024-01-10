extends CharacterBody3D

@onready var animated_sprite: AnimatedSprite3D = $AnimatedSprite
@onready var nav: NavigationAgent3D = $"../CharacterBody3D/NavigationAgent3D"
@export var player_path : NodePath
var player = null

var camera_pos

var speed = 2
var acc = 10
var direction = Vector3()

func _ready() -> void:
	player = get_node(player_path)
	animated_sprite.play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	camera_pos = player.global_transform.origin
	camera_pos.y = 0
	look_at(camera_pos, Vector3.UP,false)
	
func _physics_process(delta: float) -> void:
	velocity = Vector3.ZERO
	nav.set_target_position(player.global_transform.origin)
	var next_nav_point = nav.get_next_path_position()
	velocity = (next_nav_point - global_transform.origin).normalized() * speed
	move_and_slide()
	

