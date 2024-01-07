extends Node3D

@export var bullet_speed = 15.0
@onready var ray_cast_3d: RayCast3D = $RayCast3D
@onready var bullet_anim: AnimationPlayer = $BulletAnim

var kill_after = 5.0

var direction
func _ready() -> void:
	bullet_anim.play("bullet_spin")

func _process(delta: float) -> void:
	position += (direction * bullet_speed) * delta

	if ray_cast_3d.is_colliding() || kill_after <=0:
		queue_free()
	
	#timer
	kill_after -= delta
