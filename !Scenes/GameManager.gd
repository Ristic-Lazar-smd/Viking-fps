extends Node3D

@onready var runePrefab = preload("res://!Prefabs/rune_prefab.tscn")
@onready var strenghtRuneContainer = $UI/RunePopUpContainer/NewRunesContainer/NewStrenghtRune/PanelContainer
@onready var dexRuneContainer = $UI/RunePopUpContainer/NewRunesContainer/NewDexterityRune/PanelContainer
@onready var magicRuneContainer = $UI/RunePopUpContainer/NewRunesContainer/NewMagicRune/PanelContainer

@onready var mainContainer = $UI/RunePopUpContainer

@onready var attackRuneSlotContainer = $UI/RunePopUpContainer/RuneSlotsContainer/AttackSlot/PanelContainer
@onready var actionRuneSlotContainer = $UI/RunePopUpContainer/RuneSlotsContainer/ActionSlot/PanelContainer
@onready var specialRuneSlotContainer = $UI/RunePopUpContainer/RuneSlotsContainer/SpecialSlot/PanelContainer

@onready var newStrenghtRuneButton = $UI/RunePopUpContainer/NewRunesContainer/NewStrenghtRune
@onready var newDexRuneButton = $UI/RunePopUpContainer/NewRunesContainer/NewDexterityRune
@onready var newMagicRuneButton = $UI/RunePopUpContainer/NewRunesContainer/NewMagicRune

@onready var attackSlotButton = $UI/RunePopUpContainer/RuneSlotsContainer/AttackSlot
@onready var actionSlotButton = $UI/RunePopUpContainer/RuneSlotsContainer/ActionSlot
@onready var specialSlotButton = $UI/RunePopUpContainer/RuneSlotsContainer/SpecialSlot



var isInventoryOpen = false
var selectedRune
var selectedRuneTag


# Called when the node enters the scene tree for the first time.
func _ready():
	#var sRuneInstance = runePrefab.instantiate()
	#strenghtRuneContainer.add_child(sRuneInstance)
	
	#var dRuneInstance = runePrefab.instantiate()
	#dexRuneContainer.add_child(dRuneInstance)
	
	#var mRuneInstance = runePrefab.instantiate()
	#magicRuneContainer.add_child(mRuneInstance)
	
	#var attackRuneInstance = runePrefab.instantiate()
	#attackRuneSlotContainer.add_child(attackRuneInstance)
	
	#var actionRuneInstance = runePrefab.instantiate()
	#actionRuneSlotContainer.add_child(actionRuneInstance)
	
	#var specialRuneInstance = runePrefab.instantiate()
	#specialRuneSlotContainer.add_child(specialRuneInstance)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("inventory") and isInventoryOpen==false:

		mainContainer.visible = true
		isInventoryOpen = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
	elif Input.is_action_just_pressed("inventory") and isInventoryOpen==true:
		mainContainer.visible = false
		isInventoryOpen = false
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _on_new_strenght_rune_pressed():
	if selectedRune!=null:
		match selectedRuneTag:
				"at":
					strenghtRuneContainer.get_child(0).reparent(attackRuneSlotContainer)
					selectedRune.reparent(strenghtRuneContainer)
					selectedRune = null
					newDexRuneButton.disabled = true
					newMagicRuneButton.disabled = true
				"sp":
					strenghtRuneContainer.get_child(0).reparent(specialRuneSlotContainer)
					selectedRune.reparent(strenghtRuneContainer)
					selectedRune = null
					newDexRuneButton.disabled = true
					newMagicRuneButton.disabled = true
				"ac":
					strenghtRuneContainer.get_child(0).reparent(actionRuneSlotContainer)
					selectedRune.reparent(strenghtRuneContainer)
					selectedRune = null
					newDexRuneButton.disabled = true
					newMagicRuneButton.disabled = true
	else:
		selectedRune = strenghtRuneContainer.get_child(0)
		selectedRuneTag = "s"
		newStrenghtRuneButton.grab_focus()
		newDexRuneButton.disabled = true
		newMagicRuneButton.disabled = true


func _on_attack_slot_pressed():
	if selectedRune == null and attackRuneSlotContainer.get_child(0)!=null:
		selectedRune = attackRuneSlotContainer.get_child(0)
		selectedRuneTag = "at"
		attackSlotButton.grab_focus()
	else:
		if selectedRune != null:
			match selectedRuneTag:
				"s":
					attackRuneSlotContainer.get_child(0).reparent(strenghtRuneContainer)
					selectedRune.reparent(attackRuneSlotContainer)
					selectedRune = null
				"d":
					attackRuneSlotContainer.get_child(0).reparent(dexRuneContainer)
					selectedRune.reparent(attackRuneSlotContainer)
					selectedRune = null
				"m":
					attackRuneSlotContainer.get_child(0).reparent(magicRuneContainer)
					selectedRune.reparent(attackRuneSlotContainer)
					selectedRune = null
				"ac":
					attackRuneSlotContainer.get_child(0).reparent(actionRuneSlotContainer)
					selectedRune.reparent(attackRuneSlotContainer)
					selectedRune = null
				"sp":
					attackRuneSlotContainer.get_child(0).reparent(specialRuneSlotContainer)
					selectedRune.reparent(attackRuneSlotContainer)
					selectedRune = null


