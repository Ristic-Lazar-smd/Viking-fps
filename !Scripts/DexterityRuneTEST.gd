extends DexterityRune


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super._process(delta)

func _attackRuneEffect() -> void:
	if Input.is_action_just_pressed("LMB"):
		print("DEX ATTACK")

func _actionRuneEffect() -> void:
	if Input.is_action_just_pressed("RMB"):
		print("DEX ACTION")

func _specialRuneEffect() -> void:
	super._specialRuneEffect()
