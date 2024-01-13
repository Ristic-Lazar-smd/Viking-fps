extends Node3D
class_name Projectile

@export var bullet_speed = 15.0
@onready var ray_cast_3d: RayCast3D = $RayCast3D
@onready var bullet_anim: AnimationPlayer = $BulletAnim

@export var attack_damage = 10.0
@export var knockback_force = 100.0
@export var stun_time = 1.0

var kill_after = 5.0
var direction

func _ready() -> void:
	bullet_anim.play("bullet_spin")

func _process(delta: float) -> void:
	position += (direction * bullet_speed) * delta

	if ray_cast_3d.is_colliding() || kill_after <=0:
		queue_free()
	kill_after -= delta

"""func _on_hitbox_component_area_entered(area: Area3D) -> void:
	if area is HitboxComponent:
		var hitbox : HitboxComponent = area
		var attack = Attack.new()
		attack.attack_damage = attack_damage
		attack.knockback_force = knockback_force
		attack.stun_time = stun_time
		
		hitbox.TakeDamage(attack)"""
