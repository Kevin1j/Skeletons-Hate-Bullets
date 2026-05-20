extends Node

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

func _on_ak_47_pressed() -> void:
	gun_selected = ak_47
	equip_weapon.emit("ak_47")
	for gun in guns:
		if gun == ak_47:
			gun.button_pressed = true
		else:
			gun.button_pressed = false

func _on_deagle_pressed() -> void:
	gun_selected = deagle
	equip_weapon.emit("deagle")
	for gun in guns:
		if gun == deagle:
			gun.button_pressed = true
		else:
			gun.button_pressed = false

func _on_ump_45_pressed() -> void:
	gun_selected = ump_45
	equip_weapon.emit("ump_45")
	for gun in guns:
		if gun == ump_45:
			gun.button_pressed = true
		else:
			gun.button_pressed = false
