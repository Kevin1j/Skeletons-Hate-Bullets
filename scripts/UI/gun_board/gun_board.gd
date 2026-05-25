extends Node

"""Don't forget to update the ScoreManager with the new gun for saving"""
@onready var ak_47 = $TextureRect/ak_47
@onready var deagle = $TextureRect/deagle
@onready var ump_45 = $TextureRect/ump_45
var gun_selected = ak_47
var guns = []

signal equip_weapon(gun:String)

func _ready():
	guns.append(ak_47)
	guns.append(deagle)
	guns.append(ump_45)
	for gun in guns:
		validate_state(gun)

func _on_ak_47_pressed() -> void:
	weapon_pressed(ak_47)
	
func _on_deagle_pressed() -> void:
	weapon_pressed(deagle)

func _on_ump_45_pressed() -> void:
	weapon_pressed(ump_45)
	
func weapon_pressed(weapon):
	var price_tag = weapon.get_child(0)
	if ScoreManager.weapons_unlocked[weapon.name] == false:
		if ScoreManager.bones < price_tag.price:
			weapon.button_pressed = false
			return
		ScoreManager.bones = ScoreManager.bones - price_tag.price
		price_tag.visible = false
		ScoreManager.weapons_unlocked[weapon.name] = true
	gun_selected = weapon
	equip_weapon.emit(weapon.name)
	for gun in guns:
		validate_state(gun)

func validate_state(weapon):
	var price_tag = weapon.get_child(0)
	if ScoreManager.weapons_unlocked[weapon.name] == true:
		price_tag.visible = false
	if GlobalValues.weapon_equipped == weapon.name:
		weapon.button_pressed = true
	else:
		weapon.button_pressed = false