func _on_new_dexterity_rune_pressed():
	if selectedRune!=null:
		match selectedRuneTag:
				"at":
					dexRuneContainer.get_child(0).reparent(attackRuneSlotContainer)
					selectedRune.reparent(dexRuneContainer)
					selectedRune = null
					newStrenghtRuneButton.disabled = true
					newMagicRuneButton.disabled = true
				"sp":
					dexRuneContainer.get_child(0).reparent(specialRuneSlotContainer)
					selectedRune.reparent(dexRuneContainer)
					selectedRune = null
					newStrenghtRuneButton.disabled = true
					newMagicRuneButton.disabled = true
				"ac":
					dexRuneContainer.get_child(0).reparent(actionRuneSlotContainer)
					selectedRune.reparent(dexRuneContainer)
					selectedRune = null
					newStrenghtRuneButton.disabled = true
					newMagicRuneButton.disabled = true
	else:
		selectedRune = dexRuneContainer.get_child(0)
		selectedRuneTag = "d"
		newDexRuneButton.grab_focus()
		newStrenghtRuneButton.disabled = true
		newMagicRuneButton.disabled = true


func _on_new_magic_rune_pressed():
	if selectedRune!=null:
		match selectedRuneTag:
				"at":
					magicRuneContainer.get_child(0).reparent(attackRuneSlotContainer)
					selectedRune.reparent(magicRuneContainer)
					selectedRune = null
					newDexRuneButton.disabled = true
					newStrenghtRuneButton.disabled = true
				"sp":
					magicRuneContainer.get_child(0).reparent(specialRuneSlotContainer)
					selectedRune.reparent(magicRuneContainer)
					selectedRune = null
					newDexRuneButton.disabled = true
					newStrenghtRuneButton.disabled = true
				"ac":
					magicRuneContainer.get_child(0).reparent(actionRuneSlotContainer)
					selectedRune.reparent(magicRuneContainer)
					selectedRune = null
					newDexRuneButton.disabled = true
					newStrenghtRuneButton.disabled = true
					
	else:
		selectedRune = magicRuneContainer.get_child(0)
		selectedRuneTag = "m"
		newMagicRuneButton.grab_focus()
		newDexRuneButton.disabled = true
		newStrenghtRuneButton.disabled = true


func _on_action_slot_pressed():
	if selectedRune == null and actionRuneSlotContainer.get_child(0)!=null:
		selectedRune = actionRuneSlotContainer.get_child(0)
		selectedRuneTag = "ac"
		actionSlotButton.grab_focus()
	else:
		if selectedRune != null:
			match selectedRuneTag:
				"s":
					actionRuneSlotContainer.get_child(0).reparent(strenghtRuneContainer)
					selectedRune.reparent(actionRuneSlotContainer)
					selectedRune = null
				"d":
					actionRuneSlotContainer.get_child(0).reparent(dexRuneContainer)
					selectedRune.reparent(actionRuneSlotContainer)
					selectedRune = null
				"m":
					actionRuneSlotContainer.get_child(0).reparent(magicRuneContainer)
					selectedRune.reparent(actionRuneSlotContainer)
					selectedRune = null
				"at":
					actionRuneSlotContainer.get_child(0).reparent(attackRuneSlotContainer)
					selectedRune.reparent(actionRuneSlotContainer)
					selectedRune = null
				"sp":
					actionRuneSlotContainer.get_child(0).reparent(specialRuneSlotContainer)
					selectedRune.reparent(actionRuneSlotContainer)
					selectedRune = null


func _on_special_slot_pressed():
	if selectedRune == null and specialRuneSlotContainer.get_child(0)!=null:
		selectedRune = specialRuneSlotContainer.get_child(0)
		selectedRuneTag = "sp"
		specialSlotButton.grab_focus()
	else:
		if selectedRune != null:
			match selectedRuneTag:
				"s":
					specialRuneSlotContainer.get_child(0).reparent(strenghtRuneContainer)
					selectedRune.reparent(specialRuneSlotContainer)
					selectedRune = null
				"d":
					specialRuneSlotContainer.get_child(0).reparent(dexRuneContainer)
					selectedRune.reparent(specialRuneSlotContainer)
					selectedRune = null
				"m":
					specialRuneSlotContainer.get_child(0).reparent(magicRuneContainer)
					selectedRune.reparent(specialRuneSlotContainer)
					selectedRune = null
				"at":
					specialRuneSlotContainer.get_child(0).reparent(attackRuneSlotContainer)
					selectedRune.reparent(specialRuneSlotContainer)
					selectedRune = null
				"ac":
					specialRuneSlotContainer.get_child(0).reparent(actionRuneSlotContainer)
					selectedRune.reparent(specialRuneSlotContainer)
					selectedRune = null
