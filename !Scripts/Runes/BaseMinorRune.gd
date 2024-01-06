extends Node
class_name BaseMinorRune

@export var runeName: String
@export var runeEffectText: String
@onready var playerManager = get_node("/root/PlayerManager")



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _activateRuneEffect():
	pass
