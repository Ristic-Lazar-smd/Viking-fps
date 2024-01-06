extends Node

@export_group("Main Stats")
@export var maxHealth:float = 100
@onready var currentHealth:float = maxHealth
@onready var currentXp:float = 0
@export var xpModifier:float=1
@export var movementSpeed:float = 0
@export_group("Attack")
@export var physicalDmg:int = 0
@export var magicalDmg:int = 0
@export var attackSpeed:float = 0
@export_group("Secondary Stats")
@export var dmgResistance:float  = 0



var magicDmg:bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_takeDamage(20)

func _takeDamage(damage:int):
	if Input.is_action_just_pressed("take_damage") and currentHealth>0:
		print(damage * ((100-dmgResistance)/100))
		currentHealth -= damage * ((100-dmgResistance)/100)

func _gainXp(xp:int):
	currentXp += xp * xpModifier

func _dealDamage() -> int:
	#stavi da zavisi od weapona koji koristis
	if magicDmg==false:
		return physicalDmg
	else:
		return magicalDmg
