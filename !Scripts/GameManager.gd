extends Node3D

@onready var strengthRunePrefab = preload("res://!Prefabs/Runes/MajorRunes/StrengthRunes/strenght_rune_TEST.tscn")
@onready var dexRunePrefab = preload("res://!Prefabs/Runes/MajorRunes/DexterityRunes/dexterity_rune_TEST.tscn")
@onready var magicRunePrefab = preload("res://!Prefabs/Runes/MajorRunes/MagicRunes/magic_rune_TEST.tscn")
@onready var strenghtRuneContainer = $UI/PopUpGamePause/MajorRunePopUpContainer/NewRunesContainer/NewStrenghtRune/PanelContainer
@onready var dexRuneContainer = $UI/PopUpGamePause/MajorRunePopUpContainer/NewRunesContainer/NewDexterityRune/PanelContainer
@onready var magicRuneContainer = $UI/PopUpGamePause/MajorRunePopUpContainer/NewRunesContainer/NewMagicRune/PanelContainer

@onready var mainContainer = $UI/PopUpGamePause
@onready var majorRunePopUpContainer = $UI/PopUpGamePause/MajorRunePopUpContainer
@onready var closePopUpButton = $UI/PopUpGamePause/ClosePopUpButton
@onready var minorRunePopUpContainer = $UI/PopUpGamePause/MinorRunePopUpContainer


@onready var attackRuneSlotContainer = $UI/PopUpGamePause/MajorRunePopUpContainer/RuneSlotsContainer/AttackSlot/PanelContainer
@onready var actionRuneSlotContainer = $UI/PopUpGamePause/MajorRunePopUpContainer/RuneSlotsContainer/ActionSlot/PanelContainer
@onready var specialRuneSlotContainer = $UI/PopUpGamePause/MajorRunePopUpContainer/RuneSlotsContainer/SpecialSlot/PanelContainer

@onready var newStrenghtRuneButton = $UI/PopUpGamePause/MajorRunePopUpContainer/NewRunesContainer/NewStrenghtRune
@onready var newDexRuneButton = $UI/PopUpGamePause/MajorRunePopUpContainer/NewRunesContainer/NewDexterityRune
@onready var newMagicRuneButton = $UI/PopUpGamePause/MajorRunePopUpContainer/NewRunesContainer/NewMagicRune

@onready var attackSlotButton = $UI/PopUpGamePause/MajorRunePopUpContainer/RuneSlotsContainer/AttackSlot
@onready var actionSlotButton = $UI/PopUpGamePause/MajorRunePopUpContainer/RuneSlotsContainer/ActionSlot
@onready var specialSlotButton = $UI/PopUpGamePause/MajorRunePopUpContainer/RuneSlotsContainer/SpecialSlot

@onready var firstMinorRuneContainer = $UI/PopUpGamePause/MinorRunePopUpContainer/FirstMinorRune/PanelContainer

@onready var healthBar:ProgressBar = $UI/HealthBar
@onready var xpBar:ProgressBar = $UI/XpBar
@onready var playerManager = get_node("/root/PlayerManager")

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
	healthBar.value = playerManager.currentHealth
	xpBar.value = playerManager.currentXp
	_activateSlottedRunes()
	if Input.is_action_just_pressed("levelup"):
		_minorRunePopUp()
	if Input.is_action_just_pressed("inventory"):
		
		strengthRuneInstance = strengthRunePrefab.instantiate()
		strenghtRuneContainer.add_child(strengthRuneInstance)
		
		dexRuneInstance = dexRunePrefab.instantiate()
		dexRuneContainer.add_child(dexRuneInstance)
		
		magicRuneInstance = magicRunePrefab.instantiate()
		magicRuneContainer.add_child(magicRuneInstance)
		
		mainContainer.visible = true
		majorRunePopUpContainer.visible = true
		closePopUpButton.visible = true
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
	majorRunePopUpContainer.visible = false
	closePopUpButton.visible = true
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _minorRunePopUp():
	mainContainer.visible = true
	minorRunePopUpContainer.visible = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _on_first_minor_rune_pressed():
	#runa radi poso
	firstMinorRuneContainer.get_child(0)._activateRuneEffect()
	mainContainer.visible = false
	minorRunePopUpContainer.visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _on_second_minor_rune_pressed():
	#runa radi poso
	mainContainer.visible = false
	minorRunePopUpContainer.visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _on_third_minor_rune_pressed():
	#runa radi poso
	mainContainer.visible = false
	minorRunePopUpContainer.visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
