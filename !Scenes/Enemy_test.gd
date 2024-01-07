extends AnimatedSprite3D

@onready var aleksa: CharacterBody3D = $"../../Aleksa"

var camera_pos

func _ready() -> void:
	play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	camera_pos = aleksa.global_transform.origin
	camera_pos.y = 0
	look_at(camera_pos, Vector3.UP,true)

