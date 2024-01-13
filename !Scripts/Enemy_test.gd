extends CharacterBody3D

@onready var animated_sprite: AnimatedSprite3D = $AnimatedSprite
@onready var nav: NavigationAgent3D = $NavigationAgent3D
@export var player_path : NodePath

var player
var camera_pos
var direction
var next_nav_point

@export var speed = 2

func _ready() -> void:
	player = get_node(player_path)
	animated_sprite.play("default")

func _process(delta: float) -> void:
	camera_pos = player.global_transform.origin
	camera_pos.y = 0
	look_at(camera_pos, Vector3.UP)

func _physics_process(delta: float) -> void:
	nav.set_target_position(player.global_transform.origin)
	next_nav_point = nav.get_next_path_position() #trenutno baca error zato sto je u sceni pre map synca
	velocity = (next_nav_point - global_transform.origin).normalized() * speed
	move_and_slide()


func _on_hitbox_component_area_entered(area: Area3D) -> void:
	print("test")
