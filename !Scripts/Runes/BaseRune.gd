extends Node
class_name BaseRune

@export var runeName: String
@export var primaryEffectText: String
@export var actionEffectText: String
@export var specialEffectText: String

@onready var whereIsRuneSlotted:String = "None"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_checkRuneSlot()


func _attackRuneEffect() -> void:
	pass

func _actionRuneEffect() -> void:
	pass

func _specialRuneEffect() -> void:
	pass

func _checkRuneSlot() -> void:
	match whereIsRuneSlotted:
		"Attack":
			_attackRuneEffect()
		"Action":
			_actionRuneEffect()
		"Special":
			_specialRuneEffect()
		"None":
			pass
