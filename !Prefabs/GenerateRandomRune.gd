extends TextureRect

@onready var runeImg1 = preload("res://!Sprites/runeTest.png")
@onready var runeImg2 = preload("res://!Sprites/runeTest2.png")

var rng = RandomNumberGenerator.new()
var r = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	r = rng.randi_range(1,2)
	if r!=0:
		if r==1:
			set_texture(runeImg1)
		elif r==2:
			set_texture(runeImg2)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
