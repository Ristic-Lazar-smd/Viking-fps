extends Node3D

@onready var world: Node3D = $"../../../../../.."
@onready var axe_r: MeshInstance3D = $AxeR
@onready var axe_anim: AnimationPlayer = $AxeR/AxeAnim
@onready var aim_ray: RayCast3D = $AimRay
@onready var player_cam: Camera3D = $".."

var bullet = load("res://!Prefabs/bullet.tscn")
var bullet_instance
var bullet_direction

var target_point
	
func _process(delta: float) -> void:
	if Input.is_action_pressed("LMB"):
		if (aim_ray.is_colliding()):
			target_point = aim_ray.get_collision_point()
		target_point = -(aim_ray.global_transform.origin + aim_ray.global_transform.basis.z.normalized() * 100000.0)
		bullet_direction = target_point - axe_r.global_position
		
		if !axe_anim.is_playing():
			axe_anim.play("axe_toss")
			bullet_instance = bullet.instantiate()
			bullet_instance.position = axe_r.global_position
			bullet_instance.transform.basis = player_cam.global_transform.basis
			
			bullet_instance.direction = bullet_direction.normalized()
			world.add_child(bullet_instance)
			
		DrawLine3d.DrawLine(axe_r.global_position,target_point, Color(0,0,1))
