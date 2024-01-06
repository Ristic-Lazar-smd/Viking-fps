extends Node3D

@export var bullet_speed = 40.0
@onready var ray_cast_3d: RayCast3D = $RayCast3D
@onready var bullet_anim: AnimationPlayer = $BulletAnim

var pew_dir
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bullet_anim.play("bullet_spin")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += (transform.basis * (pew_dir.normalized()))*delta

