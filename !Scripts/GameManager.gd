extends Node3D

@onready var strengthRunePrefab = preload("res://!Prefabs/Runes/MajorRunes/StrengthRunes/strenght_rune_TEST.tscn")
@onready var dexRunePrefab = preload("res://!Prefabs/Runes/MajorRunes/DexterityRunes/dexterity_rune_TEST.tscn")
@onready var magicRunePrefab = preload("res://!Prefabs/Runes/MajorRunes/MagicRunes/magic_rune_TEST.tscn")
@onready var strenghtRuneContainer = $UI/PopUpGamePause/RunePopUpContainer/NewRunesContainer/NewStrenghtRune/PanelContainer
@onready var dexRuneContainer = $UI/PopUpGamePause/RunePopUpContainer/NewRunesContainer/NewDexterityRune/PanelContainer
@onready var magicRuneContainer = $UI/PopUpGamePause/RunePopUpContainer/NewRunesContainer/NewMagicRune/PanelContainer

@onready var mainContainer = $UI/PopUpGamePause

@onready var attackRuneSlotContainer = $UI/PopUpGamePause/RunePopUpContainer/RuneSlotsContainer/AttackSlot/PanelContainer
@onready var actionRuneSlotContainer = $UI/PopUpGamePause/RunePopUpContainer/RuneSlotsContainer/ActionSlot/PanelContainer
@onready var specialRuneSlotContainer = $UI/PopUpGamePause/RunePopUpContainer/RuneSlotsContainer/SpecialSlot/PanelContainer

@onready var newStrenghtRuneButton = $UI/PopUpGamePause/RunePopUpContainer/NewRunesContainer/NewStrenghtRune
@onready var newDexRuneButton = $UI/PopUpGamePause/RunePopUpContainer/NewRunesContainer/NewDexterityRune
@onready var newMagicRuneButton = $UI/PopUpGamePause/RunePopUpContainer/NewRunesContainer/NewMagicRune

@onready var attackSlotButton = $UI/PopUpGamePause/RunePopUpContainer/RuneSlotsContainer/AttackSlot
@onready var actionSlotButton = $UI/PopUpGamePause/RunePopUpContainer/RuneSlotsContainer/ActionSlot
@onready var specialSlotButton = $UI/PopUpGamePause/RunePopUpContainer/RuneSlotsContainer/SpecialSlot

var selectedRune
var strengthRuneInstance
var dexRuneInstance
var magicRuneInstance
var runeChosen:bool = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_activateSlottedRunes()
	if Input.is_action_just_pressed("inventory"):
		
		strengthRuneInstance = strengthRunePrefab.instantiate()
		strenghtRuneContainer.add_child(strengthRuneInstance)
		
		dexRuneInstance = dexRunePrefab.instantiate()
		dexRuneContainer.add_child(dexRuneInstance)
		
		magicRuneInstance = magicRunePrefab.instantiate()
		magicRuneContainer.add_child(magicRuneInstance)
		
		mainContainer.visible = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _on_new_strenght_rune_pressed():
	if selectedRune!=null and strenghtRuneContainer.get_child_count()!=0:
		strenghtRuneContainer.get_child(0).reparent(selectedRune.get_parent())
		selectedRune.reparent(strenghtRuneContainer)
		selectedRune=null
		if runeChosen==false:
			dexRuneContainer.get_child(0).queue_free()
			magicRuneContainer.get_child(0).queue_free()
			runeChosen=true

	else:
		if strenghtRuneContainer.get_child_count()!=0:
			selectedRune = strenghtRuneContainer.get_child(0)
		if runeChosen==false:
			dexRuneContainer.get_child(0).queue_free()
			magicRuneContainer.get_child(0).queue_free()
			runeChosen=true


func _on_attack_slot_pressed():
	if selectedRune == null:
		selectedRune = attackRuneSlotContainer.get_child(0)
	else:
		if selectedRune != null:
			attackRuneSlotContainer.get_child(0).reparent(selectedRune.get_parent())
			selectedRune.reparent(attackRuneSlotContainer)
			selectedRune = null


func _on_new_dexterity_rune_pressed():
	if selectedRune!=null and dexRuneContainer.get_child_count()!=0:
		dexRuneContainer.get_child(0).reparent(selectedRune.get_parent())
		selectedRune.reparent(dexRuneContainer)
		selectedRune=null
		if runeChosen==false:
			strenghtRuneContainer.get_child(0).queue_free()
			magicRuneContainer.get_child(0).queue_free()
			runeChosen=true

	else:
		if dexRuneContainer.get_child_count()!=0:
			selectedRune = dexRuneContainer.get_child(0)
		if runeChosen==false:
			strenghtRuneContainer.get_child(0).queue_free()
			magicRuneContainer.get_child(0).queue_free()
			runeChosen=true


func _on_new_magic_rune_pressed():
	if selectedRune!=null and magicRuneContainer.get_child_count()!=0:
		magicRuneContainer.get_child(0).reparent(selectedRune.get_parent())
		selectedRune.reparent(magicRuneContainer)
		selectedRune=null
		if runeChosen==false:
			strenghtRuneContainer.get_child(0).queue_free()
			dexRuneContainer.get_child(0).queue_free()
			runeChosen=true

	else:
		if magicRuneContainer.get_child_count()!=0:
			selectedRune = magicRuneContainer.get_child(0)
		if runeChosen==false:
			strenghtRuneContainer.get_child(0).queue_free()
			dexRuneContainer.get_child(0).queue_free()
			runeChosen=true


func _on_action_slot_pressed():
	if selectedRune == null:
		selectedRune = actionRuneSlotContainer.get_child(0)
	else:
		if selectedRune != null:
			actionRuneSlotContainer.get_child(0).reparent(selectedRune.get_parent())
			selectedRune.reparent(actionRuneSlotContainer)
			selectedRune = null


func _on_special_slot_pressed():
	if selectedRune == null:
		selectedRune = specialRuneSlotContainer.get_child(0)
	else:
		if selectedRune != null:
			specialRuneSlotContainer.get_child(0).reparent(selectedRune.get_parent())
			selectedRune.reparent(specialRuneSlotContainer)
			selectedRune = null

func _activateSlottedRunes() -> void:
	attackRuneSlotContainer.get_child(0).whereIsRuneSlotted = "Attack"
	actionRuneSlotContainer.get_child(0).whereIsRuneSlotted = "Action"
	specialRuneSlotContainer.get_child(0).whereIsRuneSlotted = "Special"


func _on_close_pop_up_button_pressed():
	if strenghtRuneContainer.get_child_count()!=0:
		strenghtRuneContainer.get_child(0).queue_free()
	if dexRuneContainer.get_child_count()!=0:
		dexRuneContainer.get_child(0).queue_free()
	if magicRuneContainer.get_child_count()!=0:
		magicRuneContainer.get_child(0).queue_free()
	selectedRune = null
	runeChosen = false
	mainContainer.visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
