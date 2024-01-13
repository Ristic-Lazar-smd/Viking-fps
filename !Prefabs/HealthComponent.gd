extends Node3D
class_name HealthComponent

@export var max_health := 10.0
var health : float

func _ready() -> void:
	health = max_health

func TakeDamage (attack: Attack):
	health -= attack.attack_damage
	if health <=0: get_parent().queue_free()
