extends TextureRect

@onready var runeImg1 = preload("res://!Sprites/runeTest.png")
@onready var runeImg2 = preload("res://!Sprites/runeTest2.png")
@onready var runeImg3 = preload("res://!Sprites/runeTest3.png")
@onready var runeImg4 = preload("res://!Sprites/runeTest4.png")
@onready var runeImg5 = preload("res://!Sprites/runeTest5.png")
@onready var runeImg6 = preload("res://!Sprites/runeTest6.png")

var rng = RandomNumberGenerator.new()
var r = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	#r = rng.randi_range(1,6)
	#if r!=0:
	#	if r==1:
	#		set_texture(runeImg1)
	#	elif r==2:
	#		set_texture(runeImg2)
	#	elif r==3:
	#		set_texture(runeImg3)
	#	elif r==4:
	#		set_texture(runeImg4)
	#	elif r==5:
	#		set_texture(runeImg5)
	#	elif r==2:
	#		set_texture(runeImg2)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
