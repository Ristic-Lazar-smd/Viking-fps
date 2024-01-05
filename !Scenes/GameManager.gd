extends Node3D

@onready var runePrefab = preload("res://!Prefabs/rune_prefab.tscn")
@onready var strenghtRuneContainer = $UI/RunePopUpContainer/NewRunesContainer/NewStrenghtRune/PanelContainer
@onready var dexRuneContainer = $UI/RunePopUpContainer/NewRunesContainer/NewDexterityRune/PanelContainer
@onready var magicRuneContainer = $UI/RunePopUpContainer/NewRunesContainer/NewMagicRune/PanelContainer

@onready var mainContainer = $UI/RunePopUpContainer



@onready var attackRuneSlot = $UI/RunePopUpContainer/RuneSlotsContainer/AttackSlot/PanelContainer
@onready var actionRuneSlot = $UI/RunePopUpContainer/RuneSlotsContainer/ActionSlot/PanelContainer
@onready var specialRuneSlot = $UI/RunePopUpContainer/RuneSlotsContainer/SpecialSlot/PanelContainer


var isInventoryOpen = false
var selectedRune
var isAttackSlotOccupied = false
var isActionSlotOccupied = false
var isSpecialSlotOccupied = false
# Called when the node enters the scene tree for the first time.
func _ready():
	var sRuneInstance = runePrefab.instantiate()
	strenghtRuneContainer.add_child(sRuneInstance)
	
	var dRuneInstance = runePrefab.instantiate()
	dexRuneContainer.add_child(dRuneInstance)
	
	var mRuneInstance = runePrefab.instantiate()
	magicRuneContainer.add_child(mRuneInstance)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("inventory") and isInventoryOpen==false:

		mainContainer.visible = true
		isInventoryOpen = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
	elif Input.is_action_just_pressed("inventory") and isInventoryOpen==true:
		mainContainer.visible = false
		isInventoryOpen = false
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


func _on_new_strenght_rune_pressed():
	selectedRune = strenghtRuneContainer.get_child(0)
	


func _on_attack_slot_pressed():
	if selectedRune != null and isAttackSlotOccupied==false:
		selectedRune.reparent(attackRuneSlot)
		selectedRune = null
		isAttackSlotOccupied = true


func _on_new_dexterity_rune_pressed():
	selectedRune = dexRuneContainer.get_child(0)


func _on_new_magic_rune_pressed():
	selectedRune = magicRuneContainer.get_child(0)


func _on_action_slot_pressed():
	if selectedRune != null and isActionSlotOccupied==false:
		selectedRune.reparent(actionRuneSlot)
		selectedRune = null
		isActionSlotOccupied = true


func _on_special_slot_pressed():
	if selectedRune != null and isSpecialSlotOccupied==false:
		selectedRune.reparent(specialRuneSlot)
		selectedRune = null
		isSpecialSlotOccupied = true