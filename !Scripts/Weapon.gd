extends Node3D

@onready var world: Node3D = $"../../../../../.."
@onready var axe_r: MeshInstance3D = $AxeR
@onready var axe_anim: AnimationPlayer = $AxeR/AxeAnim
@onready var shoot_dir: RayCast3D = $ShootDir

@onready var ajde: RayCast3D = $AxeR/ajde

var test

var bullet = load("res://!Prefabs/bullet.tscn")
var bullet_instance

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("LMB"):
		
		test = shoot_dir.get_collision_point() - axe_r.global_position
		DrawLine3d.DrawLine(axe_r.global_position, shoot_dir.get_collision_point(), Color(0,0,1))
		
		ajde.target_position = test
		print(ajde.target_position)
		
		if !axe_anim.is_playing():
			axe_anim.play("axe_toss")
			bullet_instance = bullet.instantiate()
			bullet_instance.position = ajde.global_position
			bullet_instance.transform.basis = ajde.transform.basis
			
			bullet_instance.pew_dir = test
			world.add_child(bullet_instance)
			
